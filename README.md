# Bandori / Bang Dream! Girls Band Party A/V Assets Downloader Based on Bash
This is a linux based script that can download ACB or USM assets files for BGM / Sound and AMV from https://bandori.top/ as a RAW assets.

# How it's work :
1. User will need to choice if they want to download or extract assets
2. If user want to download, then script will ask if user want to download audio or video assets
3. Script will download current user choice as batch process (For audio it'll download all audio files in 1 job)
4. For Video, user will need to enter video name that exist on https://bandori.top/. 
	ex: https://bandori.top/music/jp/217
		then video name is 217
5. It's same with extract option, which need user enter filename to rename all splitted file

# What's next:
1. After Download complete for audio, user will need to open that file with AssetStudio App
2. Open AssetStudio -> File -> Load File -> "Choose that file from sound or movie folder" -> Open
   -> Go to Asset List -> Choose Export -> All Assets -> Choose your directory -> Done
3. Go to TextAsset folder, and you should see your uncompressed file with extension .acb.bytes for audio and .usm.bytes for video.
   If you find some file with multiple parts or splitted files then you'll need to rename and join it with hjsplit

# For Splitted Cases // It'll same for Audio or Video Assets
1. Copy GarupaAssetDownloader.sh to TextAsset Folder
2. Run then choose extract assets
3. Enter filename (ex: bgm133), Enter file extensions (ex: acb.bytes)
4. Wait till complete
5. Open HJ-Split then choose join (Select your filename with extension .001)
6. Start process and wait, it'll give output file without 001 naming again
7. Go to normal cases (You can remove all files with 001 naming scheme after have joined files)

# For Normal Cases
1. Open VGMToolbox -> Misc Tools
	For audio: -> Common Archives -> CRI ACB/AWB Archives -> Select that downloaded or joined files then drag and drop to
				VGMToolbox window -> It should show folder _vgmt_acb_ext_Filename -> Open that folder then go to acb folder
				-> grab that HCA Files -> Install Foobar2000 on windows -> Download vgmstream plugin then install on foobar as
				plugin -> Open that HCA Files using Foobar200 -> Convert that HCA files from Foobar2000 to your current choice as
				audio format. Done
	
	For Video: -> Stream Tools -> Video Demultiplexer -> Select that downloaded or joined files then drag and drop to
				VGMToolbox window -> It should show folder _vgmt_usm_ext_Filename -> Open that folder then go to usm folder
				-> grab that m2v Files -> Done


# Additional Software
1. [Assets Bundle Extractor](https://github.com/DerPopo/UABE/releases/download/2.2stableb/AssetsBundleExtractor_2.2stableb_64bit.zip)
2. [Asset Studio GUI](https://github.com/Perfare/AssetStudio)
3. [hjsplit](https://dl6.filehippo.com/566/04d/00b9565ac4782898df40ce49797b3c5205/hjsplit.zip?expires=1585872076&signature=87bf23c7d0bad07850b369f687e41ad4&url=https%3A%2F%2Ffilehippo.com%2Fdownload_hjsplit%2F&filename=hjsplit.zip)
4. [VGMToolbox](https://sourceforge.net/projects/vgmtoolbox/)

# NOTE:
1. This script still on initial stage, so some bugs and issue may come
2. Recent file count still statically updated, so it'll need manual way to re-write on script to download new file revision

# Thanks to :
- https://github.com/BandoriDatabase (For provide majority needs :3)
- https://bangdream.ga (For provide majority needs :3)
- https://github.com/Perfare/AssetStudio (For Assets tool extractor)
- https://github.com/DerPopo/UAB (For Assets tool extractor)
- Stackoverflow (Troubleshooter :'3)
- And any other source that i kang and forget to tell it here :'v
