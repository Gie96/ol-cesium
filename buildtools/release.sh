#!/bin/sh -e

BUILD=.build/olcs_build

make dist

VERSION=ol-cesium-v`buildtools/get-version.sh version | cut -d. -f1-2`
cp -R dist/ $VERSION && zip -r $VERSION.zip $VERSION; rm -rf $VERSION`

mkdir -p $BUILD
cp -R src/olcs/* $BUILD 
cp ./css/olcs.css $BUILD
cp package.json $BUILD
sed -i 's/ol-cesium/olcs/g' $BUILD/package.json
sed -i '/"main"/d' $BUILD/package.json

echo
ls $BUILD
head $BUILD/package.json

echo
echo "Check everything is correct and publish to npm"
echo "cd $BUILD"
echo npm publish
echo "cd ..; rm -rf $BUILD"
echo "npm publish"
echo buildtools/publish-website.sh
echo
echo "In addition, create the release on github and announce it"