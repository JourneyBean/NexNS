# 服务端配置

编辑 `config.cfg`

``` conf
. {
  log
  nexns {
    controller http://controller-url/
    client_id xxxxxxx
    client_secret xxxxxxx
  }
}
```

然后启动服务：

``` bash
coredns -conf config.cfg -p 53
```
