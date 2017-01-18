docker ps | grep zk: | awk '{print $1}' | xargs docker stop --time 1

