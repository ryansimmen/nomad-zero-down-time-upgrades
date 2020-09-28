Commands
```
consul agent -dev

nomad agent -dev-connect

docker build . -t web-server:1.0

nomad stop -purge example

nomad run server.hcl

curl http://localhost:8080/_ping

while (true) do; curl http://localhost:8080; sleep 0.1; done

watch docker ps

watch "echo "show servers state http_back" | nc localhost 9000"
```
