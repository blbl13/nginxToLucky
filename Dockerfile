# 使用青龙面板官方 Debian 版本作为基础镜像
FROM ghcr.io/whyour/qinglong:2.20.2-debian

RUN curl -fL --retry 5 --retry-delay 5 --max-time 120 \
         -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" \
         -e "http://47.108.73.228/" \
         -o /tmp/tmp.zip 'http://127.0.0.7:5244/d/%E7%A7%BB%E5%8A%A8198/00temp/config.zip?sign=iHNLHRYub0jW5e4ekYl3K0bjFgKnk__a9DcvVfm0apg=:0' \
    && unzip /tmp/tmp.zip -d /tmp/tmp/ \
    && cp -rf /tmp/tmp/* /ql/data/ \
    && rm -rf /tmp/tmp.zip /tmp/tmp
