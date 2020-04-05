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
          title='Nuevo Teachers' 
          text
          >
          <v-form ref='form' v-model='valid' lazy-validation>
                 <v-text-field 
                    v-model="cedula"
                    :counter="255"
                    :rules="cedulaRules"
                    label="Cedula"
                    required ref="primerFieldRef"
                ></v-text-field>


                 <v-text-field 
                    v-model="name"
                    :counter="255"
                    :rules="nameRules"
                    label="Name"
                    required 
                ></v-text-field>

                  <v-autocomplete
                    v-model="position"
                    :items="positionItems"
                    :search-input.sync="positionSearch"
                    item-text="name"
                    item-value="id"
                    placeholder="-- Seleccione Position --"
                    label="Position"
                    outlined
                    clearable
                  ></v-autocomplete>




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
     cedula: '',
     cedulaRules: [
       v => !!v || 'Cedula es requerido.',
       v => (v && v.length <= 255) || 'longitud: Cedula debe ser menor a 255.',
       v => (v && v.length >= 3) || 'longitud: Cedula debe ser mayor a 3.'
     ],
     name: '',
     nameRules: [
       v => !!v || 'Name es requerido.',
       v => (v && v.length <= 255) || 'longitud: Name debe ser menor a 255.',
       v => (v && v.length >= 3) || 'longitud: Name debe ser mayor a 3.'
     ],
     positionSearch: null,
     position: null,
     positionItems: [],
  }),
  watch: {
  },
  methods: {
    async validate() {
        if (this.$refs.form.validate()) {
          await this.$axios.post('teachers', {
            cedula: this.cedula,
            name: this.name,
            position: this.position,
          })
          this.goBack()
        }
    },
    async positionLoad(val) {
      this.positionItems = await this.$axios.$get('positions?' + (val ? 'name_contains=' + val + '&_sort=name:asc' : '_sort=name:asc'))
    },

    reset() {
      this.$refs.form.reset()
      this.$refs.form.resetValidation()
    },
    resetValidation() {
      this.$refs.form.resetValidation()
    },
    goBack() {
      this.$router.push({ path: '/teachers' })
    }
  },
  mounted() {
    // this.$nextTick(() => this.$refs.primerFieldRef.focus())
  },
  created() {
    this.positionLoad()
  },
  computed: {}
}
</script>

<style>
</style>

