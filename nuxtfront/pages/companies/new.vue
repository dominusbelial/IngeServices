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
          title='Nuevo Companies' 
          text
          >
          <v-form ref='form' v-model='valid' lazy-validation>



                  <v-autocomplete
                    v-model="legal_representative"
                    :items="legal_representativeItems"
                    :search-input.sync="legal_representativeSearch"
                    item-text="name"
                    item-value="id"
                    placeholder="-- Seleccione Legal_representative --"
                    label="Legal_representative"
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
              <v-btn primary large color="error" @click="reset">
                <v-icon>mdi-close-circle</v-icon>
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
  data: () => ({
     valid: false,
     legal_representativeSearch: null,
     legal_representative: null,
     legal_representativeItems: [],
     name: '',
     nameRules: [
       v => !!v || 'Name es requerido.',
       v => (v && v.length <= 255) || 'longitud: Name debe ser menor a 255.',
       v => (v && v.length >= 3) || 'longitud: Name debe ser mayor a 3.'
     ],
  }),
  watch: {
  },
  methods: {
    async validate() {
        if (this.$refs.form.validate()) {
          await this.$axios.post('companies', {
            legal_representative: this.legal_representative,
            name: this.name,
          })
          this.goBack()
        }
    },
    async legal_representativeLoad(val) {
      this.legal_representativeItems = await this.$axios.$get('legal-representatives?' + (val ? 'name_contains=' + val + '&_sort=name:asc' : '_sort=name:asc'))
    },

    reset() {
      this.$refs.form.reset()
      this.$refs.form.resetValidation()
    },
    resetValidation() {
      this.$refs.form.resetValidation()
    },
    goBack() {
      this.$router.push({ path: '/companies' })
    }
  },
  mounted() {
    // this.$nextTick(() => this.$refs.primerFieldRef.focus())
  },
  created() {
    this.legal_representativeLoad()
  },
  computed: {}
}
</script>

<style>
</style>

