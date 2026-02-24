# 使用青龙面板官方镜像作为基础（基于 Debian）
FROM whyour/qinglong:debian

# 安装 wget、tar 和 supervisor（用于进程管理）
RUN apt-get update && \
    apt-get install -y wget tar supervisor && \
    rm -rf /var/lib/apt/lists/*

# 创建各程序的工作目录
RUN mkdir -p /lucky /openlist

# ----- 安装 lucky -----
RUN wget -O /tmp/lucky.tar.gz https://release.66666.host/v2.27.2/2.27.2_wanji/lucky_2.27.2_Linux_x86_64_wanji.tar.gz && \
    tar -xzf /tmp/lucky.tar.gz -C /lucky && \
    rm /tmp/lucky.tar.gz && \
    # 解压后通常只有一个二进制文件，将其重命名为 lucky
    cd /lucky && \
    for f in *; do if [ -f "$f" ]; then mv "$f" lucky; break; fi; done && \
    chmod +x /lucky/lucky

# ----- 安装 openlist -----
RUN wget -O /tmp/openlist.tar.gz https://github.com/OpenListTeam/OpenList/releases/latest/download/openlist-linux-musl-amd64.tar.gz && \
    tar -xzf /tmp/openlist.tar.gz -C /openlist && \
    rm /tmp/openlist.tar.gz && \
    # 解压后文件名为 openlist-linux-musl-amd64，重命名为 openlist
    mv /openlist/openlist-linux-musl-amd64 /openlist/openlist && \
    chmod +x /openlist/openlist

# ----- 配置 supervisor -----
# 创建 supervisor 配置文件，定义三个服务
RUN echo "[supervisord]\n\
nodaemon=true\n\
logfile=/var/log/supervisor/supervisord.log\n\
pidfile=/var/run/supervisord.pid\n\
\n\
[program:qinglong]\n\
command=/ql/docker/docker-entrypoint.sh\n\
directory=/ql\n\
user=root\n\
autostart=true\n\
autorestart=true\n\
stopasgroup=true\n\
killasgroup=true\n\
stdout_logfile=/var/log/supervisor/%(program_name)s.log\n\
stderr_logfile=/var/log/supervisor/%(program_name)s.log\n\
\n\
[program:lucky]\n\
command=/lucky/lucky\n\
directory=/lucky\n\
user=root\n\
autostart=true\n\
autorestart=true\n\
stopasgroup=true\n\
killasgroup=true\n\
stdout_logfile=/var/log/supervisor/%(program_name)s.log\n\
stderr_logfile=/var/log/supervisor/%(program_name)s.log\n\
\n\
[program:openlist]\n\
command=/openlist/openlist server\n\
directory=/openlist\n\
user=root\n\
autostart=true\n\
autorestart=true\n\
stopasgroup=true\n\
killasgroup=true\n\
stdout_logfile=/var/log/supervisor/%(program_name)s.log\n\
stderr_logfile=/var/log/supervisor/%(program_name)s.log" > /etc/supervisor/conf.d/all.conf

# 创建 supervisor 日志目录（如果不存在）
RUN mkdir -p /var/log/supervisor

# 暴露三个服务的端口
EXPOSE 5700 16601 5244

# 设置工作目录（可选）
WORKDIR /

# 使用 supervisor 作为容器主进程（前台运行）
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf", "-n"]
