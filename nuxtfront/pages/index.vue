<template>
  <v-layout
    column
    justify-center
    align-center
  >
    <v-flex
      xs12
      sm8
      md6
    >
      <div class="text-center">

        
      </div>
      <v-card light>
        <v-card-title class="headline">
          Welcome to the showcase test application.
        </v-card-title>
        <v-card-text>
          <p>The following technical showcase by Gustavo Poveda provides an example of the ability to create a stable, secure web application based on microservices technology with a fully open-source stack.</p>
          <v-subheader><b>Architecture Description</b></v-subheader>
          <p>Microservices are a software development technique that arranges an application as a collection of loosely coupled services. Containers are created for Strapi, Nuxt, JsReport, Mysql, Nginx, docker-compose will network all services together, access cluster via nginx to host ports 80/443.</p>
        </v-card-text>
        <v-container fluid>
          <v-row dense>
            <v-col
              v-for="card in cards"
              :key="card.title"
              :cols="card.flex"
            >
              <v-card dark>
                  <div v-if="card.title == 'NuxtJs'">
                    <logo />
                    <v-card-title v-text="card.title"></v-card-title>
                  </div>
                  <div v-else-if="card.title == 'Vuetify'">
                    <vuetify-logo />
                    <v-card-title v-text="card.title"></v-card-title>
                  </div>                 
                  <div v-else>
                    <v-img contain
                      :src="card.src"
                      class="white--text align-end"
                      gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
                      height="200px"
                    >
                      <v-card-title v-text="card.title"></v-card-title>
                    </v-img>
                  </div>
                
                <v-card-text>
                  {{card.text}}
                </v-card-text>

                <v-card-text  v-if="card.title == 'Strapi.io'">
                  <div class="text--primary">
                    Features in Demo.<br>
                  </div>                
                  <p>Backend JWT Authentication, REST Api (CRUD), GraphQL API (Querying,Filtering,Paging,Sorting).</p>
                </v-card-text>

                <v-card-text  v-if="card.title == 'Vuetify'">
                  <div class="text--primary">
                    Features in Demo.<br>
                  </div>                
                  <p>Framework application fully implemented.</p>
                </v-card-text>

                <v-card-text  v-if="card.title == 'JsReport'">
                  <div class="text--primary">
                    Features in Demo.<br>
                  </div>                
                  <p>Working report example.</p>
                </v-card-text>

                <v-card-text  v-if="card.title == 'NuxtJs'">
                  <div class="text--primary">
                    Features in Demo.<br>
                  </div>                
                  <p>Vuetify, Server Side Rendering, JWT Authentication, CRUD, Vuex, Vue.JS, Axios.</p>
                </v-card-text>                

                <v-card-text  v-if="card.title == 'MySql'">
                  <div class="text--primary">
                    Features in Demo.<br>
                  </div>                
                  <p>Relational Database supported by Strapi.</p>
                </v-card-text>

                <v-card-text  v-if="card.title == 'Nginx'">
                  <div class="text--primary">
                    Features in Demo.<br>
                  </div>                
                  <p>Reverse proxy, SSL, securing access to cluster.</p>
                </v-card-text>    
                <v-card-actions>
                  <v-spacer></v-spacer>
    
                  <v-btn icon>
                    <v-icon>mdi-heart</v-icon>
                  </v-btn>
    
                  <v-btn icon>
                    <v-icon>mdi-bookmark</v-icon>
                  </v-btn>
    
                  <v-btn icon>
                    <v-icon>mdi-share-variant</v-icon>
                  </v-btn>
                </v-card-actions>
              </v-card>
            </v-col>
          </v-row>
        </v-container>  
        <v-subheader><b>Architecture Diagram</b></v-subheader>      
        <v-card-text>
            <v-img contain
              src="/IngeServicesDiag.png"
              class="white--text align-end"
            >
            </v-img> 
        </v-card-text>        
        <v-card-text>
          <p><b>CV</b> now how about some information about the creator?
          </p>
        </v-card-text>
        <v-card-actions>
          <v-spacer />
          <v-btn
            color="primary"
            nuxt
            to="/certificates"
          >
            Continue
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-flex>
  </v-layout>
</template>

<script>
import Logo from '~/components/Logo.vue'
import VuetifyLogo from '~/components/VuetifyLogo.vue'

export default {
  middleware: ['authenticated'],  
  components: {
    Logo,
    VuetifyLogo
  },
  data: () => ({
      cards: [
        { title: 'NuxtJs', text:'Acting as frontend is a free and open source web application framework based on Vue.js, Node.js, Webpack and Babel.js.' , src: '', flex: 3 },
        { title: 'Strapi.io', text:'Acting as backend is the next-gen headless CMS, open-source, javascript, enabling content-rich experiences to be created, managed and exposed to any digital device.', src: 'https://strapi.io/assets/images/logo.png', flex: 3 },
        { title: 'Vuetify', text:'Material Design component framework for Vue.js. It aims to provide all the tools necessary to create beautiful content rich applications.', src: '', flex: 3 },
        { title: 'JsReport', text:'is a reporting server which lets developers define reports using javascript templating engines.', src: 'https://jsreport.net/img/js-logo.png', flex: 3 },
        { title: 'MySql', text:'is an open-source relational database management system.', src: 'https://www.mysql.com/common/logos/logo-mysql-170x115.png', flex: 3 },
        { title: 'Nginx', text:'used as a reverse proxy, load balancer, https handling and securing access to resource on the vitual network', src: 'https://www.nginx.com/wp-content/uploads/2019/10/NGINX-Logo-White-Endorsement-RGB.svg', flex: 3 },
        { title: 'Docker', text:'is a set of platform as a service products that uses OS-level virtualization to deliver software in packages called containers.', src: 'https://www.docker.com/sites/default/files/d8/2019-07/horizontal-logo-monochromatic-white.png', flex: 3 },
        { title: 'Docker-Compose', text:'is a tool for defining and running multi-container Docker applications, providing basic orchestation.', src: 'https://raw.githubusercontent.com/docker/compose/master/logo.png', flex: 3 },
        { title: '', text:'fully open source stack', src: 'https://opensource.org/files/osi_reversing_logotype_color_to_white_1.png', flex: 3 },
        { title: 'Ubuntu Linux', text:'', src: 'https://assets.ubuntu.com/v1/1be42010-cof_orange_hex.jpg', flex: 3 },
      ],
  }),
}
</script>
