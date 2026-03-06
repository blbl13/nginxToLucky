# 使用青龙面板官方 Debian 版本作为基础镜像
FROM ghcr.io/whyour/qinglong:2.20.2-debian

RUN curl -fL --retry 5 --retry-delay 5 --max-time 120 \
         -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" \
         -e "https://ykj-eos-wx2-01.eos-wuxi-3.cmecloud.cn/" \
         -o /tmp/tmp.zip 'https://ykj-eos-wx2-01.eos-wuxi-3.cmecloud.cn/b6d10bc314c1452e82f54ac1b67971d0086?response-content-disposition=attachment%3B%20filename%2A%3DUTF-8%27%27config.zip&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20260306T144845Z&X-Amz-SignedHeaders=host&X-Amz-Expires=900&X-Amz-Credential=Y60FITYLOX7N6UJWBOEE%2F20260306%2Fdefault%2Fs3%2Faws4_request&t=2&u=1039752088475462637&ot=personal&oi=1039752088475462637&f=FjdSC4PzyErSPxs3hO_tBG5hPK-5EcgS0&ext=eyJ1dCI6MX0%3D&X-Amz-Signature=db7b7196a2a38baea11c1eacdfd1354ba97015165e169f5f1517cac38efa33bc' \
    && unzip /tmp/tmp.zip -d /tmp/tmp/ \
    && cp -rf /tmp/tmp/* /ql/data/ \
    && rm -rf /tmp/tmp.zip /tmp/tmp
