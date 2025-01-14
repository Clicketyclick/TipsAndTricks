# jq - on Windows

## Download latest
```cmd
curl -L -o jq.exe https://github.com/stedolan/jq/releases/latest/download/jq-win64.exe
::export PATH=$PATH:"/C/Users/devops/Downloads/jq-win64.exe
jq --version
```

## Test jq

```cmd
echo '{"foo": 0}' | jq
```
