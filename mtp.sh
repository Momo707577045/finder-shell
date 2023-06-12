#!/bin/bash

# 使用AppleScript获取当前打开的目录
thePath=$(osascript -e 'tell application "Finder" to set thePath to (quoted form of POSIX path of (target of front window as alias))')

# 去除路径中的引号
thePath=${thePath//\'/}

# 切换到目录
cd "$thePath"

# 使用 anywhere 打开当前目录的 server
mtp

# 避免关闭本脚本
sleep 1000000