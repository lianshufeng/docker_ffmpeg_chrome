# ffmpeg-chrome




#自定义推流地址
````shell
docker rm -f chrome

SCREEN_WIDTH=1800
SCREEN_HEIGHT=2880
FFMPEG_CMD="ffmpeg \
	 -f pulse -i default \
	 -f x11grab -video_size ${SCREEN_WIDTH}x${SCREEN_HEIGHT} \
	 -i :99 -async 1 -vsync 1 -framerate 30 -vcodec libx264 -preset ultrafast -pix_fmt yuv420p \
	 -tune zerolatency -b 900k \
	 -r 30 -b:v 2500k -b:a 64k  -s 1800x2880 \
	 -f flv rtmp://push.live.aiyilearning.com/aiyilive/5e7c537ded5ef411db79b257?auth_key=1586415769-ec44a0fbb6354e9a9cd187fc5a1e2a96-0-c9ea3eb20779c594c7b479769ed4c31f"
docker run -d --name chrome -e SE_OPTS="-sessionTimeout 604800" -p 4444:4444 -v /dev/shm:/dev/shm -e SCREEN_WIDTH=$SCREEN_WIDTH -e SCREEN_HEIGHT=$SCREEN_HEIGHT -e FFMPEG_CMD="$FFMPEG_CMD"  registry.cn-chengdu.aliyuncs.com/1s/ffmpeg_chrome
````

# 参数推流
````shell
#推流地址
STREAM_URL=rtmp://push.live.aiyilearning.com/aiyilive/5e7c537ded5ef411db79b257?auth_key=1586415769-ec44a0fbb6354e9a9cd187fc5a1e2a96-0-c9ea3eb20779c594c7b479769ed4c31f
#屏幕分辨率
SCREEN_WIDTH=1800
SCREEN_HEIGHT=2880
#输出分辨率,默认为屏幕分辨率
Output_WIDTH=""
Output_HEIGHT=""

docker rm -f chrome
docker run --name chrome -d -p 4444:4444 -v /dev/shm:/dev/shm \
-e SCREEN_WIDTH=$SCREEN_WIDTH -e SCREEN_HEIGHT=$SCREEN_HEIGHT \
-e STREAM_URL=$STREAM_URL \
registry.cn-chengdu.aliyuncs.com/1s/ffmpeg_chrome

````