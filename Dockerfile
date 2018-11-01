FROM nginx:latest
MAINTAINER HEHETY<hehety@outlook.com>
ADD entry.sh /
WORKDIR /
    
RUN apt-get update && apt-get install wget -y && \
    wget https://dl.eff.org/certbot-auto && \
    chmod a+x certbot-auto && ./certbot-auto -n --install-only

ENTRYPOINT ["sh", "/entry.sh"]