#!/bin/zsh

rm -r ZipArchive.xcframework
rm -r build
#xcodebuild clean 

echo "Building for macOS"
xcodebuild archive \
-scheme ZipArchive-Mac \
-destination "platform=macOS" \
-archivePath "build/ZipArchive.macOS.xcarchive" \
SKIP_INSTALL=NO

echo "Building for iOS devices (arm64)"
xcodebuild archive \
-scheme ZipArchive-iOS \
-sdk iphoneos \
-destination "generic/platform=iOS" \
-archivePath "build/ZipArchive.iOS.xcarchive" \
SKIP_INSTALL=NO

echo "Building for iOS simulator"
xcodebuild archive \
-scheme ZipArchive-iOS \
-sdk iphonesimulator \
-archivePath "build/ZipArchive.iOS-simulator.xcarchive" \
SKIP_INSTALL=NO

echo "Building for Mac Catalyst"
xcodebuild archive \
-scheme ZipArchive-iOS \
-destination "platform=macOS,variant=Mac Catalyst" \
-archivePath "build/ZipArchive.catalyst.xcarchive" \
SKIP_INSTALL=NO

xcodebuild -create-xcframework \
-framework "build/ZipArchive.macOS.xcarchive/Products/Library/Frameworks/ZipArchive.framework" \
-framework "build/ZipArchive.iOS.xcarchive/Products/Library/Frameworks/ZipArchive.framework" \
-framework "build/ZipArchive.iOS-simulator.xcarchive/Products/Library/Frameworks/ZipArchive.framework" \
-framework "build/ZipArchive.catalyst.xcarchive/Products/Library/Frameworks/ZipArchive.framework" \
-output "ZipArchive.xcframework"

#rm -r build

open .
