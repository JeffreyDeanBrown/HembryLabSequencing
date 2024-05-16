# This will install pear version 9.11 onto any unix system, including necessary updates to the make files
# written by Jeffrey Brown (brown.jeffrey.dean@gmail.com)
# last updated 05-16-2024

tar -xzf $1
cd pear-src*
autoreconf
automake --add-missing
./configure
make
sudo make install
rm pear-src*/*
rmdir pear-src*/
echo -e "\nAll Done!\n"
