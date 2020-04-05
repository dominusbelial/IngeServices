<template>
  <v-container>
    <v-layout row class="text-xs-center">
      <v-flex height="500px" class="gray lighten-2">
        <v-container style class="text-xs-center">
          <v-card>
            <br>

             <v-card-title primary-title>
              <h1>Login</h1>
            </v-card-title> 
            <v-snackbar
              v-model="snackbarError" top
            >
              Error.
              <v-btn
                color="red"
                text
                @click="snackbarError = false"
              >
                Close
              </v-btn>
            </v-snackbar>

            <v-card-text>
              <v-form ref='form' v-model='valid' lazy-validation>
                <v-text-field
                  clearable
                  v-model="Username"
                  required
                  :counter="255"
                  :rules="UsernameRules" 
                  prepend-icon="mdi-account"
                  name="Username"
                  label="Usuario"
                  ref="refToElementUsuario"
                  @keyup.enter.stop="login()"
                ></v-text-field>

                <v-text-field
                  clearable
                  v-model="Password"
                  required
                  :rules="PasswordRules"         
                  :counter="255"
                  prepend-icon="mdi-lock"
                  name="Password"
                  label="Password"
                  type="password"
                  @keyup.enter.stop="login()"
                ></v-text-field>
              </v-form>

            </v-card-text>

            <v-card-actions>
              <v-btn color="green" :disabled="!valid" primary large @click.stop="login()">Iniciar</v-btn>
              <v-btn color="red" primary large @click.stop="logout()">Cerrar</v-btn>
            </v-card-actions>
          </v-card>
        </v-container>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
const Cookie = process.client ? require('js-cookie') : undefined

export default {
  layout: 'default',
  middleware: 'notAuthenticated',
  asyncData({ store }) {

      return {
        Username: 'user',
        Password: 'abcd1234'
      }
  },
  data() {
    return {
      valid: false,
      snackbarError:false,
      Username: '',
      UsernameRules: [
        v => !!v || 'Username es requerido.',
        v => (v && v.length <= 255) || 'longitud: Username debe ser menor a 255.',
        v => (v && v.length >= 3) || 'longitud: Username debe ser mayor a 3.'
      ],      
      Password: '',
      PasswordRules: [
        v => !!v || 'Password es requerido.',
        v => (v && v.length <= 255) || 'longitud: Password debe ser menor a 255.',
        v => (v && v.length >= 3) || 'longitud: Password debe ser mayor a 3.'
      ]
    }
  },
  mounted() {
    this.$nextTick(() => this.$refs.refToElementUsuario.focus())
  },
  methods: {
    logout() {
      const auth = Cookie.getJSON('auth')
      if (auth) {
        Cookie.remove('auth')
        this.$store.commit('setAuth', null)
        this.$axios.setToken(null, 'Bearer')
        this.$axios.setHeader('Authorization', null)
      }
      window.location.reload(true)
    },
    async login() {
      try {
        if (!this.$refs.form.validate()) {
          this.snackbarError = true;
        }
        const response = await this.$axios.$post('/auth/local', {
          identifier: this.Username,
          password: this.Password
        })
        this.$store.commit('setAuth', response)
        Cookie.set('auth', response)
        this.$axios.setToken(response.jwt, 'Bearer')
        this.$axios.setHeader('Authorization', 'Bearer ' + response.jwt)
        this.$nuxt.$router.push('/')
      } catch (e) {
        this.snackbarError = true;
      }
    }
  }
}
</script>

<style scoped>

</style>
