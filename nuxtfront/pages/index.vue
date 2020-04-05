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
        <logo />
        <vuetify-logo />
      </div>
      <v-card>
        <v-card-title class="headline">
          Welcome to the Technical Showcase by Gustavo Poveda.
        </v-card-title>
        <v-card-text>
          <p>
            <b>Nuxt.js</b> acting as Frontend is a free and open source web application framework based on Vue.js, Node.js, Webpack and Babel.js.
          </p>        
          <p><b>Vuetify</b> is a Material Design component framework for Vue.js. It aims to provide all the tools necessary to create beautiful content rich applications.</p>
          <p>
            <b>Strapi</b> acting as Backend is the next-gen headless CMS, open-source, javascript, enabling content-rich experiences to be created, managed and exposed to any digital device.
          </p>
          <p>
            <b>JsReport</b> is a reporting server which lets developers define reports using javascript templating engines.
          </p>
          <p><b>MySql</b> is an open-source relational database management system.
          </p>                      
          <p>
            <b>Nginx</b> used as a reverse proxy, load balancer, https handling and securing access to resource on the vitual network.
          </p>
          <p><b>Docker</b> is a set of platform as a service products that uses OS-level virtualization to deliver software in packages called containers. 
          </p>
          <p><b>Docker-Compose</b> is a tool for defining and running multi-container Docker applications.
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
  }
}
</script>
