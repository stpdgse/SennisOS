#!/bin/bash
set -euo pipefail

SRC="/mnt/c/Users/0x4E736280/Desktop/SennisOS/Assets/Logo-And-Mascot.jpg"
OUT="/mnt/c/Users/0x4E736280/Desktop/SennisOS/kiwi/root"

magick "$SRC" -resize 1920x1080^ -gravity center -extent 1920x1080 "$OUT/usr/share/wallpapers/SennisTex/contents/images/1920x1080.png"
cp "$OUT/usr/share/wallpapers/SennisTex/contents/images/1920x1080.png" "$OUT/boot/grub2/sennistex-bg.png"

magick "$SRC" -resize 900x900 "$OUT/usr/share/plymouth/themes/sennistex/bird.png"

magick "$SRC" -resize 512x512^ -gravity center -extent 512x512 "$OUT/usr/share/icons/hicolor/256x256/apps/sennistex-logo-512.png"
for size in 16 32 48 64 128 256; do
  mkdir -p "$OUT/usr/share/icons/hicolor/${size}x${size}/apps"
  magick "$OUT/usr/share/icons/hicolor/256x256/apps/sennistex-logo-512.png" -resize ${size}x${size} "$OUT/usr/share/icons/hicolor/${size}x${size}/apps/sennistex-logo.png"
done
rm "$OUT/usr/share/icons/hicolor/256x256/apps/sennistex-logo-512.png"
cp "$OUT/usr/share/icons/hicolor/128x128/apps/sennistex-logo.png" "$OUT/usr/share/pixmaps/sennistex-logo.png"

cp "$OUT/usr/share/icons/hicolor/256x256/apps/sennistex-logo.png" "$OUT/usr/share/calamares/branding/sennistex/logo.png"
cp "$OUT/usr/share/wallpapers/SennisTex/contents/images/1920x1080.png" "$OUT/usr/share/calamares/branding/sennistex/welcome.png"

echo DONE
identify "$OUT/usr/share/wallpapers/SennisTex/contents/images/1920x1080.png" "$OUT/usr/share/plymouth/themes/sennistex/bird.png" "$OUT/usr/share/icons/hicolor/256x256/apps/sennistex-logo.png"
