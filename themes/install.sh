#!/bin/sh

mkdir themes
mv -v ${HOME}/.themes ${HOME}/.themes.bak 2>/dev/null || true

# Marwaita Debian Themes
MARWAITA_VERSION=16.2
MARWAITA_ZIP=marwaita-${MARWAITA_VERSION}.zip
curl -L -o ${MARWAITA_ZIP} "https://github.com/darkomarko42/Marwaita-Debian/archive/refs/tags/${MARWAITA_VERSION}.zip"
unzip ${MARWAITA_ZIP}

for d in ./Marwaita-Debian-${MARWAITA_VERSION}/*/; do
  mv -v "$d" themes/.
done

rm -rf ${MARWAITA_ZIP} Marwaita-Debian-${MARWAITA_VERSION}

# Nordic Themes

###############################################################################
###############################################################################
###############################################################################

ln -s ${PWD}/themes ${HOME}/.themes
