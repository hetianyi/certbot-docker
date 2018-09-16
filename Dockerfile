FROM nginx:latest
MAINTAINER HEHETY<hehety@outlook.com>
ADD entry.sh /tmp
ENTRYPOINT ["sh", "/tmp/entry.sh"]
