#!/bin/bash

# 使用AppleScript获取当前打开的目录
thePath=$(osascript -e 'tell application "Finder" to set thePath to (quoted form of POSIX path of (target of front window as alias))')

# 去除路径中的引号
thePath=${thePath//\'/}

# 输出获取到的目录路径
echo $thePath

# 启动 vs，并加载所在目录
open -a "Visual Studio Code" "$thePath"

