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
          title='Editar Positions' 
          text
          >
          <v-form ref='form' v-model='valid' lazy-validation>

                  <v-autocomplete
                    v-model="company"
                    :items="companyItems"
                    :search-input.sync="companySearch"
                    item-text="name"
                    item-value="id"
                    placeholder="-- Seleccione Company --"
                    label="Company"
                    outlined
                    clearable
                  ></v-autocomplete>




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
      const response = await app.$axios.$get('positions?id=' + params.positions_id)
      response[0].companyItems = await app.$axios.$get('companies?' + '_sort=name:asc')
      return response[0]
  },
  data: {
     valid: false,
     companySearch: null,
     company: null,
     companyItems: [],
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
          await this.$axios.$put('positions/' + this.id, {
            company: this.company,
            name: this.name,
          })
          this.goBack()
        }
    },
    async companyLoad(val) {
      this.companyItems = await this.$axios.$get('companies?' + (val ? 'name_contains=' + val + '&_sort=name:asc' : '_sort=name:asc'))
    },
    async companyLoadSingle(val) {
      if (val) {
        const response = await this.$axios.$get('companies?id_eq=' + val.id)
        this.companyItems.push(response[0])
      } else {
        this.companyLoad()
      }    
    },    
    reset() {
      this.$refs.form.reset()
      this.$refs.form.resetValidation()
    },
    resetValidation() {
      this.$refs.form.resetValidation()
    },
    goBack() {
      this.$router.push({ path: '/positions' })
    }
  },
  mounted() {
    // this.$nextTick(() => this.$refs.primerFieldRef.focus())      
  },
  created() {
    this.companyLoad()
    this.companyLoadSingle(this.company)
  },
  computed: {}
}
</script>

<style>
</style>

