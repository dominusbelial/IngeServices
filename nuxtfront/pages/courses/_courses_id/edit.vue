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
          title='Editar Courses' 
          text
          >
          <v-form ref='form' v-model='valid' lazy-validation>

                 <v-text-field type="number"
                    v-model="duration"
                    :counter="255"
                    :rules="durationRules"
                    label="Duration"
                     ref="primerFieldRef"
                ></v-text-field>


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
                    required 
                ></v-text-field>

                  <v-autocomplete
                    v-model="teacher"
                    :items="teacherItems"
                    :search-input.sync="teacherSearch"
                    item-text="name"
                    item-value="id"
                    placeholder="-- Seleccione Teacher --"
                    label="Teacher"
                    outlined
                    clearable
                  ></v-autocomplete>





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
      const response = await app.$axios.$get('courses?id=' + params.courses_id)
      response[0].legal_representativeItems = await app.$axios.$get('legal-representatives?' + '_sort=name:asc')
      response[0].teacherItems = await app.$axios.$get('teachers?' + '_sort=name:asc')
      return response[0]
  },
  data: {
     valid: false,
     duration: null,
     durationRules: [
            v => !!v || 'Duration es requerido.',
            ],
     legal_representativeSearch: null,
     legal_representative: null,
     legal_representativeItems: [],
     name: '',
     nameRules: [
       v => !!v || 'Name es requerido.',
       v => (v && v.length <= 255) || 'longitud: Name debe ser menor a 255.',
       v => (v && v.length >= 3) || 'longitud: Name debe ser mayor a 3.'
     ],
     teacherSearch: null,
     teacher: null,
     teacherItems: [],
  },
  watch: {
  },
  methods: {
    async validate() {
        if (this.$refs.form.validate()) {
          await this.$axios.$put('courses/' + this.id, {
            duration: this.duration,
            legal_representative: this.legal_representative,
            name: this.name,
            teacher: this.teacher,
          })
          this.goBack()
        }
    },
    async legal_representativeLoad(val) {
      this.legal_representativeItems = await this.$axios.$get('legal-representatives?' + (val ? 'name_contains=' + val + '&_sort=name:asc' : '_sort=name:asc'))
    },
    async legal_representativeLoadSingle(val) {
      if (val) {
        const response = await this.$axios.$get('legal-representatives?id_eq=' + val.id)
        this.legal_representativeItems.push(response[0])
      } else {
        this.legal_representativeLoad()
      }    
    },    

    async teacherLoad(val) {
      this.teacherItems = await this.$axios.$get('teachers?' + (val ? 'name_contains=' + val + '&_sort=name:asc' : '_sort=name:asc'))
    },
    async teacherLoadSingle(val) {
      if (val) {
        const response = await this.$axios.$get('teachers?id_eq=' + val.id)
        this.teacherItems.push(response[0])
      } else {
        this.teacherLoad()
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
      this.$router.push({ path: '/courses' })
    }
  },
  mounted() {
    // this.$nextTick(() => this.$refs.primerFieldRef.focus())      
  },
  created() {
    this.legal_representativeLoad()
    this.legal_representativeLoadSingle(this.legal_representative)
    this.teacherLoad()
    this.teacherLoadSingle(this.teacher)
  },
  computed: {}
}
</script>

<style>
</style>

