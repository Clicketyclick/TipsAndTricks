
## sprintf()

(Based on [<img src="../logo-stackoverflow.icon.png" title="Link to Stackoverflow" width=16px height=auto>]([https://stackoverflow.com/a/61004015/7485823](https://stackoverflow.com/a/33113676)))
```shell
sprintf() { local stdin; read -d '' -u 0 stdin; printf "$@" "$stdin"; }
```
