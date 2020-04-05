<template>
    <v-container
    fill-height
    fluid
    grid-list-xl
  >
    <v-layout
      justify-center
      wrap
    >
      <v-flex
        md12
      >
        <v-card
          color='black'
          title='Certificates'
          text=''
        >
                    <v-container grid-list-md text-xs-center>
                    <v-subheader>Certificates</v-subheader>
                    <v-layout row wrap>
                    <v-flex xs4>
                        <v-text-field
                        dense
                        label='Buscar'
                        v-model='search'
                        ref='refToSearch'
                        v-on:keyup.enter='getPagedData'
                        append-outer-icon='mdi-send'
                        @click:append-outer='getPagedData'
                        clearable
                        outlined                      
                        >
                        </v-text-field>
                    </v-flex>
                    <v-flex xs4>
                        <v-select dense outlined label='Filtrar x' v-model='pagination.filterByField' :items='pagination.listOfFields'></v-select>
                    </v-flex>
                    <v-flex xs4>
                        <v-select dense outlined label='x Pagina' v-model='pagination.rowsPerPage' :items='pagination.rowsPerPageItems'></v-select>
                    </v-flex>
                    </v-layout>
                    </v-container>                    
                    <v-layout row justify-center wrap>
                        <v-btn color='green' small :to='`/certificates/new`'><v-icon x-small>mdi-playlist-plus</v-icon> Nuevo</v-btn>
                        <v-pagination v-model='pagination.page' total-visible='5' :length='pagination.totalPages'></v-pagination>
                    </v-layout>
                    <br>                    
                    <v-data-table
                    dense
                    :headers='headers'
                    :items='items'
                    :loading='loading'
                    :server-items-length='pagination.totalItems'
                    :items-per-page='pagination.rowsPerPage'
                    :sort-by.sync='pagination.sortBy'
                    :sort-desc.sync='pagination.descending'
                    must-sort
                    hide-default-footer
                    class='elevation-24'
                    >
                    <template
                    v-slot='headerCell'
                    v-slot-scope='{ header }'
                    >
                        <span
                            class='subheading font-weight-light text--darken-3'
                            v-text='header.text'
                        />
                    </template>
                    <template v-slot:item.id='{ item }'>
                        <div v-bind:class='{ isinactive : !item.estado }' style='white-space: nowrap;background-color:#6495ed;'>
                            &nbsp;{{item.id}}
                            <v-icon @click='goToEdit(item.id)'>mdi-pencil</v-icon>
                            <v-icon @click="onPrintClickHandler(item.id)">mdi-printer</v-icon>
                        </div>
                    </template>
                    <template v-slot:item.data-table-expand='{ expand, isExpanded }'>
                        <v-icon @click='expand(!isExpanded)'> {{ isExpanded ? 'mdi-chevron-down' : 'mdi-chevron-up' }}</v-icon>
                    </template>
                    <template v-slot:expanded-item='{ headers, item }'>
                        <td :colspan='headers.length'>
                        <v-container grid-list-md pa-0 ma-0>
                            <v-data-iterator
                                :items='item.ordenproductos'
                                hide-default-footer
                                light
                            >
                                <template v-slot:default='props'>
                                <div style='flex-wrap: nowrap; justify-content: flex-start; display: flex; flex-direction: row;'>
                                    <v-card
                                    v-for='item in props.items'
                                    :key='item.id'
                                    style='max-width: 200px;min-width: 200px;margin-right: 15px;margin-top: 15px;margin-bottom: 15px;'                                    
                                    >
                                    <v-card-title class='subtitle-2 font-weight-bold warning'>{{ item.productos.materiales.nombre }}</v-card-title>                      
                                    <v-divider></v-divider>                                  
                                    <v-list dense>
                                        <v-list-item key='cantidad'><v-list-item-content>
                                        
                                        <v-list-item-title class='align-end'>Cantidad: {{ item.cantidad }} Kgs</v-list-item-title>
                                        </v-list-item-content></v-list-item>
                                        <v-list-item key='valorhistoricokg'><v-list-item-content>
                                        
                                        <v-list-item-title class='align-end'>Valor {{ item.valorhistoricokg | toCurrency }}/Kg</v-list-item-title>
                                        </v-list-item-content></v-list-item>
                                        <v-list-item key='empaque'><v-list-item-content>
                                        
                                        <v-list-item-title class='align-end'>Empaque: {{ item.empaque }}</v-list-item-title>
                                        </v-list-item-content></v-list-item>
                                        <v-list-item key='malla'><v-list-item-content>
                                        
                                        <v-list-item-title class='align-end'>Malla: {{ item.productos.mallas.nombre }}</v-list-item-title>
                                        </v-list-item-content></v-list-item>                                        
                                    </v-list>
                                    </v-card>
                                </div>
                                </template>
                            </v-data-iterator>
                        </v-container>
                        </td> 
                    </template>
                    </v-data-table>
        </v-card>
        </v-flex>
        </v-layout>
    </v-container>
</template>

<script>
export default {    
middleware: ['authenticated'],
components: {  },
data() {
    return {
    toggle_multiple: [0, 1, 2],        
    search: '',
    pagination: {},
    loading: true,
    headers: [
        { text: 'Id', value: 'id' },
        { text: 'Cedula', value: 'cedula' },
        { text: 'City', value: 'city' },
        { text: 'Company', value: 'company.name' },
        { text: 'Course', value: 'course.name' },
        { text: 'Date', value: 'date' },
        { text: 'Deleted', value: 'deleted' },
        { text: 'Fecha', value: 'fecha' },
        { text: 'Legal_representative', value: 'legal_representative.name' },
        { text: 'Name', value: 'name' },
        { text: 'Teacher', value: 'teacher.name' },
        { text: 'Created_at', value: 'created_at' },
        { text: 'Updated_at', value: 'updated_at' },
    ],
    items: []
    }
},
computed: {},
watch: {
    pagination: {
    handler() {
        this.loading = true
        this.getPagedData()
    },
    deep: true
    }
},
asyncData({ error, app }) {
    const count = app.$axios.$get('/certificates/count')
    return {
        pagination: {
            totalItems: count,
            totalPages: 0,
            rowsPerPage: 5,
            page: 1,
            sortBy: 'id',
            descending: false,
            rowsPerPageItems: [5, 10, 20, 30, 50],
            filterByField: 'id',
            listOfFields: ['cedula', 'city', 'company', 'course', 'date', 'deleted', 'fecha', 'id', 'legal_representative', 'name', 'teacher', 'created_at', 'updated_at']
        }
    }
},
mounted() {

},
created() { this.getPagedData() },
methods: {
    goToEdit(id){
        this.$router.push('/certificates/' + id + '/edit')
    },
    async onPrintClickHandler(id) {
         const responseOrden = await this.$axios.$post('/graphql', {
            query: `query {
                    certificates(where: { id: "${id}" }) {
                        id
                        name
                        created_at
                        updated_at
                        cedula
                        company{
                        id name
                        }
                        legal_representative{
                        id name
                        }
                        teacher{
                        id name
                        }
                        course{
                        id name
                        }
                        date
                        city
                        deleted
                    }
                }`
            })
            const entryKey = btoa(`${process.env.baseReportsUser}:${process.env.baseReportsKey}`)
            const response = await this.$axios.$post(process.env.baseReportsUrl,
            {
                "template": { "shortid": "SylbDp_IvI" },
                "data": responseOrden.data.certificates[0]
            },
            {
                responseType: 'arraybuffer',
                "headers": { "Authorization": "Basic " + entryKey, "Content-Type": "application/json", 'Accept': 'application/pdf' }
            })
            this.loading = false
            const blob = new Blob([response], { type: 'application/pdf' })
            const link = document.createElement('a')
            link.href = window.URL.createObjectURL(blob)
            link.download = 'test.pdf'
            link.click()
    },        
    async getPagedData() {
            const response = await this.$axios.$post('/graphql', {
                query: `query {
                    certificates(start: ${(this.pagination.page - 1) * this.pagination.rowsPerPage},
                    limit: ${this.pagination.rowsPerPage},
                    sort: "${this.pagination.sortBy}:${
                    this.pagination.descending ? "asc" : "desc"
                }", 
                    where: { 
                        ${this.pagination.filterByField}_contains: "${this.search}"
                    }) {
                          cedula
                          city
                          company { id name }
                          course { id name }
                          date
                          deleted
                          id
                          legal_representative { id name }
                          name
                          teacher { id name }
                          created_at
                          updated_at
                        }
                }`
            })
            this.loading = false
            this.items = response.data.certificates
            this.pagination.totalPages = Math.round(this.pagination.totalItems / this.pagination.rowsPerPage)
    }
},
}
</script>

<style>
.container.grid-list-md {
    margin-bottom: -30px;
}
thead.v-data-table-header {
    text-decoration:underline;
    white-space: nowrap;
}
.isdeleted {
    background-color: black;
    color:#f55a4e;
    font-style: italic;
    text-decoration: line-through;
}
.isinactive {
    background-color: black;
}
td div.v-input.v-input--checkbox {
  margin-top: 0;  
}
.v-btn {
  min-width: 0;
}
.contentExpand {
    display: inline-flex !important;
    flex-direction: row !important;
    flex-wrap: nowrap !important;
    background-color: gray;
    align-content: flex-start !important;
    justify-content: left !important;
    align-items: stretch !important;
    width: 100%;
}

table .v-sheet:hover {
    background-color: #fff;
    border-color: #fff;
    color: black;
}

table .v-list>div:hover {
    background-color: #fff;
    border-color: #fff;
    color: black;
}
</style>

