#基础镜像
FROM selenium/standalone-chrome:3.141.59


#分辨率
ENV SCREEN_WIDTH "1366"
ENV SCREEN_HEIGHT "768"


#自定义,该参数会覆盖所有ffmpeg的参数
ENV FFMPEG_CMD ""

#推流地址
ENV STREAM_URL ""

#帧率
ENV FRAMERATE "30"

#如果为空则与窗口分辨率一致
ENV Output_WIDTH ""
ENV Output_HEIGHT ""

#码率
ENV Vedio_Bitrate "2500k"
ENV Audio_Bitrate "64k"




USER root
RUN apt-get update && apt-get install -y ffmpeg 

RUN apt-get install -y fonts-dejavu* unclutter pulseaudio libpulse-dev 

#复制启动文件
COPY entrypoint.sh /entrypoint.sh
RUN chmod -R 777 /entrypoint.sh

#切换用户
USER seluser

ENTRYPOINT ["/entrypoint.sh"]

