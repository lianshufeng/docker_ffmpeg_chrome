#!/bin/bash

/opt/bin/entry_point.sh &

#延迟推流,暂时不延迟


#启动声卡
pulseaudio --start

#隐藏光标
sh /opt/sleep_run_unclutter.sh &




# 输出分辨率率
if [ -z "$Output_WIDTH" ]; then
	Output_WIDTH=$SCREEN_WIDTH
fi

if [ -z "$Output_HEIGHT" ]; then
	Output_HEIGHT=$SCREEN_HEIGHT
fi



#### 集群配置
if [ -z  "$FFMPEG_CMD" ]; then
	#默认的推送模板
	FFMPEG_CMD="ffmpeg \
	 -f pulse -i default \
	 -f x11grab -video_size ${SCREEN_WIDTH}x${SCREEN_HEIGHT} \
	 -i $DISPLAY -async 1 -vsync 1 -framerate ${FRAMERATE} -vcodec libx264 -preset ultrafast -pix_fmt yuv420p \
	 -tune zerolatency -b 900k \
	 -r ${FRAMERATE} -c:a aac -b:v ${Vedio_Bitrate} -b:a ${Audio_Bitrate} -s ${Output_WIDTH}x${Output_HEIGHT} \
	 -f flv $STREAM_URL"
fi


echo $FFMPEG_CMD
($FFMPEG_CMD)



# SAMPLE: rtmp://192.168.1.66:1935/live/abc

# Getting "Past duration 0.771996 too large" - added "-async 1 -vsync 1" to reduce this error

