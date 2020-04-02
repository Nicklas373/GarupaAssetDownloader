#!/bin/bash
#
# Bandori / Bang Dream! Unity Assets Downloader
#
# Copyright 2020, Dicky Herlambang "Nicklas373" <herlambangdicky5@gmail.com>
#
# This software is licensed under the terms of the GNU General Public
# License version 2, as published by the Free Software Foundation, and
# may be copied, distributed, and modified under those terms.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#

# Declare init folder
Sound="Sound"
Movie="MV"

function main() {
echo " Welcome to GarupaAssetDownloader "
echo " What do you want to do ? "
echo " 1. Download Assets "
echo " 2. Extract Assets "
read choice

if [ "$choice" == "1" ];
	then
		download
elif [ "$choice" == "2" ];
	then
		extract
else
	main
fi
}

function init() {
# Create Folder if not exist
if [ ! -d "$Sound" ];
	then
		mkdir $Sound
		echo "Initial Sound Folder Created"
else
	echo "Initial Sound Folder Already Exist!"
fi

if [ ! -d "$Movie" ];
	then
		mkdir $Movie
		echo "Initial AMV Folder Created"
else
	echo "Initial AMV Folder Already Exist!"
fi
}

function download() {
# Begin Downloading
echo " Which assets that you want to download ?"
echo " 1. Sound / BGM "
echo " 2. AMV / MV "
echo ""
echo " NOTE: Write number only! "
read answer

	if [ "$answer" == "1" ];
		then
			# Downloading BGM / Soundtrack assets
			# Soundtrack assets use uncompressed or RAW assets
			# So it'll need to decompress manually after complete download
			cd Sound

			# Loop for 0 - 9
			for (( i=1; i<=9; i++))
				do
					echo "Downloading Sound Assets..."
					wget -nc https://res.bandori.ga/assets/sound/bgm00$i
			done

			# Loop for 10 - 99
			for (( i=10; i<=99; i++))
				do
					wget -nc https://res.bandori.ga/assets/sound/bgm0$i
			done

			# Loop for 100 - 262
			for (( i=100; i<=262; i++))
				do
					wget -nc https://res.bandori.ga/assets/sound/bgm$i
			done

	elif [ "$answer" == "2" ];
		then
			echo "AMV Assets Manual Download"
			echo ""
			echo "Please Enter AMV Code"
			read code

			# Declare HQ AMV Code
			hq = "_hq"
			# Downloading Anime MV assets
			# AMV Assets isn't in order for now, loop argument will not effective in this cases
			# AMV Assets use uncompressed or RAW assets
			# So it'll need to decompress manually after complete download
			cd ..
			cd Movie
			echo "Downloading Sound Assets..."
			wget -nc https://res.bandori.ga/assets/movie/mv/music_video_$code$hq
	fi

}

function extract() {
# This is looping argument to remove all current file extensions
# From splitted raw assets files, so it can be readed by hjsplit
# Then it can merged and encoded by other apps. Like VGMToolbox or AssetStudioGUI

echo "Please Enter filename"
read ff
echo "Please Enter file extension"
read fe

# Looping for number 0 - 9
for (( j=1; j<=9; j++))
	do
		 mv $ff-00$j.$fe $ff.00$j
	done

# Looping for number 10 - 99
for (( i=10; i<=99; i++ ))
	do
		mv $ff-0$i.$fe $ff.0$i
	done

# Looping for number 100 - 411
for (( k =100; k<=411; k++ ))
	do
		mv $ff-$k.$fe $ff.$j
	done
}

# Run
init
main