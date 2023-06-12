#!/bin/bash

# 使用AppleScript获取当前打开的目录
thePath=$(osascript -e 'tell application "Finder" to set thePath to (quoted form of POSIX path of (target of front window as alias))')

# 去除路径中的引号
thePath=${thePath//\'/}

# 随机端口
random=$((RANDOM%10000+20000))

# 打印运行的路径
echo "http://127.0.0.1:$random"
echo $thePath

# 使用 anywhere 打开当前目录的 server
anywhere -p $random -d "$thePath"