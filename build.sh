#!/bin/bash

VERSION="2.2.0"

cleanup () {
    rm -rf -- "$TEMP"
    hdiutil detach -force "$TEMP/mnt" > /dev/null 2>&1
}
trap cleanup EXIT

rm -rf payload/*
mkdir -p payload/usr/local/etc/lsfilter

TEMP=$(mktemp -d)

mkdir -p "$TEMP/mnt"

hdiutil attach "SmartAgent-$VERSION.dmg" -mountpoint "$TEMP/mnt"

pkgutil --expand-full "$TEMP/mnt/SmartAgent.pkg" "$TEMP/pkg"

cp "$TEMP/mnt/.sajs/lsconfig.json" payload/usr/local/etc/lsfilter/lsconfig.json

hdiutil detach "$TEMP/mnt"

cp -R "$TEMP/pkg/ExtensionInstaller.pkg/Payload/Applications" payload/
cp -R "$TEMP/pkg/ExtensionInstaller.pkg/Payload/Library" payload/

cp -R "$TEMP/pkg/Setup.pkg/Payload/Library/LaunchDaemons" payload/Library/
cp -R "$TEMP/pkg/Setup.pkg/Payload/Applications/.lightspeed-agent" payload/Applications/
cp -R "$TEMP/pkg/Setup.pkg/Payload/usr/local/bin" payload/usr/local/

./munkipkg .
