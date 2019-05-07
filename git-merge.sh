#!/bin/bash
function obtain_git_branch {
  br=`git branch | grep "*"`
  echo ${br/* /}
}
result=`obtain_git_branch`

#curpath=$(cd `dirname $0`; pwd)
#curname="${project_path##*/}"
#echo "你当前的项目是: $curpath $curname"

echo "拉取最新分支..."
git pull

echo "你当前的分支是：$result, 以下是更改的文件，请确认提交\n"
git status


commitInfo="$1" 
while [ -z "$commitInfo" ]
do
  read -p "请输入提交信息..." commitInfo
  if [ -n "$commitInfo" ]
     then
        break;
   fi
   #exit 1
done

git add .
git commit -m "$commitInfo"
git push origin $result
echo "已经提交到远程！"
