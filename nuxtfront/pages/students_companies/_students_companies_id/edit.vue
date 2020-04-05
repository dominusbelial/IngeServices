<template>
  <v-container
    fill-height
    fluid
    grid-list-xl
    >
    <v-layout justify-center wrap>
      <v-flex md12>
        <v-card 
          color='black' 
          title='Editar Students_companies' 
          text
          >
          <v-form ref='form' v-model='valid' lazy-validation>


                 <v-text-field
                    
                    
                    v-model="name"
                    :counter="255"
                    :rules="nameRules"
                    label="Name"
                    required ref="primerFieldRef"
                ></v-text-field>



                </v-form>
            <v-card-actions>
              <v-btn primary large :disabled="!valid" color="success" @click="validate">
                <v-icon>mdi-content-save</v-icon>
              </v-btn>
              <v-btn primary large color="warning" @click="goBack">
                <v-icon>mdi-arrow-left</v-icon>
              </v-btn>
            </v-card-actions>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>

const Cookie = process.client ? require('js-cookie') : undefined
const auth = Cookie.getJSON('auth')
export default {   
  middleware: ['authenticated'],
  components: { },
  async asyncData({ params, error, app }) {
      const response = await app.$axios.$get('students-companies?id=' + params.students_companies_id)
      return response[0]
  },
  data: {
     valid: false,
     name: '',
     nameRules: [
       v => !!v || 'Name es requerido.',
       v => (v && v.length <= 255) || 'longitud: Name debe ser menor a 255.',
       v => (v && v.length >= 3) || 'longitud: Name debe ser mayor a 3.'
     ],
  },
  watch: {
  },
  methods: {
    async validate() {
        if (this.$refs.form.validate()) {
          await this.$axios.$put('students-companies/' + this.id, {
            name: this.name,
          })
          this.goBack()
        }
    },    reset() {
      this.$refs.form.reset()
      this.$refs.form.resetValidation()
    },
    resetValidation() {
      this.$refs.form.resetValidation()
    },
    goBack() {
      this.$router.push({ path: '/students_companies' })
    }
  },
  mounted() {
    // this.$nextTick(() => this.$refs.primerFieldRef.focus())      
  },
  created() {
  },
  computed: {}
}
</script>

<style>
</style>

