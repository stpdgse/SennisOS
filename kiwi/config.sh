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

# Point Calamares at the SennisOS branding component (the real bird, everywhere)
if [ -f /etc/calamares/settings.conf ]; then
    sed -i 's/^branding: .*/branding: sennistex/' /etc/calamares/settings.conf
fi

# Boot menu background for the installed system's GRUB (real photo, not the openSUSE default)
if [ -f /etc/default/grub ]; then
    if grep -q '^GRUB_BACKGROUND=' /etc/default/grub; then
        sed -i 's#^GRUB_BACKGROUND=.*#GRUB_BACKGROUND="/boot/grub2/sennistex-bg.png"#' /etc/default/grub
    else
        echo 'GRUB_BACKGROUND="/boot/grub2/sennistex-bg.png"' >> /etc/default/grub
    fi
fi

baseStripUnusedLibs
baseStripUnusedTools
baseStripDocs
baseStripLocales -k en_US -k en

exit 0
