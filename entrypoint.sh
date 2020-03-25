#!/bin/bash

/opt/bin/entry_point.sh &

#延迟推流
sleep 5

#启动声卡
pulseaudio --start

#隐藏光标
source /etc/profile


nohup unclutter -display $DISPLAY -noevents -grab &

ffmpeg -f x11grab -video_size ${SCREEN_WIDTH}x${SCREEN_HEIGHT} \
 -i $DISPLAY -async 1 -vsync 1 \
 -framerate ${framerate} -vcodec libx264 -preset ultrafast -qp 0 -pix_fmt yuv444p \
 -f pulse -i default \
 -vf "drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf: text='%{localtime\:%m/%d/%Y %I.%M.%S %p}': fontcolor=white@0.8: x=10: y=950" \
 -tune zerolatency -b 900k -f flv $STREAM_URL

# SAMPLE: rtmp://192.168.1.66:1935/live/abc

# Getting "Past duration 0.771996 too large" - added "-async 1 -vsync 1" to reduce this error

