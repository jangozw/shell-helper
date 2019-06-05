#!/bin/bash

######################## 参数 ##################################
#web start centos-web

# 操作， start|stop
action=$1
# 操作的容器名称
container=$2

# 第二个参数唯恐，默认使用的容器
if [ ! -n "$container" ];then
    container="centos-web2"
fi

########################## 函数 ############################
# 帮助信息
operationHelp(){
    echo "This is help info for web environment: "
    echo "The current or default container is: $container, please confirm this before do any operate!"
    echo "Commands:"
    echo "  web new [container]    # create a container and start it, do it and you will see more info"
    echo "  web start [container]  # start a created container and entry the system";
    echo "  web stop [container]   # stop a created container"
    echo "  web exec [container]   # entry the container system when the container in up status"
    echo "Please use 'docker ps -a' or more docker operations  to see more info about your containers"
}
# 创建一个新容器
newContainer(){
  # -p 是端口映射,-v 目录文件同步, jangozw/centos-web  是拉的镜像
  sudo docker run -d -p 12000:80  -p 12002:22  -p 12003:15672  -v /Users/Django/www:/data/www --name $container  --privileged=true  jangozw/centos-web  /usr/sbin/init
  echo "创建容器 $container :"
  docker ps -a | grep "$container"
  echo "--------------------------------基本操作------------------------------------"
  echo "查看状态: docker ps -a | grep $container"
  echo "启动容器: docker start $container "
  echo "停止容器: docker stop $container "
  echo "删除容器: docker rm $container "
  echo "进入容器: docker exec -it $container /bin/bash"
}
# 停止运行一个容器
stopContainer(){
   docker stop $container
}
# 运行一个容器，并进入
startContainer(){
   docker start $container
   docker exec -it $container /bin/bash
}
# 进入一个容器
execContainer(){
   docker exec -it $container /bin/bash
}

############################## 操作判断 #############################################
case $action in
    new)
        newContainer
    ;;
    start)
        stopContainer
        startContainer
    ;;
    stop)
        stopContainer
    ;;
    exec)
        execContainer
    ;;
    h)
        operationHelp
    ;;
    help)
        operationHelp
    ;;
esac

