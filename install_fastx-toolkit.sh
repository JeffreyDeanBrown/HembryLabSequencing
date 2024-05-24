# This script is written to install the FastX-Toolkit and it's libraries, including patching and updating the code to make it usable
# Written by Jeffrey Brown (brown.jeffrey.dean@gmail.com) 
# Last updated 05-23-2024 

curl https://github.com/agordon/libgtextutils/releases/download/0.7/libgtextutils-0.7.tar.gz
curl https://github.com/agordon/fastx_toolkit/releases/download/0.0.14/fastx_toolkit-0.0.14.tar.bz2
tar -xzf libgtextutils-0.7.tar.gz
cd libgtextutils-0.7/
sed -i '' '47s/input_stream/static_cast<bool>(input_stream)/' src/gtextutils/text_line_reader.cpp
./configure
make
sudo make install
cd ..
rm -r libgtextutils-0.7/
rm libgtextutils-0.7.tar.gz
#download patch script
tar -xjf fastx_toolkit-0.0.14.tar.bz2
cd fastx_toolkit-0.0.14/
curl https://raw.githubusercontent.com/JeffreyDeanBrown/HembryLabSequencing/main/MacOSPatch.txt
patch < MacOSPatch.txt
curl https://github.com/agordon/fastx_toolkit/files/1182724/fastx-toolkit-gcc7-patch.txt
patch  -p1 < fastx-toolkit-gcc7-patch.txt
./configure
make
sudo make install
cd ..
rm -r fastx_toolkit-0.0.14/
rm fastx_toolkit-0.0.14.tar.bz2
echo -e "\nAll Done! \n"

