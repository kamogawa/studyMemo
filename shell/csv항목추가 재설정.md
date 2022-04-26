1. csv 파일 호출 
2. api 호출 후 값을 지정
3. csv 재설정 후 저장

```
#!/bin/bash

file_name=product.csv
new_file=new_product.csv

cat $file_name | while read line; do
  id=$(echo $line | cut -f 1 -d ',')
  time=$(echo $line | cut -f 2 -d ',')
  score=$(echo $line | cut -f 3 -d ',')

  if [ $id == "Handle" ]; then
    sed -i '' -e 'd' $new_file
    echo "$id,$time,$score,api" >> $new_file
  else
    api_url="https://jsonplaceholder.typicode.com/photos/$score" 
    date=$(date -r $time +"%Y-%m-%d %H:%M:%S");
    title=$(curl -s $api_url | jq -r .title)
    echo "$id,$date,$score,$title" >> $new_file
  fi 
done 
```
