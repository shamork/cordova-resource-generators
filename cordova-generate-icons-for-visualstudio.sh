#!/bin/bash
# Generate Cordova icons
# refer:https://msdn.microsoft.com/en-us/library/dn757053.aspx

function usage() {
	echo "usage: $0 <image-filename> [output-directory]";
	exit 1;
}

[ "$1" ] || usage
[ "$2" ] || set "$1" "."

image=$1
output=$2/res/icons

devices=ios,android,windows,wp8 #,windows-phone,bada,bada-wac,blackberry,webos
eval mkdir -p "$output/{$devices}"

# Show the user some progress by outputing all commands being run.
set -x

# Explicitly set background in case image is transparent (see: #3)
convert="convert $image -background none"

function androidConvertIcon() {
	
	eval mkdir -p "$output/android"

	$convert -resize 36x36 "$output/android/icon-36-ldpi.png"
	$convert -resize 48x48 "$output/android/icon-48-mdpi.png"
	$convert -resize 72x72 "$output/android/icon-72-hdpi.png"
	$convert -resize 96x96 "$output/android/icon-96-xhdpi.png"


	function androidCopyIcon() {
		androidOutput=$(find . -type d | grep "platforms/android/res$")
		find . -type d | grep "resources/icon/android/drawable" | xargs -I{} cp -R {} $androidOutput
	}
	#androidCopyIcon
}
androidConvertIcon

function iosConvertIcon() {
	$convert -resize 29x29 "$output/ios/icon-small.png"
	$convert -resize 40x40 "$output/ios/icon-40.png"
	$convert -resize 50x50 "$output/ios/icon-50.png"
	$convert -resize 57x57 "$output/ios/icon-57.png"
	$convert -resize 58x58 "$output/ios/icon-small-2x.png"
	$convert -resize 60x60 "$output/ios/icon-60.png"
	$convert -resize 72x72 "$output/ios/icon-72.png"
	$convert -resize 76x76 "$output/ios/icon-76.png"
	$convert -resize 80x80 "$output/ios/icon-40-2x.png"
	$convert -resize 100x100 "$output/ios/icon-50-2x.png"
	$convert -resize 114x114 "$output/ios/icon-57-2x.png"
	$convert -resize 120x120 "$output/ios/icon-60-2x.png"
	$convert -resize 144x144 "$output/ios/icon-72-2x.png"
	$convert -resize 152x152 "$output/ios/icon-76-2x.png"
	#$convert -resize 512x512 "$output/ios/iTunesArtwork.png"
	#$convert -resize 1024x1024 "$output/ios/iTunesArtwork-2x.png"

	function iosCopyIcon() {
		cp $(find . | grep "resources/icon/ios/.*\.png") "$(find . -type d | grep 'platforms/ios/.*Resources/icons')"
	}
	#iosCopyIcon
}
iosConvertIcon

function wp8ConvertIcon() {
	
	eval mkdir -p "$output/wp8"

	$convert -resize 62x62 "$output/wp8/ApplicationIcon.png"
	$convert -resize 173x173 "$output/wp8/Background.png"

	function wp8CopyIcon() {
		wp8Output=$(find . -type d | grep "platforms/wp8/res$")
		find . -type d | grep "resources/icon/wp8/drawable" | xargs -I{} cp -R {} $wp8Output
	}
	#wp8CopyIcon
}
wp8ConvertIcon
# windows and windows 8.1
function windowsConvertIcon() {
	
	eval mkdir -p "$output/windows"

	$convert -resize 360x360 "$output/windows/Square150x150Logo.scale-240.png"
	$convert -resize 106x106 "$output/windows/Square44x44Logo.scale-240.png"
	$convert -resize 170x170 "$output/windows/Square71x71Logo.scale-240.png"
	$convert -resize 120x120 "$output/windows/StoreLogo.scale-240.png"
	$convert -resize 744x360 "$output/windows/Wide310x150Logo.scale-240.png"
	$convert -resize 30x30 "$output/windows/smalllogo.png"
	$convert -resize 50x50 "$output/windows/storelogo.png"
	$convert -resize 744x360 "$output/windows/Wide310x150Logo.scale-240.png"

	function windowsCopyIcon() {
		windowsOutput=$(find . -type d | grep "platforms/windows/res$")
		find . -type d | grep "resources/icon/windows/drawable" | xargs -I{} cp -R {} $windowsOutput
	}
	#windowsCopyIcon
}
windowsConvertIcon
