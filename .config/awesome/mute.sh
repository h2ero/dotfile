#!/bin/sh

MV_record="/tmp/MasterVolume";

if [ -r ${MV_record} ]; then
    if [ $(cat ${MV_record}) -gt 0 ]; then
        amixer set Master $(cat ${MV_record});
        echo 0 > ${MV_record};
    else
        amixer get Master | sed "1,4d" | sed "s/.*Playback \([^ ]\+\) .*/\1/g" > ${MV_record};
        amixer set Master 0;
    fi
else
    amixer get Master | sed "1,4d" | sed "s/.*Playback \([^ ]\+\) .*/\1/g" > ${MV_record};
    amixer set Master 0;
fi

