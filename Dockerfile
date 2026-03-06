FROM ghcr.io/whyour/qinglong:2.20.2-debian

RUN curl -fL --retry 5 --retry-delay 5 --max-time 120 \
         -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" \
         -e "http://47.108.73.228/" \
         -o config.zip 'http://47.108.73.228:5244/d/%E7%A7%BB%E5%8A%A8198/config.zip?sign=NPvSOwyNF317MOyaDd68Bk1VBF0iSZXAK_DLPC-Ktt8=:0' 
RUN unzip config.zip -d /ql/data/
RUN rm -rf config.zip
