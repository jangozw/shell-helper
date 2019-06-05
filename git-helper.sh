#!/usr/bin/env bash

action=$1
param1=$2
param2=$3
param3=$4



# get current branch name
function obtain_git_branch {
    br=`git branch | grep "*"`
    cur_branch=${br/* /}
    if [ ! -n "$cur_branch" ];then
        cur_branch="master"
    fi
    echo "$cur_branch"
}

cur_branch=`obtain_git_branch`

# description
echo "current branch: $cur_branch, current action: $action"

# command functions
function push {
    echo "拉取最新分支..."
    git pull
    echo "你当前的分支是：$result, 以下是更改的文件，请确认提交\n"
    git status

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