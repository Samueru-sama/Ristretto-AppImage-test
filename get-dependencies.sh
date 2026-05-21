#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm ristretto doxygen rust

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano x265-mini ! llvm ! gdk-pixbuf ! librsvg

pacman -Rdd --noconfirm glycin
git clone https://github.com/QaidVoid/glycin-ng
cd ./glycin-ng
cargo build --release
cargo build --release -p glycin-ng-libglycin-shim
cp -v ./target/release/libglycin_ng.so /usr/lib
cp -v ./target/release/libglycin_2.so  /usr/lib/libglycin-2.so.0

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
#
# if [ "${DEVEL_RELEASE-}" = 1 ]; then
# 	nightly build steps
# else
# 	regular build steps
# fi
