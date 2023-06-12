#!/bin/bash

# 使用AppleScript获取当前打开的目录
thePath=$(osascript -e 'tell application "Finder" to set thePath to (quoted form of POSIX path of (target of front window as alias))')

# 去除路径中的引号
thePath=${thePath//\'/}

# 定义信号处理函数，当 iterm 执行失败，则使用默认终端
function signal_handler() {
  # 切换到当前目录
  cd "$thePath"
  bash -i
}

# 注册信号处理函数
trap signal_handler ERR INT TERM

# 尝试打开 iTerm 终端
if ! open -a iTerm "$thePath"; then
  # 如果打开失败，则手动触发错误信号
  echo "Failed to open iTerm"
  kill -s ERR $$
fi