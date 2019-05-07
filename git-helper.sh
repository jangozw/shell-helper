#!/usr/bin/env bash

action=$1
param1=$2
param2=$3
param3=$4



function obtain_git_branch {
  br=`git branch | grep "*"`
  echo ${br/* /}
}

cur_branch=`obtain_git_branch`
echo "current branch: $cur_branch, current action: $action"

function push {
    echo $cur_branch
}
function init {
    gitaddr=$1
    while [ -z "$gitaddr" ]
    do
        read -p "请输入git仓库地址..." gitaddr
        if [ -n "$gitaddr" ]
            then
            break;
        fi
    done
    git init
    # r is empty,why?
    r=`git remote add origin $gitaddr`
    err=$(echo "$r" | grep "fatal:")
    if [[ "$err" != "" ]]
    then
        echo "设置git地址出错了：$r"
        exit 1
    fi
    git remote -v
}

case "$action" in
    "push")
        push $param1
        #输出两个分号
    ;;

    "init")
        init $param1
        #输出两个分号
    ;;

    "merge")
        echo "current: $action"
        #输出两个分号
    ;;

    "test")
        echo "current: $action"
        #输出两个分号
    ;;
esac