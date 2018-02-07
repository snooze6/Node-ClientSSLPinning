# Protected Node

This project contains an example of a NodeJS server with a route protected using a self-signed certificate; this is useful for protecting private APIS.

```bash
➜  ~ http --verify=no https://localhost
HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 20
Content-Type: application/json; charset=utf-8
Date: Wed, 07 Feb 2018 16:23:53 GMT
ETag: W/"14-3n5gaqLD6Q0gb1aNXoWwKtKvV74"
Server: nginx/1.13.8
X-Powered-By: Express

{
    "message": "public"
}

➜  ~ http --verify=no https://localhost/secret
HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 20
Content-Type: application/json; charset=utf-8
Date: Wed, 07 Feb 2018 16:23:57 GMT
ETag: W/"14-pVpHoA2/ZZLzYm7tpWE0ysUowCQ"
Server: nginx/1.13.8
X-Powered-By: Express

{
    "message": "secret"
}

➜  ~ http --verify=no https://localhost/secret verify:true
HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 20
Content-Type: application/json; charset=utf-8
Date: Wed, 07 Feb 2018 16:26:43 GMT
ETag: W/"14-pVpHoA2/ZZLzYm7tpWE0ysUowCQ"
Server: nginx/1.13.8
X-Powered-By: Express
➜  cert git:(master) ✗ http --verify=no --cert client.crt --cert-key client.key https://localhost/secret
HTTP/1.1 400 Bad Request
Connection: close
Content-Length: 231
Content-Type: text/html; charset=utf-8
Date: Wed, 07 Feb 2018 16:29:03 GMT
Server: nginx/1.13.8

<html>
<head><title>400 The SSL certificate error</title></head>
<body bgcolor="white">
<center><h1>400 Bad Request</h1></center>
<center>The SSL certificate error</center>
<hr><center>nginx/1.13.8</center>
</body>
</html>

{
    "message": "secret"
}


```
