#!/bin/bash
set -euo pipefail

test -f /.kconfig && . /.kconfig
test -f /.profile && . /.profile

echo "Configuring SennisOS live image..."

baseCleanMount
suseImportBuildKey

systemctl enable NetworkManager.service
systemctl enable sddm.service
systemctl enable sshd.service

chmod +x /etc/skel/Desktop/*.desktop || true

baseStripUnusedLibs
baseStripUnusedTools
baseStripDocs
baseStripLocales -k en_US -k en

exit 0
