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
Asset="Asset"
Done="Done"

function main() {
echo ""
echo " Welcome to GarupaAssetDownloader "
echo " What do you want to do ? "
echo " 1. Download Assets "
echo " 2. Join Assets "
echo " 3. Cleanup "
echo " 4. Exit "
echo ""
read choice

if [ "$choice" == "1" ];
	then
		download
elif [ "$choice" == "2" ];
	then
		join
elif [ "$choice" == "3" ];
	then
		if [ ! -d "$Sound" ];
			then
				echo "Sound folder wasn't exist, please download the assets first!"
				download
		else
			echo "Okay, Checking up :3"
			cleanup_phase_1
			cleanup_phase_2
			cleanup_phase_3
		fi
elif [ "$choice" == "4" ];
	then
		exit 1
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

if [ ! -d "$Asset" ];
	then
		mkdir $Asset
		echo "Initial Asset Folder Created"
else
	echo "Initial Asset Folder Already Exist!"
fi

if [ ! -d "$Done" ];
	then
		mkdir $Done
		echo "Initial Finish Folder Created"
else
	echo "Initial Finished Folder Already Exist!"
fi
}

function download() {
# Begin Downloading
echo ""
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
					wget -nc https://res.bandori.ga/assets-jp/sound/bgm00$i
			done

			# Cleaning unused files on first loop
			cleanup_phase_1

			# Loop for 10 - 99
			for (( i=10; i<=99; i++))
				do
					echo "Downloading Sound Assets..."
					wget -nc https://res.bandori.ga/assets-jp/sound/bgm0$i
			done

			# Cleanng unused files on second loop
			cleanup_phase_2

			# Loop for 100 - 299
			for (( i=100; i<=299; i++))
				do
					echo "Downloading Sound Assets..."
					wget -nc https://res.bandori.ga/assets-jp/sound/bgm$i
			done

			# Cleanup unused files on third loop
			cleanup_phase_3

	elif [ "$answer" == "2" ];
		then
			echo ""
			echo "AMV Assets Manual Download"
			echo ""
			echo "Please Enter AMV Code"
			read code

			# Downloading Anime MV assets
			# AMV Assets isn't in order for now, loop argument will not effective in this cases
			# AMV Assets use uncompressed or RAW assets
			# So it'll need to decompress manually after complete download
			cd MV

			echo "Downloading HQ AMV Assets..."
			wget -nc https://res.bandori.ga/assets-jp/movie/mv/music_video_$code"_hq"

			# Declare video name for HQ AMV file
			video_hq="music_video_$code""_hq"
			video_o_hq="music_video_$code""(2)"
			video="music_video_$code"

			if [ -f "$video_hq" ];
				then
					echo "HQ AMV Asset with code $code already downloaded on MV Folder :3"
			else
					echo "HQ AMV Assets Not Found !"
					echo "Downloading Alternate HQ AMV Assets..."

					wget -nc https://res.bandori.ga/assets-jp/movie/mv/music_video_$code"(2)"

				if [ -f "$video_o_hq" ];
					then
						echo "Alternate HQ AMV Asset with code $code already downloaded on MV Folder :3"
				else
						echo "Alternate HQ AMV Assets Not Found, Downloading Standard AMV Assets"
						wget -nc https://res.bandori.ga/assets-jp/movie/mv/music_video_$code

						if [[ -f "$video" ]];
							then
								echo "AMV Asset with code $code already downloaded on MV Folder :3"
						else
							echo "This AMV Asset with code $code isn't available..."
						fi
				fi
			fi
	fi

	# Back to main function
	cd ..
	main

}

function join() {
# This is looping argument to remove all current file extensions
# From splitted raw assets files, so it can be readed by hjsplit
# Then it can merged and encoded by other apps. Like VGMToolbox or AssetStudioGUI

cd Asset

echo "NOTE: Please Import Part Files on Asset Folder"
echo ""
echo "Please Enter filename"
read ff
echo "Please Enter file extension"
read fe
echo "How much part for that assets ?"
read k

if (("$k"<"10"))
	then
		# Initiate looping
		n="$k"

		# Looping for number 0 - user defined
		for (( j=1; j<$n; j++))
			do
				 mv $ff-00$j.$fe $ff.00$j
		done
elif (("$k">="10" && "$k" <="99"))
	then
		# Initiate looping
		n="10"
		m="$k"

		# Looping for number 0 - user defined
		for (( j=1; j<$n; j++))
			do
				 mv $ff-00$j.$fe $ff.00$j
		done

		# Looping for number 10 - user defined
		for (( i=10; i<=$m; i++ ))
			do
				mv $ff-0$i.$fe $ff.0$i
		done

elif (("$k">="100"))
	then
		# Initiate looping
		n="10"
		m="99"
		l="$k"

		# Looping for number 0 - user defined
		for (( j=1; j<$n; j++))
			do
		 		mv $ff-00$j.$fe $ff.00$j
		done

		# Looping for number 10 - user defined
		for (( i=10; i<=$m; i++ ))
			do
				mv $ff-0$i.$fe $ff.0$i
		done

		# Looping for number 100 - user defined
		for (( k=100; k<=$l; k++ ))
			do
				mv $ff-$k.$fe $ff.$k
		done
else
	echo "undefined part of assets O_o"
fi

echo "Your asset $ff.$fe already renamed !"

cd ..

# Return to main program
main
}

function cleanup_phase_1() {
# This function will remove bgm file
# That size are less than 1 MB

# Change to sound directory
cd Sound

# Init filename
filename=bgm
filename_start=00
maxsize=1048576 # 1 MB

# Looping phase start
# Phase 0-10
for (( j=1; j<10; j++))
	do
		file=$filename$filename_start$j
		filesize=$(stat -c%s "$file")

		if [ $(stat --printf="%s" $file) -lt $maxsize ];
			then
				echo "$file was removed due less than 1MB, size is $filesize bytes"
				rm $file
		else
			echo "Size of $file = $filesize bytes."
		fi
done
}

function cleanup_phase_2() {
# This function will remove bgm file
# That size are less than 1 MB

# Init filename
filename=bgm
filename_start=0
maxsize=1048576 # 1 MB

# Looping phase start
# Phase 0-10
for (( j=11; j<=99; j++))
	do
		file=$filename$filename_start$j
		filesize=$(stat -c%s "$file")

		if [ $(stat --printf="%s" $file) -lt $maxsize ];
			then
				echo "$file was removed due less than 1MB, size is $filesize bytes"
				rm $file
		else
			echo "Size of $file = $filesize bytes."
		fi
done
}

function cleanup_phase_3() {
# This function will remove bgm file
# That size are less than 1 MB

# Init filename
filename=bgm
maxsize=1048576 # 1 MB

# Looping phase start
# Phase 0-10
for (( j=100; j<283; j++))
	do
		file=$filename$j
		filesize=$(stat -c%s "$file")

		if [ $(stat --printf="%s" $file) -lt $maxsize ];
			then
				echo "$file was removed due less than 1MB, size is $filesize bytes"
				rm $file
		else
			echo "Size of $file = $filesize bytes."
		fi
done

# Back to main directory
cd ..

echo "Cleanup done :3"

# Run main program
main
}

# Run
init
main
