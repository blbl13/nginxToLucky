FROM alpine:3.23

# 安装 nginx、supervisor 和 wget
RUN apk update && apk add --no-cache nginx supervisor wget

WORKDIR /app

# 下载 lucky 并解压
RUN wget https://release.66666.host/v2.27.2/2.27.2_wanji/lucky_2.27.2_Linux_x86_64_wanji.tar.gz && \
    tar -zxvf lucky_2.27.2_Linux_x86_64_wanji.tar.gz && \
    rm lucky_2.27.2_Linux_x86_64_wanji.tar.gz && \
    chmod +x lucky openlist   # 同时给 openlist 添加执行权限

# 复制 nginx 代理配置
COPY nginx/lucky-proxy.conf /etc/nginx/http.d/default.conf

# 删除默认的 nginx 配置
RUN rm -f /etc/nginx/http.d/default.conf /etc/nginx/conf.d/default.conf

# 复制 supervisor 配置
COPY supervisord.conf /etc/supervisord.conf

EXPOSE 8888

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
