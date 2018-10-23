# certbot-docker
### Description

certbot-docker是一个证书快速生成工具。
使用certbot在docker容器中自动生成SSL证书文件并输出到宿主机的指定目录。

docker hub: [https://hub.docker.com/r/hehety/certbot-docker/](https://hub.docker.com/r/hehety/certbot-docker/)
certbot doc: [https://certbot.eff.org/docs/](https://certbot.eff.org/docs/)

特点：
- 在docker容器中运行，无需在宿主机安装certbot，以及certbot的各种依赖包，资源隔离干净。
- 命令已封装，只需提供一些参数即可完成工作。

使用示例：
根据提供的参数将生成证书文件输出到宿主机的```/tmp/cert```目录下
```javascript
# -v 宿主机目录:容器内输出目录
docker run --rm -p 80:80 -p 443:443 -v /tmp/cert:/output hehety/certbot-docker --email xxx@xxx.com --domain xxx.com
```
注意：
> - 证书生成全程需要联网，并且需要容器映射宿主机的80和443端口用于证书服务器进行身份验证。
> - 运行的容器所在机器必须和证书绑定的域名进行绑定
