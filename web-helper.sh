#!/bin/bash
# docker web环境助手
######################## 参数 ##################################
#web start centos-web

# 操作， start|stop
action=$1
# 操作的容器名称
container=$2

# 第二个参数为空，默认使用的容器
if [ ! -n "$container" ];then
    container="centos-web2"
fi

#web 使用的镜像 (本地的已经拉好了)
webImage="jangozw/centos-web"

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
  sudo docker run -d -p 12000:80  -p 12002:22  -p 12003:15672  -v /Users/Django/www:/data/www --name $container  --privileged=true  $webImage  /usr/sbin/init
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
    echo "stop $container"
    docker stop $container
}
# 运行一个容器，并进入
startContainer(){
    echo "start and entry $container..."
    docker start $container
    docker exec -it $container /bin/bash
}
# 进入一个已经开启的容器
execContainer(){
    echo "Entry $container..."
    docker exec -it $container /bin/bash
}
# 保存提交修改信息 容器, 在本地镜像
commitContainer(){
    echo "save $container to local..."
    docker commit $container $webImage
}
# 推送容器的镜像到远程 docker.hub
pushImage(){
    echo "push image: $webImage to remote..."
    docker push $webImage
    docker images | grep $webImage
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
    e)
        execContainer
    ;;
    commit)
        commitContainer
    ;;
    push)
        pushImage
    ;;
    h)
        operationHelp
    ;;
    help)
        operationHelp
    ;;
esac

