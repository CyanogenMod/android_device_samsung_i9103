#!/bin/bash

# requiere stream tool :
# aptitude install imagemagick

function extract_rgb16()
{
	DIMENSIONS=`identify $1 | awk '{print $3}'`
	WIDTH=`echo $DIMENSIONS | awk -Fx '{print $1}'`
	HEIGHT=`echo $DIMENSIONS | awk -Fx '{print $2}'`
	NAME=`echo $1 | sed 's/\..*//'`
	echo $NAME $WIDTH x $HEIGHT;
	convert -colorspace RGB $1 - | stream -map rgb -storage-type char - - | \
			./24to16 | gzip -9c | ./bin2c $NAME $WIDTH $HEIGHT > ${NAME}.h
}

function extract_ai()
{
	DIMENSIONS=`identify $1 | awk '{print $3}'`
	WIDTH=`echo $DIMENSIONS | awk -Fx '{print $1}'`
	HEIGHT=`echo $DIMENSIONS | awk -Fx '{print $2}'`
	NAME=`echo $1 | sed 's/\..*//' | sed 's/\//_/'`
	echo $NAME $WIDTH x $HEIGHT;
	convert -colorspace Gray $1 - | stream -map a -storage-type char - - | \
			gzip -9c | ./bin2c ${NAME}_a $WIDTH $HEIGHT > ${NAME}.h
	convert -colorspace Gray $1 - | stream -map i -storage-type char - - | \
			gzip -9c | ./bin2c ${NAME}_i $WIDTH $HEIGHT >> ${NAME}.h
}

# need fix :/
function extract_ai_text()
{
	DIMENSIONS=`identify $1 | awk '{print $3}'`
	WIDTH=`echo $DIMENSIONS | awk -Fx '{print $1}'`
	HEIGHT=`echo $DIMENSIONS | awk -Fx '{print $2}'`
	NAME=`echo $1 | sed 's/\..*//' | sed 's/\//_/'`
	echo $NAME $WIDTH x $HEIGHT;
	convert -colorspace RGB $1 - | stream -map a -storage-type char - - | \
			gzip -9c | ./bin2c ${NAME}_a $WIDTH $HEIGHT > ${NAME}.h
	convert -colorspace Gray $1 - | stream -map rbg -storage-type char - - | \
			gzip -9c | ./bin2c ${NAME}_i $WIDTH $HEIGHT >> ${NAME}.h
}

function extract_rgb16_strip()
{
	# Stored in an animated GIF, but only last frame looks valid
	convert -colorspace RGB -type TrueColor $1 /tmp/temp-extract.png
	DIMENSIONS=`identify /tmp/temp-extract-4.png | awk '{print $3}'`
	WIDTH=`echo $DIMENSIONS | awk -Fx '{print $1}'`
	HEIGHT=`echo $DIMENSIONS | awk -Fx '{print $2}'`
	NAME=`echo $1 | sed 's/\..*//'`
	stream -map rgb -storage-type char /tmp/temp-extract-4.png - | \
			./24to16 | gzip -9c | ./bin2c $NAME $WIDTH $HEIGHT > ${NAME}.h
	rm -f /tmp/temp-extract-*.png
}

function extract_rgb16_ani()
{
	NAME=`echo $1 | sed 's/\..*//'`
	convert -colorspace RGB -type TrueColor $1 /tmp/temp-extract.png
	rm -f ${NAME}.h
	touch ${NAME}.h
	let x=0
	for j in 0 1 2 3; do
		foo="/tmp/temp-extract-$j.png"
		DIMENSIONS=`identify $foo | awk '{print $3}'`
		WIDTH=`echo $DIMENSIONS | awk -Fx '{print $1}'`
		HEIGHT=`echo $DIMENSIONS | awk -Fx '{print $2}'`
		stream -map rgb -storage-type char $foo - | \
			./24to16 | gzip -9c | ./bin2c ${NAME}_$x $WIDTH $HEIGHT >> ${NAME}.h
		echo >> ${NAME}.h
		let x++
	done

	let x=0
	echo "struct asset *${NAME}[] = {" >> ${NAME}.h
	for foo in /tmp/temp-extract-*.png; do
		echo "	&${NAME}_$x," >> ${NAME}.h
		let x++
	done
	echo "	NULL" >> ${NAME}.h
	echo "};" >> ${NAME}.h

	rm -f /tmp/temp-extract-*.png
}

extract_rgb16 battery_charge_background.png

for foo in ic_pane_*.png; do
	extract_ai $foo
done

for foo in battery_*_img.png; do
	extract_rgb16 $foo
done

for foo in battery_*_ani.gif; do
	extract_rgb16_ani $foo
done

for foo in $(ls -1 battery_numbers/*.png); do
	extract_ai_text $foo
done
