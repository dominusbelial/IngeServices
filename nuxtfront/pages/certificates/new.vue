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
          title='Nuevo Certificates' 
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
                    v-model="city"
                    :counter="255"
                    :rules="cityRules"
                    label="City"
                     
                ></v-text-field>

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


                  <v-autocomplete
                    v-model="course"
                    :items="courseItems"
                    :search-input.sync="courseSearch"
                    item-text="name"
                    item-value="id"
                    placeholder="-- Seleccione Course --"
                    label="Course"
                    outlined
                    clearable
                  ></v-autocomplete>






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
     city: '',
     cityRules: [
     ],
     companySearch: null,
     company: null,
     companyItems: [],
     courseSearch: null,
     course: null,
     courseItems: [],
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
  }),
  watch: {
  },
  methods: {
    async validate() {
        if (this.$refs.form.validate()) {
          await this.$axios.post('certificates', {
            cedula: this.cedula,
            city: this.city,
            company: this.company,
            course: this.course,
            legal_representative: this.legal_representative,
            name: this.name,
            teacher: this.teacher,
          })
          this.goBack()
        }
    },
    async companyLoad(val) {
      this.companyItems = await this.$axios.$get('companies?' + (val ? 'name_contains=' + val + '&_sort=name:asc' : '_sort=name:asc'))
    },

    async courseLoad(val) {
      this.courseItems = await this.$axios.$get('courses?' + (val ? 'name_contains=' + val + '&_sort=name:asc' : '_sort=name:asc'))
    },

    async legal_representativeLoad(val) {
      this.legal_representativeItems = await this.$axios.$get('legal-representatives?' + (val ? 'name_contains=' + val + '&_sort=name:asc' : '_sort=name:asc'))
    },

    async teacherLoad(val) {
      this.teacherItems = await this.$axios.$get('teachers?' + (val ? 'name_contains=' + val + '&_sort=name:asc' : '_sort=name:asc'))
    },

    reset() {
      this.$refs.form.reset()
      this.$refs.form.resetValidation()
    },
    resetValidation() {
      this.$refs.form.resetValidation()
    },
    goBack() {
      this.$router.push({ path: '/certificates' })
    }
  },
  mounted() {
    // this.$nextTick(() => this.$refs.primerFieldRef.focus())
  },
  created() {
    this.companyLoad()
    this.courseLoad()
    this.legal_representativeLoad()
    this.teacherLoad()
  },
  computed: {}
}
</script>

<style>
</style>

