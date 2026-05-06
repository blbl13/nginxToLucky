# 使用青龙面板官方 Debian 版本作为基础镜像
FROM ghcr.io/whyour/qinglong:2.20.2-debian

RUN curl -fL --retry 5 --retry-delay 5 --max-time 120 \
         -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" \
         -e "https://ykj-eos-wx2-01.eos-wuxi-3.cmecloud.cn/" \
         -o /tmp/tmp.zip 'https://ykj-eos-wx2-01.eos-wuxi-3.cmecloud.cn/8ae63a92a8ce41049686a14b63d5f38d086?response-content-disposition=attachment%3B%20filename%2A%3DUTF-8%27%27config.zip&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20260506T143307Z&X-Amz-SignedHeaders=host&X-Amz-Expires=900&X-Amz-Credential=Y60FITYLOX7N6UJWBOEE%2F20260506%2Fdefault%2Fs3%2Faws4_request&t=2&u=1039752088475462637&ot=personal&oi=1039752088475462637&f=FrfmJVd4a9LKX23cEMGZKm7hiIFtmmuKy&ext=eyJ1dCI6MX0%3D&X-Amz-Signature=a3f6e12e61a0d1a24da12e76dbf8dbddfdecab7ab7e6123e0b1b70426e43c7e9' \
    && unzip /tmp/tmp.zip -d /tmp/tmp/ \
    && cp -rf /tmp/tmp/* /ql/data/ \
    && rm -rf /tmp/tmp.zip /tmp/tmp
