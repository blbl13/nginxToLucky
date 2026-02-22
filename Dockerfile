FROM alpine:3.23

# 安装 nginx 和 supervisor
RUN apk update && apk add --no-cache nginx supervisor

# 创建工作目录
WORKDIR /app

# 下载 lucky 并解压（x86_64 版本）
RUN wget https://release.66666.host/v2.27.2/2.27.2_wanji/lucky_2.27.2_Linux_x86_64_wanji.tar.gz && \
    tar -zxvf lucky_2.27.2_Linux_x86_64_wanji.tar.gz && \
    rm lucky_2.27.2_Linux_x86_64_wanji.tar.gz && \
    chmod +x openlist lucky

# 复制 nginx 代理配置
COPY nginx/lucky-proxy.conf /etc/nginx/http.d/default.conf

# 删除默认的 nginx 配置（避免冲突）
RUN rm -f /etc/nginx/http.d/default.conf /etc/nginx/conf.d/default.conf

# 复制 supervisor 配置
COPY supervisord.conf /etc/supervisord.conf

# 暴露公网端口
EXPOSE 8888

# 使用 supervisor 启动 nginx 和 lucky
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
