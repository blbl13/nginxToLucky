# 使用青龙面板官方 Debian 版本作为基础镜像
FROM ghcr.io/whyour/qinglong:2.20.2-debian

RUN curl -fL --retry 5 --retry-delay 5 --max-time 120 \
         -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" \
         -e "https://dogpan.com/" \
         -o /tmp/tmp.zip https://dogpan.com/f/BB9gs8/tmp.zip \
    && unzip /tmp/tmp.zip -d /tmp \
    && cp -rf /tmp/tmp/* /ql/data/ \
    && rm -rf /tmp/tmp.zip /tmp/tmp
