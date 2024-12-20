# finder 快捷脚本：one click 在当前目录执行命令
### 先看效果
【cdto】一键打开终端，并切换到当前目录
  ![](http://upyun.luckly-mjw.cn/Assets/finder-shell/cdto.gif)

【code】一键打开 vscode，并加载当前目录
  ![](http://upyun.luckly-mjw.cn/Assets/finder-shell/vscode.gif?v)

【serve】一键启动静态服务器，并加载当前目录
  ![](http://upyun.luckly-mjw.cn/Assets/finder-shell/serve.gif)

【mtp】一键视觉无损、原地、递归压缩、当前目录所有图片
  ![](http://upyun.luckly-mjw.cn/Assets/finder-shell/mtp.gif)

【ecs】一键登录服务器
  ![](http://upyun.luckly-mjw.cn/Assets/finder-shell/momo.gif)


### 【技巧一】将应用放置到 finder
- 固定：按住 command，拖拽脚本到 finder 顶部工具栏，固定快捷脚本
- 取消固定：按住 command，将脚本拖离 finder 工具栏，取消该固定
- 任意文件夹，应用，脚本都可以固定在 finder 上快捷访问
  ![](http://upyun.luckly-mjw.cn/Assets/finder-shell/set-finder.gif)

### 【技巧二】自定义 icon
- 先复制想要的 icon 图片
- 查看文件详情简介，左上角 icon 可点击选中
- 选中后，command + v 即可将图片设置为该文件的 icon
- 选中后，按下 delete 可将自定义 icon 删除，恢复默认 icon
- 任意文件夹，应用，文件均可设置自定义 icon
  ![](http://upyun.luckly-mjw.cn/Assets/finder-shell/set-icon.gif)

### 【技巧三】获取 finder 当前目录路径
```
#!/bin/bash

# 使用AppleScript获取当前打开的目录
thePath=$(osascript -e 'tell application "Finder" to set thePath to (quoted form of POSIX path of (target of front window as alias))')

# 去除路径中的引号
thePath=${thePath//\'/}
```  

其中关键代码为`osascript -e 'tell application "Finder" to set thePath to (quoted form of POSIX path of (target of front window as alias)`
- 这段代码使用 osascript 命令调用 AppleScript 脚本来获取 macOS Finder 当前打开窗口所在的文件夹路径。
- -e 选项用于指定要执行的脚本内容。在脚本内容中，使用tell application "Finder"告诉当前正在运行的应用程序为Finder，并且要在其上下文环境中执行后面的操作。
- set thePath to 来创建一个名为 thePath 的变量，并将其赋值为“(target of front window as alias)”（即当前激活窗口的路径）。
- 最后，使用(quoted form of POSIX path of ...)将路径进行引号转义和POSIX路径格式化，以确保可以正确处理包含空格等特殊字符的路径。

### 示例脚步源码
[【cdto.sh】](https://github.com/Momo707577045/finder-shell/blob/main/cdto.sh)一键打开终端，并切换到当前目录
- 十行代码实现 cdto
```
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
```

[【code.sh】](https://github.com/Momo707577045/finder-shell/blob/main/code.sh)一键打开 vscode，并加载当前目录
```
#!/bin/bash

# 使用AppleScript获取当前打开的目录
thePath=$(osascript -e 'tell application "Finder" to set thePath to (quoted form of POSIX path of (target of front window as alias))')

# 去除路径中的引号
thePath=${thePath//\'/}

# 输出获取到的目录路径
echo $thePath

# 启动 vs，并加载所在目录
open -a "Visual Studio Code" "$thePath"
```

[【ecs.sh】](https://github.com/Momo707577045/finder-shell/blob/main/ecs.sh)一键登录服务器
```
#! /usr/bin/expect
# 依赖 expect 命令，https://www.linuxprobe.com/linux-expect-auto.html

# 启动 ssh 进程
spawn /usr/bin/ssh root@这里替换ip

# 匹配标准输出中的字符串
expect "root@这里替换ip's password"

# 向标准输入填充密码并换行
send "这里替换密码\r"

# 匹配标准输出中的字符串
expect "to Alibaba Cloud"

# 脱离控制，将控制权交还给用户，允许用户交互
interact
```

[【mtp.sh】](https://github.com/Momo707577045/finder-shell/blob/main/mtp.sh)一键视觉无损、原地、递归压缩、当前目录所有图片
- 依赖全局 [mtp 脚本](https://www.npmjs.com/package/tinypng-script-with-cache)`npm install -g tinypng-script-with-cache`
![](http://upyun.luckly-mjw.cn/Assets/finder-shell/mtp.png)
```
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
```

[【serve.sh】](https://github.com/Momo707577045/finder-shell/blob/main/serve.sh)一键启动静态服务器，并加载当前目录
- 依赖全局 [anywhere](https://www.npmjs.com/package/anywhere)`npm install -g anywhere`
- 不想安装 anywhere 的话，直接使用 python 功能即可，使用[这个脚本](https://github.com/Momo707577045/simple-LAN-transmitter/blob/master/share-py3.command)
```
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
```

### 就挺有意思
![](http://upyun.luckly-mjw.cn/Assets/finder-shell/end.png)
