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
          title='Positions'
          text=''
        >
                    <!-- To enable server-side search to work don't pass the search prop to v-data-table -->
                    <v-container grid-list-md text-xs-center>
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
                        <v-btn color='green' small :to='`/positions/new`'><v-icon x-small>mdi-playlist-plus</v-icon> Nuevo</v-btn>
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
                        </div>
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
        { text: 'Company', value: 'company.name' },
        { text: 'Deleted', value: 'deleted' },
        { text: 'Name', value: 'name' },
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
    const count = app.$axios.$get('/positions/count')
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
            listOfFields: ['company', 'deleted', 'id', 'name', 'created_at', 'updated_at']
        }
    }
},
mounted() {

},
created() { this.getPagedData() },
methods: {
    goToEdit(id){
        this.$router.push('/positions/' + id + '/edit')
    },    
    async getPagedData() {
            const response = await this.$axios.$post('/graphql', {
                query: `query {
                    positions(start: ${(this.pagination.page - 1) * this.pagination.rowsPerPage},
                    limit: ${this.pagination.rowsPerPage},
                    sort: "${this.pagination.sortBy}:${
                    this.pagination.descending ? "asc" : "desc"
                }", 
                    where: { 
                        ${this.pagination.filterByField}_contains: "${this.search}"
                    }) {
                          company { id name }
                          deleted
                          id
                          name
                          created_at
                          updated_at
                        }
                }`
            })
            this.loading = false
            this.items = response.data.positions
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

