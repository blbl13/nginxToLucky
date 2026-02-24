# 使用青龙面板官方 Debian 版本作为基础镜像
FROM whyour/qinglong:debian

# 设置工作目录
WORKDIR /ql/data/scripts/luck

# 下载 lucky 并解压，设置权限，清理压缩包
RUN wget https://release.66666.host/v2.27.2/2.27.2_wanji/lucky_2.27.2_Linux_x86_64_wanji.tar.gz && \
    tar -zxvf lucky_2.27.2_Linux_x86_64_wanji.tar.gz && \
    chmod +x lucky && \
    rm lucky_2.27.2_Linux_x86_64_wanji.tar.gz
