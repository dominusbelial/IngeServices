# IngeServices Microservices Example Solution.
# Creator/Owner: Gustavo Poveda - 2020/1st Quarantine.
# Requirements: Ubuntu 16lts or better, Docker, Docker-Compose.

Certificate Generation Sample Application.

## Getting Started

clone repository from github --> git clone https://github.com/dominusbelial/IngeServices.git

### Prerequisites

Ubuntu 16lts or better, Docker, Docker-Compose.

### Installing

1. bash/terminal cd to downloaded repository, execute the following commands.

```
$ docker-compose up --build 
```

3. wait for the following message on console ---> READY  Server listening on http://0.0.0.0:3002

4. browse to http://127.0.0.1/ user:user password:abcd1234

### Notes.
# if your user is not part of docker group, you need to prepend "sudo" to all bash commands.
# nuxtfront access with user:user password:abcd1234
# strapiback ports 1337 for backend configuration, user: admin pass: abcd1234
# jsreport ports 5488 for backend configuration, user: admin pass: abcd1234
# example website only works on docker host/nginx locahost/127.0.0.1 at port 80/433.
# accept the localhost sample certificate to browse the crud/report demo example.
