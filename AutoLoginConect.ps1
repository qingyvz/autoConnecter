$username = "02101403782"
$password = "PMWTvymV"
$channel = "4"
$usripadd = "10.117.222.135"

while ($true) {
    $pingResult = ping -n 3 -w 80 baidu.com
    $pingString = $pingResult | Out-String
    Write-Output "$(Get-Date) $pingString"

    $timeout = $pingString -match "(100% (丢失|loss))" -or `
        $pingString -match "(请求超时|Request timed out|timed out)" -or `
        $pingString -match "(找不到主机|could not find host|unreachable)"
    # Write-Output $timeout

    if ($timeout) {
        Write-Output "$(Get-Date) - 网络断开，超时！"
        $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
        $session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0"
        Invoke-WebRequest -UseBasicParsing -Uri "http://10.102.250.36/api/v1/login" `
            -Method "POST" `
            -WebSession $session `
            -Headers @{
            "Accept-Encoding"             = "gzip, deflate"
            "Origin"                      = "http://10.102.250.36"
            "accept"                      = "application/json, text/plain, */*"
            "accept-language"             = "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6"
            "access-control-allow-origin" = "*"
        } `
            -ContentType "application/json;charset=UTF-8" `
            -Body "{`"username`":`"$username`",`"password`":`"$password`",`"ifautologin`":`"0`",`"channel`":`"$channel`",`"pagesign`":`"secondauth`",`"usripadd`":`"$usripadd`"}"
        Start-Sleep -Seconds 2
    }
    else {
        Write-Output "$(Get-Date) - 网络正常"
    }
    Start-Sleep -Seconds 2
}