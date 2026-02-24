# 使用青龙面板官方 Debian 版本作为基础镜像
FROM whyour/qinglong:debian

RUN curl -fL -o /tmp/tmp.zip https://singapore.dogpan.com/uploads/5318/2026/02/24/tmp.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=30WBJJEXhGrauXt6PFTr%2F20260224%2Fu6p1.sg02%2Fs3%2Faws4_request&X-Amz-Date=20260224T124557Z&X-Amz-Expires=600&X-Amz-SignedHeaders=host&X-Amz-Signature=ec26447fc265783309bdd8b709026138526373cca7b6f62c41a8b637f5f7a4e4 \
    && unzip /tmp/tmp.zip -d /tmp \
    && echo "=== 解压后目录树 ===" \
    && find /tmp/tmp -type d -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g' \
    && echo "=== 即将复制到 /ql/data 的内容 ===" \
    && ls -la /tmp/tmp/* \
    && cp -rf /tmp/tmp/* /ql/data/ \
    && rm -rf /tmp/tmp.zip /tmp/tmp
