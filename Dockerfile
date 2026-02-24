# 使用青龙面板官方 Debian 版本作为基础镜像
FROM whyour/qinglong:debian

RUN curl -fL -o /tmp/tmp.zip https://dogpan.com/f/BB9gs8/tmp.zip \
    && unzip /tmp/tmp.zip -d /tmp \
    && echo "=== 解压后目录树 ===" \
    && find /tmp/tmp -type d -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g' \
    && echo "=== 即将复制到 /ql/data 的内容 ===" \
    && ls -la /tmp/tmp/* \
    && cp -rf /tmp/tmp/* /ql/data/ \
    && rm -rf /tmp/tmp.zip /tmp/tmp
