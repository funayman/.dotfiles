#!/bin/sh

mv -v ${HOME}/.local/share/icons ${HOME}/.local/share/icons.bak
mkdir icons

# Marwaita Icons
MARWAITA_VERSION=4.8
MARWAITA_ZIP=marwaita-${MARWAITA_VERSION}.zip
curl -L -o ${MARWAITA_ZIP} "https://github.com/darkomarko42/Marwaita-Icons/archive/refs/tags/${MARWAITA_VERSION}.zip"
unzip ${MARWAITA_ZIP}

for d in ./Marwaita-Icons-${MARWAITA_VERSION}/*/; do
  mv -v "$d" icons/.
done

rm -rf ${MARWAITA_ZIP} Marwaita-Icons-${MARWAITA_VERSION}

ln -s ${PWD}/icons ${HOME}/.local/share/icons
