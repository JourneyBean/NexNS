# 系统架构

![NexNS system architecture](/zh/resources/nexns-system-arch.svg)

NexNS 服务可视为三部分。我们统一命名如下：

- 控制器：是一个后台服务，负责存储所有 DNS 数据，提供 WebUI 和众多 API；
- 服务端：DNS 服务器，类似于 dnsmasq、bind9等；
- 客户端：泛指修改控制器内容的各种实用程序，比如 certbot 客户端、DDNS 客户端、WebUI 客户端。

整个系统工作原理如下：

- 服务端开始运行时，从控制器加载所有域名数据，开始响应请求；
- 客户端发起请求，修改控制器上的域名数据，并进行发布；
- 控制器向服务端推送变更，服务端热重载该域名。

## 针对线路进行优化

![NexNS multi zone](/zh/resources/nexns-multi-zone.svg)
