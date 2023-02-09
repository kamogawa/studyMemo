#!/bin/sh
PARAM=$1
#복수의 서버에 패스워드 sudo커맨드 패스워드 입력후 yum실행
server=("server1" "server2")
for server in ${severs[@]}; do
  echo $server
  ssh -o StrictHostKeyChecking=no -t $sever "echo $PARAM | sudo -S yum -y install <패키지>";
done
