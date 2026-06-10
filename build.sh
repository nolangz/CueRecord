#!/bin/bash
set -euo pipefail

SCHEME="CueRecord"
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$PROJECT_DIR/build/release"
ARCHIVE_ARM="$BUILD_DIR/CueRecord-arm64.xcarchive"
ARCHIVE_X86="$BUILD_DIR/CueRecord-x86_64.xcarchive"
APP_NAME="CueRecord.app"
OUTPUT_DIR="$BUILD_DIR/universal"
OUTPUT_APP="$OUTPUT_DIR/$APP_NAME"
DMG_NAME="CueRecord.dmg"
DMG_PATH="$BUILD_DIR/$DMG_NAME"
TEAM_ID="${TEAM_ID:-JKDNYL5U42}"
SIGN_IDENTITY="${SIGN_IDENTITY:-Developer ID Application: NUOLIN LAI (JKDNYL5U42)}"
NOTARY_PROFILE="${NOTARY_PROFILE:-cuerecord-notary}"

echo "🔎 Checking Developer ID identity…"
if ! security find-identity -v -p codesigning | grep -F "$SIGN_IDENTITY" >/dev/null; then
  echo "error: Missing signing identity: $SIGN_IDENTITY"
  exit 1
fi

echo "🔎 Checking notarization credentials…"
xcrun notarytool history --keychain-profile "$NOTARY_PROFILE" >/dev/null

echo "🧹 Cleaning previous build…"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR" "$OUTPUT_DIR"

echo "🔨 Building for Apple Silicon (arm64)…"
xcodebuild archive \
  -project "$PROJECT_DIR/CueRecord.xcodeproj" \
  -scheme "$SCHEME" \
  -configuration Release \
  -archivePath "$ARCHIVE_ARM" \
  -destination "generic/platform=macOS" \
  ARCHS=arm64 \
  ONLY_ACTIVE_ARCH=NO \
  SKIP_INSTALL=NO \
  CODE_SIGN_STYLE=Manual \
  CODE_SIGN_IDENTITY="$SIGN_IDENTITY" \
  DEVELOPMENT_TEAM="$TEAM_ID" \
  ENABLE_HARDENED_RUNTIME=YES \
  -quiet

echo "🔨 Building for Intel (x86_64)…"
xcodebuild archive \
  -project "$PROJECT_DIR/CueRecord.xcodeproj" \
  -scheme "$SCHEME" \
  -configuration Release \
  -archivePath "$ARCHIVE_X86" \
  -destination "generic/platform=macOS" \
  ARCHS=x86_64 \
  ONLY_ACTIVE_ARCH=NO \
  SKIP_INSTALL=NO \
  CODE_SIGN_STYLE=Manual \
  CODE_SIGN_IDENTITY="$SIGN_IDENTITY" \
  DEVELOPMENT_TEAM="$TEAM_ID" \
  ENABLE_HARDENED_RUNTIME=YES \
  -quiet

ARM_APP="$ARCHIVE_ARM/Products/Applications/$APP_NAME"
X86_APP="$ARCHIVE_X86/Products/Applications/$APP_NAME"

echo "🧬 Creating universal binary…"
cp -R "$ARM_APP" "$OUTPUT_APP"

# Find all Mach-O binaries and lipo them together
find "$ARM_APP" -type f | while read -r arm_file; do
  rel="${arm_file#$ARM_APP}"
  x86_file="$X86_APP$rel"
  out_file="$OUTPUT_APP$rel"

  if [ -f "$x86_file" ] && file "$arm_file" | grep -q "Mach-O"; then
    lipo -create "$arm_file" "$x86_file" -output "$out_file" 2>/dev/null || true
  fi
done

echo "🔏 Signing universal app…"
find "$OUTPUT_APP" -type f -print0 | while IFS= read -r -d '' file; do
  if file "$file" | grep -q "Mach-O"; then
    codesign \
      --force \
      --sign "$SIGN_IDENTITY" \
      --timestamp \
      --options runtime \
      "$file"
  fi
done
codesign \
  --force \
  --sign "$SIGN_IDENTITY" \
  --timestamp \
  --options runtime \
  --entitlements "$PROJECT_DIR/CueRecord/CueRecord.entitlements" \
  "$OUTPUT_APP"
codesign --verify --deep --strict --verbose=2 "$OUTPUT_APP"

echo "📦 Creating DMG…"
rm -f "$DMG_PATH"

# Create a temporary DMG folder with the app and an Applications symlink
DMG_STAGING="$BUILD_DIR/dmg_staging"
rm -rf "$DMG_STAGING"
mkdir -p "$DMG_STAGING"
cp -R "$OUTPUT_APP" "$DMG_STAGING/"
ln -s /Applications "$DMG_STAGING/Applications"

hdiutil create \
  -volname "CueRecord" \
  -srcfolder "$DMG_STAGING" \
  -ov \
  -format UDZO \
  "$DMG_PATH" \
  -quiet

rm -rf "$DMG_STAGING"

echo "🔏 Signing DMG…"
codesign --force --sign "$SIGN_IDENTITY" --timestamp "$DMG_PATH"
codesign --verify --verbose=2 "$DMG_PATH"

echo "📤 Submitting DMG for notarization…"
xcrun notarytool submit "$DMG_PATH" \
  --keychain-profile "$NOTARY_PROFILE" \
  --wait

echo "📎 Stapling notarization ticket…"
xcrun stapler staple "$DMG_PATH"
xcrun stapler validate "$DMG_PATH"
spctl --assess --type open --context context:primary-signature --verbose "$DMG_PATH"
spctl --assess --type execute --verbose "$OUTPUT_APP"

echo ""
echo "✅ Done!"
echo "   App:  $OUTPUT_APP"
echo "   DMG:  $DMG_PATH"
echo ""
lipo -info "$OUTPUT_APP/Contents/MacOS/CueRecord"
