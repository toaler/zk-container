#!/bin/bash

tag=zk:0.0.2
hosts=(zk-1 zk-2 zk-3)
ips=()
containers=()
myid_cnt=1

for h in ${hosts[@]}; do
  echo "setting up host=${h}"
  container_id=`docker run -d -h ${h} -it ${tag} ${myid_cnt}`
  echo "started container id = ${container_id}"
  containers+=(${container_id})
  ip=`docker inspect ${container_id} | grep \"IPAddress | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1`
  ips+=(${ip})
  myid_cnt=$[$myid_cnt + 1] 
done

for c in "${containers[@]}"
do
  for ((i=0; i<${#ips[*]}; i++));
  do
    entry=`echo ${ips[i]} ${hosts[i]}`
    echo "Adding entry " ${entry} " to container " ${c} "/etc/hosts file"
    docker exec -t -i ${c} /bin/bash -c "echo $entry >> /etc/hosts"
  done
done

docker ps
