#!/bin/bash
set -e
source dependencies.sh
echo "Downloading BYOND version $BYOND_MAJOR.$BYOND_MINOR"
curl "http://spacestation13.github.io/byond-builds/$BYOND_MAJOR/$BYOND_MAJOR.${BYOND_MINOR}_byond.zip" -o C:/byond.zip -A "Apocrypha/1.0 Continuous Integration"
