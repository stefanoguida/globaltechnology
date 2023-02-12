<template>
  <div class="content">
    <dashboard-header>
      <template slot="footer">
        <div class="row align-items-center py-4">
          <div class="col-lg-12 col-5 text-right">
            <!-- <base-button size="xl" type="primary" @click="handleShowPDF" :disabled="!Object.keys(selectedRow).length">Mostra PDF offerta {{ selectedRow.id }}</base-button> -->
            <base-button size="xl" type="neutral" @click="openCreateModal">Nuovo</base-button>
          </div>
        </div>
      </template>
    </dashboard-header>

    <!-- Create modal-->
    <modal :show.sync="modal.show" size="lg" body-classes="p-0">
      <card type="secondary" header-classes="bg-transparent pb-5" body-classes="px-lg-5 py-lg-5" class="border-0 mb-0">
        <template>
          <div class="text-muted mb-4">
            <small>{{modal.title}}</small>
          </div>
          <form role="form">
            <div v-for="field in modal.fields">
              <base-input :type="field.type" :label="field.label" v-model="modal.data[field.prop]" alternative class="mb-3" :placeholder="field.label" >
                  <select v-if="field.type == 'select'" class="form-control" v-model="modal.data[field.prop]" filterable>
                    <option v-for="option in field.options" :value="option.value">{{ option.text }}</option>
                  </select>
                  <textarea v-if="field.type == 'textarea'" v-model="modal.data[field.prop]" class="form-control" rows="3"></textarea>
              </base-input>
            </div>
            <div class="text-right">
              <base-button type="primary" class="my-4" @click="modal.show = false">Annulla</base-button>
              <base-button type="primary" class="my-4" @click="handleSave">Salva</base-button>
            </div>
          </form>
        </template>
      </card>
    </modal>

    <!-- HEAD -->
    <div class="container-fluid mt--6">
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
                <el-form :inline="true" :model="filters">
                  <el-form-item>
                    <el-select placeholder="Cliente" v-model="filters.id_cliente" filterable>
                      <el-option value=""></el-option>
                      <el-option v-for="customer in customerSelectOptions" :key="customer.value" :label="customer.text" :value="customer.value"></el-option>
                    </el-select>
                  </el-form-item>

                  <el-form-item>
                    <el-select placeholder="Progetto" v-model="filters.id_progetto" filterable>
                      <el-option value=""></el-option>
                      <el-option v-for="project in projectSelectOptions" :key="project.value" :label="project.text" :value="project.value"></el-option>
                    </el-select>
                  </el-form-item>

                  <el-form-item>
                    <el-select placeholder="Stato" v-model="filters.id_stato" filterable>
                      <el-option value=""></el-option>
                      <el-option v-for="status in statusOfferSelectOptions" :key="status.value" :label="status.text" :value="status.value"></el-option>
                    </el-select>
                  </el-form-item>

                  <el-form-item>
                    <base-button type="primary" @click="handleSearch">Cerca</base-button>
                  </el-form-item>

                </el-form >
              </div>
            </div>
  
            <el-table 
              :data="queriedData" 
              row-key="id" 
              header-row-class-name="thead-light" 
              @sort-change="sortChange" 
              @current-change="handleRowSelect"
            > 
              <!-- All columns -->
              <el-table-column 
                v-for="column in tableColumns" 
                :key="column.label" 
                v-bind="column" 
                :formatter="column.formatter"
                :min-width="column.minWidth||0"
                label-class-name="custom-header-class"
              ></el-table-column>
              <!-- Action Column -->
              <el-table-column align="right" label="Actions" :min-width="120">
                <div slot-scope="{$index, row}" class="d-flex">
                  <base-button @click.native="openUpdateModal($index, row)" class="edit" type="warning" size="sm" icon >
                    <i class="text-white ni ni-ruler-pencil"></i>
                  </base-button>
                  <base-button @click.native="handleDelete($index, row)" class="remove btn-link" type="danger" size="sm" icon>
                    <i class="text-white fa fa-trash"></i>
                  </base-button>
                </div>
              </el-table-column>
            </el-table>
  
          </div>
  
          <div slot="footer" class="col-12 d-flex justify-content-center justify-content-sm-between flex-wrap">
            <base-pagination class="pagination-no-border" v-model="pagination.currentPage" :per-page="pagination.perPage" :total="total"></base-pagination>
          </div>
  
        </card>
    </div>

  </div>
</template>
<script>
import { Table, TableColumn, Select, Option, Form, FormItem, DatePicker, Row, Col, Card } from 'element-ui';
import RouteBreadCrumb from '@/components/Breadcrumb/RouteBreadcrumb'
import FileInput from '@/components/Inputs/FileInput'
import { BasePagination } from '@/components';
import searchTableMixin from '../Tables/PaginatedTables/searchTableMixin'
import swal from 'sweetalert2';
import { Modal } from '@/components';
import pdf from 'vue-pdf'
import moment from 'moment'
import lodash from 'lodash'

import DashboardHeader from '../Dashboard/DashboardHeader.vue';
import * as __ from '../../store/constants'

export default {
  mixins: [searchTableMixin],
  components: {
    DashboardHeader,
    Modal,
    BasePagination,
    RouteBreadCrumb,
    FileInput,
    [Row.name]: Row,
    [Col.name]: Col,
    [Card.name]: Card,
    [Form.name]: Form,
    [FormItem.name]: FormItem,
    [DatePicker.name]: DatePicker,
    [Select.name]: Select,
    [Option.name]: Option,
    [Table.name]: Table,
    [TableColumn.name]: TableColumn
  },
  data() {
    return {
      model: 'milestone',
      title: 'Milestones',
      searchColumns: ['progetto'],
      hiddenColumns: ['trec','created_at','created_by','updated_at','updated_by','id_progetto','id_stato','id_cliente','id_tipo_progetto'],
      hiddenDetailColumns: ['id','trec','created_at','created_by','updated_at','updated_by','id_offerta','id_servizio','codice_fornitura'],
      tableColumns: [],
      tableData: [],
      tableDetailsColumns: [],
      tableDetailsData: [],
      selectedRows: [],
      selectedRow: {},
      pagination:{
        perPage:25
      },
      filters: {
        id_cliente: '',
        id_progetto: '',
        id_stato: ''
      },
      modal: {
        fields:[],
        hiddenColumns: ['id','trec','created_at','created_by','updated_at','updated_by', 'id_progetto', 'id_stato', 'id_cliente', 'id_tipo_progetto'],
        show: false,
        type: '', //insert|update
        title: '',
        data: {}
      },
      projectSelectOptions: [],
      statusOfferSelectOptions: [],
      customerSelectOptions: []
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
    handleSearch() {
      const headFilters = Object.fromEntries(Object.entries(this.filters).filter( el => el[1] ))
      const hasFilterHead = !lodash.isEmpty(headFilters)
      let filteredMilestones = []
      if( hasFilterHead ) {
        filteredMilestones = this.$store.state.milestone.records
        .filter( el => Object.entries(headFilters).every( f => f[1] ? el[f[0]] == f[1] : true))
      }
      this.tableData = filteredMilestones.length ? filteredMilestones : this.$store.state.milestone.records
    },

    async fetchData( ) {
      try {
        await Promise.all([
          this.$store.dispatch(__.GETALL,this.model),
          this.$store.dispatch(__.GETALL,'progetto'),
          this.$store.dispatch(__.GETALL,'cliente'),
          this.$store.dispatch(__.GETWHERE,{model: 'stato', cond: [{field: 'entita', op: '=', value: 'milestone'}]}),
        ])

        this.customerSelectOptions = this.$store.getters.customerSelectOptions
        this.projectSelectOptions = this.$store.getters.projectSelectOptions
        this.statusOfferSelectOptions = this.$store.getters.statusSelectOptions

        this.tableData = this.$store.state.milestone.records
        this.selectedRow = this.tableData.sort( (a,b) => a.id<b.id ? -1 : 1)[0]

        this.modal.fields = this.$store.state.milestone.fields
        .filter( f => !this.modal.hiddenColumns.includes(f))
        .map( f => {
          switch(f){
            default: 
              return {
                type: 'input',
                prop: f, 
                label: f.replace('_',' '),
              }
          }
        })

        this.tableColumns = this.$store.state.milestone.fields
        .filter( f => !this.hiddenColumns.includes(f))
        .map( f => {
          switch(f){
            default: 
              return {
                formatter: (row, column) => row[column.property],
                prop: f, 
                sortable: true,
                label: f.replace('_',' '),
              }
            }
          })
        
        this.handleSearch()
      }
      catch ( err ) {
        console.log(err)
      } 
    },

    handleRowSelect( row ){
      this.selectedRow = row
    },

    openCreateModal(){
      this.modal.type = 'insert'
      this.modal.data = {data_offerta: moment().format('YYYY-MM-DD'), id_stato: 1}
      this.modal.show = true
      this.modal.title = 'Crea nuovo contratto'
      this.modal.fields = this.modal.fields.filter( f => !['id_progetto','data_accettazione','importo_contrattato'].includes(f.prop))
    },

    openUpdateModal(index, row){
      this.modal.type = 'update'
      this.modal.data = Object.entries(row).reduce( (a,c) => {
        switch(c[0]){
          default:
            a[c[0]] = c[1]
            break;
        }
        return a
      },{})
      this.modal.condition = [{field: 'id', op: '=', value: row.id}]
      this.modal.show = true
      this.modal.title = 'Modifica contratto'
    },

    async handleSave () {
      const method = this.modal.type == 'insert' ? __.INSERT : __.UPDATE
      
      const payload = lodash.omit(this.modal.data, ['id', 'trec', 'created_at', 'created_by', 'updated_at', 'updated_by'])
      const data = {
        model: this.model, 
        payload: payload, 
        cond: this.modal.condition || []
      }

      const response = await this.$store.dispatch(method, data)
      if ( response.error ) {
        this.$notify({type:'danger', message:response.message})
        this.modal = { ...this.modal, type: '', title: '', data: {} }
      }
      else {
        this.$notify({type:'success', message: `Milestone successfully saved`})
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
            text: `Impossibile cancellare il record`,
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
    },

    handleFileChange(files){
      this.pdfmodal.newFile = files[0]
    },

  }
};
</script>
<style>
  .no-border-card .card-footer{
    border-top: 0;
  }
  .el-table__expand-icon{
    position: absolute;
    left: 23px;
    top: 20px;
  }
  .cell.custom-header-class {
    word-break: break-word;
  }
</style>
