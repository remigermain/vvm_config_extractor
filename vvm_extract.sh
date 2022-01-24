#!/usr/bin/env bash

if ! command -v java &>/dev/null ; then
	echo "you need openjdk 8+"
	exit 1
fi

path=$(pwd)

rm -rf /tmp/vvm_extract
mkdir /tmp/vvm_extract

cd /tmp/vvm_extract

dialer_link="https://www.apkmirror.com/wp-content/uploads/2022/01/19/61e767d4c7f0d/com.google.android.dialer_74.0.420887281-publicbeta-downloadable-8401763_minAPI28(arm64-v8a)(nodpi)_apkmirror.com.apk?verify=1643048195-JjqKGya6fmrRrtlImlkw5HZ04bOKYEghSgnM9VEV4g0"

dialer_name="com.google.android.dialer"
echo "download dialer"
wget -O $dialer_name $dialer_link &>/dev/null
if [ ! -f "$dialer_name" ]; then
	echo "error downloading $dialer_name"
	exit 1
fi

apktool_link="https://github.com/iBotPeaches/Apktool/releases/download/v2.6.0/apktool_2.6.0.jar"
apktool_name="apktool_2.6.0.jar"
echo "download apktool"
wget $apktool_link
if [ ! -f "$apktool_name" ]; then
	echo "error downloading apktool"
	exit 1
fi

echo "extract apk"
# apktool add .out a end of file
java -jar $apktool_name decode "$dialer_name.out"
cp -r "$dialer_name/res/xml/vvm_config.xml" "$path/vvm_config.xml"

#rm -rf /tmp/vvm_extract
echo "vvm_config extracted to $path"
