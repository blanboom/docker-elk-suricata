适用于 [pfSense](https://www.pfsense.org) + [Suricata](https://suricata-ids.org) 的 [ELK Stack](https://www.elastic.co/elk-stack)，能够可视化 pfSense 路由器/防火墙中的日志信息。已对 [Synology](https://www.synology.com/zh-cn) NAS 进行适配。

相关文章：[我的 pfSense 软路由配置：QoS、IDS 与流量监控](https://blanboom.org/2018/pfsense-setup/)

Docker Hub 地址：https://hub.docker.com/r/blanboom/elk-suricata/

## 关于本镜像

1. 本 Docker 镜像基于 [spujadas/elk-docker](https://github.com/spujadas/elk-docker)
2. 配置文件来自：[a3ilson/pfelk](https://github.com/a3ilson/pfelk/)
3. 主要根据 [andig/syno-elk-docker](https://github.com/andig/syno-elk-docker) 对 Synology NAS 进行适配

## 使用方法

```
docker run -p 5601:5601 -p 9200:9200 -p 5140:5140 -p 5140:5140/udp -v /your/local/log/data/dir:/var/lib/elasticsearch --name elk blanboom/elk-suricata
```

端口信息：

- 5601 (Kibana web 界面)
- 9200 (Elasticsearch JSON 接口)
- 5140 (Syslog 服务器端口，可通过 TCP 与 UDP 协议接收 syslog)

此外，还需要 a) 设置将 Suricata 的 Alert 记录在 syslog，并将 pfSense 的 syslog 发送到 5140 端口，b) 在 kibana 网页中导入[a3ilson/pfelk](https://github.com/a3ilson/pfelk/) 中的配置。详细步骤可参考 [http://pfelk.3ilson.com](http://pfelk.3ilson.com).


在不同的网络环境下，部分文件可能需要修改。具体修改方式也请参考 http://pfelk.3ilson.com

Docker 镜像的更多使用方法，可参考：http://elk-docker.readthedocs.io
