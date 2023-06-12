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