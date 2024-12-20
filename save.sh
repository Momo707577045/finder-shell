#!/bin/bash

# 切换到目录
cd "/Users/panyanbing/Documents/obsidian"

# 输出获取到的目录路径
echo $thePath

chmod -R +w "$thePath"

# 使用 anywhere 打开当前目录的 server
mtp

# 添加所有修改到暂存区
git add -A

# 提交暂存区的修改
git commit -m 'save'

# 将本地提交推送到远程仓库
git push

