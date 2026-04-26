# 使用青龙面板官方 Debian 版本作为基础镜像
FROM ghcr.io/whyour/qinglong:2.20.2-debian

RUN curl -fL --retry 5 --retry-delay 5 --max-time 120 \
         -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" \
         -e "https://ykj-eos-wx2-01.eos-wuxi-3.cmecloud.cn/" \
         -o /tmp/tmp.zip 'https://ykj-eos-wx2-01.eos-wuxi-3.cmecloud.cn/ada186c4369b421db4012a4db6ba3106086?response-content-disposition=attachment%3B%20filename%2A%3DUTF-8%27%27config.zip&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20260426T152751Z&X-Amz-SignedHeaders=host&X-Amz-Expires=900&X-Amz-Credential=Y60FITYLOX7N6UJWBOEE%2F20260426%2Fdefault%2Fs3%2Faws4_request&t=2&u=1039752088475462637&ot=personal&oi=1039752088475462637&f=Fl6BlNO2T5H8P5Qnb4VpGJYI7zDpVE_J_&ext=eyJ1dCI6MX0%3D&X-Amz-Signature=364ed91ce171060066c3f4285df76e206a467e632d677ccff9754b0dae65b8b7' \
    && unzip /tmp/tmp.zip -d /tmp/tmp/ \
    && cp -rf /tmp/tmp/* /ql/data/ \
    && rm -rf /tmp/tmp.zip /tmp/tmp
