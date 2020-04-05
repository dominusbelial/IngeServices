## IngeServices Microservices Architecture Example.
## Creator/Owner: Gustavo Poveda - 2020/1st Quarantine.
## Requirements: Ubuntu 16lts or better, Docker, Docker-Compose.

### Getting Started
Clone repository from GitHub --> git clone https://github.com/dominusbelial/IngeServices.git

### Prerequisites
Host: Ubuntu 16lts Desktop/Server or better with Docker, Docker-Compose tools.

### Installing
1. bash/terminal cd to downloaded repository, execute the following command.

```
$ docker-compose up --build 
```

2. wait for the following message on console ---> READY  Server listening on http://0.0.0.0:3002
3. browse to http://127.0.0.1/ user:user password:abcd1234

### Notes
* if your user is not part of docker group, you need to prepend "sudo" to all bash commands.
* nuxtfront access with user:user password:abcd1234
* strapiback ports 1337 for backend configuration, user: admin pass: abcd1234
* jsreport ports 5488 for backend configuration, user: admin pass: abcd1234
* example website only works on docker host/nginx locahost/127.0.0.1 at port 80/433.
* accept the localhost sample certificate to browse the crud/report demo example.

### Architecture Description
Microservices are a software development technique that arranges an application as a collection of loosely coupled services. Containers are created for Strapi, Nuxt, JsReport, Mysql, Nginx, docker-compose will network all services together, access cluster via nginx to host ports 80/443.

#### Strapi Features in this example:
Backend JWT Authentication, REST Api (CRUD), GraphQL API (Querying,Filtering,Paging,Sorting).
#### Nuxt Features in this example:
Vuetify, Server Side Rendering, JWT Authentication, CRUD, Vuex, Vue.JS, Axios.
#### JsReport Features in this example:
Working report example.
#### Mysql Features in this example:
Relational Database supported by Strapi.
#### Nginx Features in this example:
Reverse proxy, SSL, securing access to cluster.


