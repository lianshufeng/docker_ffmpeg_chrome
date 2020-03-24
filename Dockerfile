#基础镜像
FROM selenium/standalone-chrome:3.141.59-europium


#推流地址
ENV STREAM_URL ""

#分辨率
ENV SCREEN_WIDTH "1366"
ENV SCREEN_HEIGHT "768"


USER root
RUN apt-get update && apt-get install -y ffmpeg 

RUN apt-get install -y fonts-dejavu*

#复制启动文件
COPY entrypoint.sh /entrypoint.sh
RUN chmod -R 777 /entrypoint.sh

#切换用户
USER seluser

ENTRYPOINT ["/entrypoint.sh"]

