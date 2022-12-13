# trim

trim leading and trailing whitespace from string

## Synopsis
```console
trim "String"   # Trim both leading and trailing whitespace from string
triml "String"  # Trim only leading whitespace from string
trimr "String"  # Trim only trailing whitespace from string
```

## Example
```shell
. "./trim.sh"
mix="  123 456  "
echo "mix[$mix]"
echo "trim1[`trim "$mix"`]"
       
mix="  123 456  "
trim=`trim "$mix"`
echo "trim2[$trim]"
      
mix="  123 456  "
trim=`ltrim "$mix"`
echo "ltrim[$trim]"

mix="  123 456  "
trim=`rtrim "$mix"`
echo "rtrim[$trim]"
```
