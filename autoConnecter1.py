import httpx
import time
import json
from datetime import datetime

# 打印当前时间和消息（处理 PowerShell 的 Write-Output）
print(f"{datetime.now()} - 登录操作时间")

with httpx.Client() as client:
    # 设置 User-Agent
    client.headers.update({
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0"
    })

    # 请求头
    headers = {
        "Accept-Encoding": "gzip, deflate",
        "Origin": "http://10.102.250.36",
        "accept": "application/json, text/plain, */*",
        "accept-language": "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6",
        "access-control-allow-origin": "*",
        "Content-Type": "application/json;charset=UTF-8"
    }

    # 假设这些变量已在脚本中定义，或者需要从外部传入
    username = "02101403782"  # 替换为实际用户名
    password = "PMWTvymV"  # 替换为实际密码
    channel = "4"    # 替换为实际 channel
    usripadd = "10.117.222.135"  # 替换为实际 usripadd

    # 构造请求体
    payload = {
        "username": username,
        "password": password,
        "ifautologin": "0",
        "channel": channel,
        "pagesign": "secondauth",
        "usripadd": usripadd
    }

    # 发送 POST 请求
    response = client.post(
        url="http://10.102.250.36/api/v1/login",
        headers=headers,
        json=payload,  # 将字典转换为 JSON 字符串
    )

# 等待 2 秒，类似 PowerShell 的 Start-Sleep
time.sleep(2)

# 可选：打印响应内容以便调试
print(response.status_code)
print(response.text)