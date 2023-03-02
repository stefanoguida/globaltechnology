<template>
  <div class="content">
    <dashboard-header>
      <template slot="footer">
        <div class="row align-items-center py-4">
          <div class="col-lg-12 col-5 text-right">
            <base-button size="xl" type="neutral" @click="openCreateModal">Nuovo</base-button>
          </div>
        </div>
      </template>
    </dashboard-header>

    <!-- Create modal-->
    <modal :show.sync="modal.show" @close="handleCloseModal" size="lg" body-classes="p-0">
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
                <base-slider v-model="modal.data[field.prop]" :options="field.options || slider.options"></base-slider>
                <label class="text-xs">Milestone: {{field.milestones}}</label>
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

    <milestone-modal 
      :show.sync="milestoneModal.show" 
      :editable="milestoneModal.editable"
      :tableColumns="milestoneModal.tableColumns" 
      :tableData="milestoneModal.tableData" 
      :id_contratto="milestoneModal.id_reference"
      :total="milestoneModal.total"
      @after-save="handleSaveMilestone">
    </milestone-modal>

    <modal :show.sync="preventCloseModal.show" type="notice">
      <template slot="header"> 
        <h2 id="modal-title-notification" class="modal-title">Attenzione</h2>
      </template>
      <template>
        <div class="py-3 text-center">
          <h4 class="heading mt-4">Stai per chiudere la finestra.</h4>
          <p>Continuare?</p>
        </div>
      </template>
      <template slot="footer"> 
        <div class="text-right">
          <base-button type="primary" class="my-4" @click="preventCloseModal.show = modal.show = false">Si</base-button>
          <base-button type="primary" class="my-4" @click="preventCloseModal.show = false">No</base-button>
        </div>
      </template>
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
                    <base-button type="primary" @click="handleSearch">Cerca</base-button>
                  </el-form-item>

                </el-form >
              </div>

            </div>

            <el-table :data="queriedData" row-key="id" header-row-class-name="thead-light" @sort-change="sortChange" >
              <!-- All columns -->
              <el-table-column 
              v-for="column in tableColumns" 
              :key="column.label" 
              v-bind="column" 
              :formatter="column.formatter" 
              label-class-name="custom-header-class"
              :min-width="column.minWidth"
              >
                <template v-slot="{row}" v-if="column.prop == 'completamento'">
                  <div class="align-items-center">
                    <span class="mr-2">{{row.completamento}}%</span>
                    <base-progress :type="row.completamento > 66 ? 'success' : row.completamento >= 33 ? 'warning' : 'danger'" :value="row.completamento" />
                  </div>
                </template>
              </el-table-column>
              <!-- Action Column -->
              <el-table-column align="right" label="Actions" :min-width="100">
                <div slot-scope="{$index, row}" class="d-flex">
                  <base-button @click.native="openMilestoneModal(row)" class="edit" type="warning" size="sm" icon >
                    <i class="ni ni-atom"></i>
                  </base-button>
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
import { Table, TableColumn, Select, Option, Form, FormItem, DatePicker, Row, Col, Card } from 'element-ui';
import RouteBreadCrumb from '@/components/Breadcrumb/RouteBreadcrumb'
import { BasePagination, BaseProgress, BaseSlider } from '@/components';
import searchTableMixin from '../Tables/PaginatedTables/searchTableMixin'
import swal from 'sweetalert2';
import { Modal } from '@/components';
import moment from 'moment'
import DashboardHeader from '../Dashboard/DashboardHeader.vue';

import * as __ from '../../store/constants'
import lodash from 'lodash'
import MilestoneModal from '../Components/MilestoneModal.vue';

export default {
  mixins: [searchTableMixin],
  components: {
    MilestoneModal,
    DashboardHeader,
    Modal,
    BasePagination,
    BaseProgress,
    BaseSlider,
    RouteBreadCrumb,
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
      model: 'progetto',
      title: 'Progetti',
      searchColumns: ['cliente','impianto','luogo'],
      hiddenColumns: ['trec','created_at','created_by','updated_at','updated_by','id_stato','id_cliente'],
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
      filters: {
        id_cliente: '',
        id_progetto: ''
      },
      modal: {
        fields:[],
        hiddenColumns: ['id','trec','created_at','created_by','updated_at','updated_by','id_stato','id_cliente','completamento'],
        show: false,
        type: '', //insert|update
        title: '',
        data: {}
      },
      milestoneModal: {
        show: false,
        editable: true,
        tableColumns:[],
        tableData:[],
        id_reference: -1,
        total: 0
      },
      preventCloseModal: {
        show: false
      },
      customerSelectOptions: [],
      statusSelectOptions: [],
      projectSelectOptions: [],
      paymentMethodSelectOptions: []
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
      let filteredOffers = []
      if( hasFilterHead ) {
        filteredOffers = this.$store.state.projects.records
        .filter( el => Object.entries(headFilters).every( f => {
          console.log(el[f[0]], f[1], el[f[0]] == f[1])
          return f[1] ? el[f[0]] == f[1] : true
        } ))
      }
      this.tableData = hasFilterHead ? filteredOffers : this.$store.state.projects.records
    },

    async fetchData( ) {
      await Promise.all([
        this.$store.dispatch(__.GETALL,this.model),
        this.$store.dispatch(__.GETALL,'cliente'),
        this.$store.dispatch(__.GETWHERE,{model: 'stato', cond: [{field: 'entita', op: '=', value: 'progetto'}]}),
        this.$store.dispatch(__.GETALL,'contratto'),
        this.$store.dispatch(__.GETALL,'milestone'),
        this.$store.dispatch(__.DESCTABLE, 'progetto'),
        this.$store.dispatch(__.DESCTABLE, 'milestone'),
        this.$store.dispatch(__.GETALL, 'metodo_pagamento')
      ])

      this.customerSelectOptions = this.$store.getters.customerSelectOptions
      this.projectSelectOptions = this.$store.getters.projectSelectOptions
      this.statusSelectOptions  = this.$store.getters.statusSelectOptions
      this.paymentMethodSelectOptions = this.$store.getters.paymentMethodSelectOptions

      this.modal.fields = this.$store.state.tableDescProgetto.fields
      .filter( f => !this.modal.hiddenColumns.includes(f))
      .map( f => {
        switch(f){
          case 'cliente':
            return {
              type: 'select',
              prop: 'id_cliente', 
              label: f.replace('_',' '),
              options: this.customerSelectOptions
            }
          case 'stato':
            return {
              type: 'select',
              prop: 'id_stato', 
              label: f.replace('_',' '),
              options: this.statusSelectOptions
            }
          case 'data_inizio':
          case 'data_fine':
            return {
              type: 'date',
              prop: f, 
              label: f.replace('_',' ')
            }
          case 'completamento':
            return {
              type: 'slider',
              prop: f, 
              label: f.replace('_',' '),
            }
          case 'commenti':
            return {
              type: 'textarea',
              prop: f,
              label: f.replace('_',' ')
            }
          default: 
            return {
              type: 'input',
              prop: f, 
              label: f.replace('_',' '),
            }
        }
      })

      this.tableColumns = this.$store.state.tableDescProgetto.fields
      .filter( f => !this.hiddenColumns.includes(f))
      .map( f => {
        switch(f){
          case 'data_inizio':
          case 'data_fine':
            return {
              formatter: (row, column) => row[column.property] ? moment(row[column.property]).format('DD-MM-YYYY') : '',
              prop: f, 
              sortable: true,
              label: f.replace('_',' ')
            }
          case 'id':
            return {
              formatter: (row, column) => row[column.property],
              prop: f, 
              sortable: true,
              label: f.replace('_',' '),
              minWidth: 50
            }
          default: 
            return {
              formatter: (row, column) => row[column.property],
              prop: f, 
              sortable: true,
              label: f.replace('_',' '),
            }
          }
        })
      
      this.tableData = lodash.has(this.$store.state, 'projects.records') ? this.$store.state.projects.records : []
    },
    
    async handleCloseModal(){
      this.preventCloseModal.show = true
      this.modal.show = true
    },
    
    openCreateModal(){
      this.modal.type = 'insert'
      this.modal.data = {}
      this.modal.show = true
      this.modal.title = 'Crea nuovo progetto'
    },

    openUpdateModal(index, row){
      console.log('openUpdateModal', row)
      this.modal.type = 'update'
      this.modal.data = Object.entries(row).reduce( (a,c) => {
        switch(c[0]){
          case "data_inizio":
          case "data_fine":
            a[c[0]] =  moment(c[1]||undefined).format('YYYY-MM-DD')
            break
          case "cliente":
            a[c[0]] = (this.customerSelectOptions.filter( r => r.text == c[1]).pop()).value
            break;
          case "stato":
          a[c[0]] = (this.statusSelectOptions.filter( r => r.text == c[1]).pop()).value
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

    async openMilestoneModal( row ) {
      const contratto = this.$store.state.contracts.records.filter( c => c.id_progetto == row.id).pop()

      const payload = {
        model: 'milestone', 
        cond: [{field:"id_contratto", op:"=", value:contratto.id}]
      } 
      await this.$store.dispatch(__.GETWHERE, payload)
      if (lodash.isEmpty(this.$store.state.milestone)) {
        this.$notify({type:'danger', message:'Nessuna milestone truvata'})
        return false
      }

      await this.$store.dispatch(__.GETWHERE,{model: 'stato', cond: [{field: 'entita', op: '=', value: 'milestone'}]})

      this.milestoneModal.tableColumns = this.$store.state.tableDescMilestone.fields
      .filter( f => !['id','trec','created_at','created_by','updated_at','updated_by','id_contratto','id_stato','id_payment_method','data_fatturazione','impianto'].includes(f))
      .map( f => {
        switch(f){
          case 'id':
            return {
              formatter: (row, column) => row[column.property],
              prop: f, 
              label: f.replace('_',' '),
              type: 'input',
              minWidth: 50,
              disabled:true
            }
          case 'descrizione':
            return {
              formatter: (row, column) => row[column.property],
              prop: f, 
              label: f.replace('_',' '),
              type: 'input',
              disabled: true
            }
          case 'Note':
            return {
              formatter: (row, column) => row[column.property],
              prop: f, 
              label: f.replace('_',' '),
              type: 'textarea'
            }
          case 'stato': 
            return {
              formatter: (row, column) => row[column.property],
              prop: 'id_stato', 
              label: f.replace('_',' '),
              type: 'select',
              options: this.$store.getters.statusSelectOptions
            }
          case 'tipo_pagamento': 
            return {
              formatter: (row, column) => row[column.property],
              prop: 'id_payment_method', 
              label: f.replace('_',' '),
              type: 'select',
              options: this.paymentMethodSelectOptions
            }
          case 'importo_percentuale': 
            return {
              formatter: (row, column) => row[column.property],
              prop: f, 
              label: f.replace('_',' '),
              type: 'number'
            }
          case 'importo_valore': 
            return {
              formatter: (row, column) => row[column.property],
              prop: f, 
              label: f.replace('_',' '),
              type: 'number',
              disabled:true
            }
          default: 
            return {
              formatter: (row, column) => row[column.property],
              prop: f, 
              label: f.replace('_',' '),
              type: 'input',
              editable: true
            }
        }
      })
      
      this.milestoneModal.tableData = this.$store.state.milestone.records
      this.milestoneModal.id_reference = contratto.id
      this.milestoneModal.total = parseFloat(contratto.importo_contrattato)
      this.milestoneModal.show = true
    },

    async handleSaveMilestone ( id ) {
      const payload = {
        model: 'milestone', 
        cond: [{field:"id_contratto", op:"=", value:id}]
      }
      await this.$store.dispatch(__.GETWHERE, payload)
      this.milestoneModal.tableData = this.$store.state.milestone.records
      this.milestoneModal.show = false
      this.$notify({type:'success', message: `Milestones salvate correttamente`})
      await this.fetchData()
    },

    async handleSave () {
      const method = this.modal.type == 'insert' ? __.INSERT : __.UPDATE
      const {id, trec, created_at, created_by, updated_at, updated_by, cliente, stato, ...payload } = this.modal.data
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
  .cell.custom-header-class {
    word-break: break-word;
  }
</style>
