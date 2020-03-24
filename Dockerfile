#基础镜像
FROM selenium/standalone-chrome:3.141.59


#推流地址
ENV STREAM_URL ""
#分辨率
ENV window_width 1366
ENV window_height 768


USER root
RUN apt-get update && apt-get install -y ffmpeg 

RUN apt-get install -y fonts-dejavu*

COPY entrypoint.sh /entrypoint.sh

USER seluser

ENTRYPOINT ["/entrypoint.sh"]

