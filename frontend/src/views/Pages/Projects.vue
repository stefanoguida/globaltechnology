<template>
  <div class="content">
    <base-header class="pb-6">
      <div class="row align-items-center py-4">
        <div class="col-lg-12 col-5 text-right">
          <base-button size="xl" type="neutral" @click="openCreateModal">Nuovo</base-button>
        </div>
      </div>
    </base-header>

    <!-- Create modal-->
    <modal :show.sync="modal.show" size="lg" body-classes="p-0">
      <card type="secondary" header-classes="bg-transparent pb-5" body-classes="px-lg-5 py-lg-5" class="border-0 mb-0">
        <template>
          <div class="text-muted mb-4">
            <small>{{modal.title}}</small>
          </div>
          <form role="form">
            <div v-for="field in modal.fields">
              <base-input v-if="field.type == 'input'" :label="field.label" v-model="modal.data[field.prop]" alternative class="mb-3" :placeholder="field.label" ></base-input>
              <base-input v-else-if="field.type == 'select'" :label="field.label" alternative class="mb-3" :placeholder="field.label" >
                <select class="form-control" v-model="modal.data[field.prop]">
                  <option v-for="option in field.options" :value="option.value">{{ option.text }}</option>
                </select>
              </base-input>
              <base-input v-else-if="field.type == 'date'" type="date" :label="field.label" v-model="modal.data[field.prop]" alternative class="mb-3" :placeholder="field.label" ></base-input>
              <base-input v-else-if="field.type == 'textarea'" :label="field.label" alternative class="mb-3" :placeholder="field.label">
                <textarea v-model="modal.data[field.prop]" class="form-control" rows="3"></textarea>
              </base-input>
              <base-input v-else-if="field.type == 'slider'" :label="field.label" alternative class="mb-3" >
                <base-slider v-model="modal.data[field.prop]" :options="slider.options"></base-slider>
              </base-input>
            </div>
            <div class="text-right">
              <base-button type="primary" class="my-4" @click="modal.show = false">Annulla</base-button>
              <base-button type="primary" class="my-4" @click="handleSaveCustomer">Salva</base-button>
            </div>
          </form>
        </template>
      </card>
    </modal>

    <div class="container-fluid mt--6">
      <div>
        <card class="no-border-card" body-classes="px-0 pb-1" footer-classes="pb-2">
          <template slot="header">
            <h3 class="mb-0">{{ title }}</h3>
          </template>
          <div>
            <div class="col-12 d-flex justify-content-center justify-content-sm-between flex-wrap">
              <el-select class="select-primary pagination-select" v-model="pagination.perPage" placeholder="Per page" >
                <el-option class="select-primary" v-for="item in pagination.perPageOptions" :key="item" :label="item" :value="item" ></el-option>
              </el-select>

              <div>
                <base-input v-model="searchQuery" prepend-icon="fas fa-search" placeholder="Search..."> </base-input>
              </div>
            </div>

            <el-table :data="queriedData" row-key="id" header-row-class-name="thead-light" @sort-change="sortChange" >
              <!-- All columns -->
              <el-table-column v-for="column in tableColumns" :key="column.label" v-bind="column" :formatter="column.formatter">
                <template v-slot="{row}" v-if="column.prop == 'completamento'">
                  <div class="align-items-center">
                    <span class="mr-2">{{row.completamento}}%</span>
                    <base-progress :type="row.completamento > 66 ? 'success' : row.completamento >= 33 ? 'warning' : 'danger'" :value="row.completamento" />
                  </div>
                </template>
              </el-table-column>
              <!-- Action Column -->
              <el-table-column align="right" label="Actions">
                <div slot-scope="{$index, row}" class="d-flex">
                  <base-button @click.native="openUpdateModal($index, row)" class="edit" type="warning" size="sm" icon >
                    <i class="text-white ni ni-ruler-pencil"></i>
                  </base-button>
                  <base-button @click.native="handleDelete($index, row)" class="remove btn-link" type="danger" size="sm" icon>
                    <i class="text-white ni ni-fat-remove"></i>
                  </base-button>
                </div>
              </el-table-column>
            </el-table>

          </div>

          <div slot="footer" class="col-12 d-flex justify-content-center justify-content-sm-between flex-wrap">
            <div class="">
              <p class="card-category">
                <!-- Showing {{ from + 1 }} to {{ to }} of {{ total }} entries -->
                <span v-if="selectedRows.length">
                  &nbsp; &nbsp; {{selectedRows.length}} righe selezionate
                </span>
              </p>
            </div>
            <base-pagination class="pagination-no-border" v-model="pagination.currentPage" :per-page="pagination.perPage" :total="total"></base-pagination>
          </div>

        </card>
      </div>
    </div>
  </div>
</template>
<script>
import { Table, TableColumn, Select, Option } from 'element-ui';
import RouteBreadCrumb from '@/components/Breadcrumb/RouteBreadcrumb'
import { BasePagination, BaseProgress, BaseSlider } from '@/components';
import searchTableMixin from '../Tables/PaginatedTables/searchTableMixin'
import swal from 'sweetalert2';
import { Modal } from '@/components';
import moment from 'moment'

import * as __ from '../../store/constants'

export default {
  mixins: [searchTableMixin],
  components: {
    Modal,
    BasePagination,
    BaseProgress,
    BaseSlider,
    RouteBreadCrumb,
    [Select.name]: Select,
    [Option.name]: Option,
    [Table.name]: Table,
    [TableColumn.name]: TableColumn
  },
  data() {
    return {
      model: 'progetto',
      title: 'Progetti',
      searchColumns: ['cliente','impianto','luogo'],
      hiddenColumns: ['trec','created_at','created_by','updated_at','updated_by'],
      tableColumns: [],
      tableData: [],
      selectedRows: [],
      slider: {
        options:{
            step:5,
            tooltips:true
          }
      },
      pagination:{
        perPage:25
      },
      modal: {
        fields:[],
        hiddenColumns: ['id','trec','created_at','created_by','updated_at','updated_by'],
        show: false,
        type: '', //insert|update
        title: '',
        data: {}
      }
    };
  },
  created() {
    this.$watch(
      () => this.$route.params,
      () => { this.fetchData() },
      {immediate: true}
    )
  },
  methods: {
    async fetchData( ) {
      
      await this.$store.dispatch(__.GETALL,this.model)
      await this.$store.dispatch(__.GETALL,'cliente')
      await this.$store.dispatch(__.GETALL,'stato_progetto')
      
      this.modal.fields = this.$store.state.projects.fields
      .filter( f => !this.modal.hiddenColumns.includes(f))
      .map( f => {
        switch(f){
          case 'cliente':
            return {
              type: 'select',
              prop: f, 
              label: f.replace(/^\w/, c => c.toUpperCase()),
              options: this.$store.getters.customerSelectOptions
            }
          case 'stato':
            return {
              type: 'select',
              prop: f, 
              label: f.replace(/^\w/, c => c.toUpperCase()),
              options: this.$store.getters.statusProjectSelectOptions
            }
          case 'data_inizio':
          case 'data_fine':
            return {
              type: 'date',
              prop: f, 
              label: f.replace(/^\w/, c => c.toUpperCase())
            }
          case 'completamento':
            return {
              type: 'slider',
              prop: f, 
              label: f.replace(/^\w/, c => c.toUpperCase())
            }
          case 'commenti':
            return {
              type: 'textarea',
              prop: f,
              label: f.replace(/^\w/, c => c.toUpperCase())
            }
          default: 
            return {
              type: 'input',
              prop: f, 
              label: f.replace(/^\w/, c => c.toUpperCase()),
            }
        }
      })

      this.tableColumns = this.$store.state.projects.fields
      .filter( f => !this.hiddenColumns.includes(f))
      .map( f => {
        switch(f){
          case 'data_inizio':
          case 'data_fine':
            return {
              formatter: (row, column) => moment(row[column.property]).format('YYYY-MM-DD'),
              prop: f, 
              sortable: true,
              label: f.replace(/^\w/, c => c.toUpperCase())
            }
          default: 
            return {
              formatter: (row, column) => row[column.property],
              prop: f, 
              sortable: true,
              label: f.replace(/^\w/, c => c.toUpperCase()),
            }
          }
        })
      
      // this.tableColumns.unshift({type: 'selection'}) // Aggiunta in testa della colonna per la selezione multipla delle righe

      this.tableData = this.$store.state.projects.records.map( record => 
        Object.keys(record)
        .filter((key) => !this.hiddenColumns.includes(key))
        .reduce((cur, key) => {
          return Object.assign(cur, { [key]: key == 'cliente' ? (this.$store.state.customers.records.filter( i => i.id == record[key] ).pop() || {}).ragione_sociale : record[key] })
        }, {})
      )
    },
    openCreateModal(){
      this.modal.type = 'insert'
      this.modal.data = {}
      this.modal.show = true
      this.modal.title = 'Crea nuovo progetto'
    },
    openUpdateModal(index, row){
      this.modal.type = 'update'
      this.modal.data = Object.entries(row).reduce( (a,c) => {
        switch(c[0]){
          case "data_inizio":
          case "data_fine":
            a[c[0]] =  moment(c[1]).format('YYYY-MM-DD')
            break
          case "cliente":
            a[c[0]] = (this.$store.state.customers.records.filter( r => r.ragione_sociale == c[1]).pop()).id
            break;
          case "stato":
            a[c[0]] = (this.$store.state.projectStatus.records.filter( r => r.name.toLowerCase() == c[1]).pop()).code
            break;
          default:
            a[c[0]] = c[1]
            break;
        }
        return a
      },{})
      this.modal.condition = [{field: 'id', op: '=', value: row.id}]
      this.modal.show = true
      this.modal.title = 'Modifica progetto'
    },
    async handleSaveCustomer () {
      const method = this.modal.type == 'insert' ? __.INSERT : __.UPDATE
      const data = {
        model: this.model, 
        payload: this.modal.data, 
        cond: this.modal.condition || []
      }

      const response = await this.$store.dispatch(method, data)
      if ( response.error ) {
        this.$notify({type:'danger', message:response.message})
        this.modal = { ...this.modal, type: '', title: '', data: {} }
      }
      else {
        this.$notify({type:'success', message: `Progetto salvato correttamente`})
        await this.fetchData()
        this.modal.show = false
      }
    },
    handleDelete(index, row) {
      swal.fire({
        title: 'Sicuro?',
        text: `Questa azione non può essere annullata!`,
        type: 'warning',
        showCancelButton: true,
        confirmButtonClass: 'btn btn-success btn-fill',
        cancelButtonClass: 'btn btn-danger btn-fill',
        confirmButtonText: 'Si, cancella!',
        cancelButtonText: 'Annulla',
        buttonsStyling: false
      })
      .then(result => {
        if (result.value) {
          this.deleteRow(row);
          swal.fire({
            title: 'Cancellato!',
            text: `Hai cancellato ${JSON.stringify(row)}`,
            type: 'success',
            confirmButtonClass: 'btn btn-success btn-fill',
            buttonsStyling: false
          });
        }
      })
      .catch( () => {
        swal.fire({
            title: 'Errore!',
            text: `Impossibile cancellare record`,
            icon: 'error'
          });
      })
    },
    async deleteRow(row) {
      await this.$store.dispatch(__.DELETE,{model:this.model, id:row.id})
      let indexToDelete = this.tableData.findIndex(
        tableRow => tableRow.id === row.id
      );
      if (indexToDelete >= 0) {
        this.tableData.splice(indexToDelete, 1);
      }
    },
    selectionChange(selectedRows) {
      this.selectedRows = selectedRows
    }
  }
};
</script>
<style>
  .no-border-card .card-footer{
    border-top: 0;
  }
</style>
