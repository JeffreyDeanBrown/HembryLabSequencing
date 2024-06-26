#!/usr/bin/env bash
#
# install_pear.sh [pear-src*.tar.gz]
#
#
# This will install pear onto a *nix system, including necessary updates to the make files
# written by Jeffrey Brown (brown.jeffrey.dean@gmail.com)
# last updated 05-27-2024

tar -xzf $1
cd pear-src*
autoreconf
automake --add-missing
./configure
make
sudo make install
cd ..
rm pear-src*/ -r
echo -e "\nAll Done!\n"
