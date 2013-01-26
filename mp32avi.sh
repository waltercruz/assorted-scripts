#!/bin/bash
## http://efreedom.com/Question/3-187985/Join-Audio-Image-Output-Video-Using-FFmpeg
#ffmpeg -loop_input -vframes 12810 -i 51PyEo6NyTL._SL500_AA300_.jpg -i Bill\ Evans\ \(Loose\ Blues\)\ 01\ Loose\ Blues.mp3 -y -r 30 -b 2500k -acodec ac3 -ab 384k -vcodec mpeg4 result.mp4

FFMPEG=`which ffmpeg`
if [ "$FFMPEG" = "" ] ; then
	echo "Please install ffmpeg.";
	exit 0;
fi
if [ $# != 3 ] ; then
	echo "Usage: $0 <image_file> <mp3_file> <output_file.avi>";
	exit 0;
fi
if [ ! -f $1 ] ; then
	echo "Source image '$1' not found.";
	exit 0;
fi
if [ ! -f $2 ] ; then
	echo "Source mp3 '$2' not found.";
	exit 0;
fi
if [ -f $3 ] ; then
	echo "Output file '$3' exists.  Overwrite? (y/n)";
	read CONFIRM
	if [ "$CONFIRM" == "y" ] ; then
		echo "Overwriting '$3'"
	else
		if [ "$CONFIRM" == "Y" ] ; then
			echo "Overwriting '$3'"
		else
			echo "Operation canceled.";
			exit 0;
		fi
	fi
fi
TIME=`$FFMPEG -i "$2" 2>&1 | grep 'Duration' | awk '{ print $2; }' | sed -e 's/,//g'`
$FFMPEG -loop 1 -i "$1" -i "$2" -acodec copy -y -t $TIME "$3"
