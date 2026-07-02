#!/bin/bash
set -eo pipefail

test -f /.kconfig && . /.kconfig
test -f /.profile && . /.profile

echo "Configuring SennisOS live image..."

suseImportBuildKey

systemctl enable NetworkManager.service
systemctl enable sddm.service || true
systemctl enable sshd.service

# No sshd-gen-keys-start unit in this image, so pre-generate host keys
# at build time (otherwise sshd fails to start entirely, no host keys).
ssh-keygen -A

chmod +x /etc/skel/Desktop/*.desktop || true

# glibc's vendor default nsswitch.conf isn't being materialized to /etc
# during this build (root cause under investigation) -- without it NSS
# lookups can misbehave, so guarantee it exists.
if [ ! -f /etc/nsswitch.conf ] && [ -f /usr/etc/nsswitch.conf ]; then
    cp /usr/etc/nsswitch.conf /etc/nsswitch.conf
fi

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
baseStripLocales en_US en

exit 0
