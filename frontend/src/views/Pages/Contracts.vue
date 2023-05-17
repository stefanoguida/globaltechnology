<template>
  <div class="content">
    <dashboard-header>
      <template slot="footer">
        <div class="row align-items-center py-4">
          <div class="col-lg-12 col-5 text-right">
            <!-- <base-button size="xl" type="neutral" @click="openCreateModal">Nuovo</base-button> -->
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
            </div>
            <div class="text-right">
              <base-button type="primary" class="my-4" @click="modal.show = false">Annulla</base-button>
              <base-button type="primary" class="my-4" @click="handleSave">Salva</base-button>
            </div>
          </form>
        </template>
      </card>
    </modal>

    <!-- PDF Modal -->
    <modal :show.sync="pdfmodal.show" size="lg" body-classes="p-0">
      <card type="secondary" header-classes="bg-transparent pb-5" body-classes="px-lg-5 py-lg-5" class="border-0 mb-0">
        <template>
          <div class="text-muted mb-4">
            <small>{{pdfmodal.title}}</small>
          </div>
          <el-row>
            <el-col v-for="file in pdfmodal.data" :span="8">
              <el-card>
                <template slot="header">
                  <pdf :src="file.path" :page=1></pdf>
                </template>
                <div>
                  {{ file.path.split('/').slice(-1).pop() }}
                  <div class="row">
                    <div class="col-12 text-right">
                      <base-button type="primary" size="sm" icon>
                        <a :href="file.path" target="_blank"><i class="text-white fa fa-eye"></i></a>
                      </base-button>
                      <base-button type="danger" @click="handleDeleteFile(file)" size="sm" icon>
                        <i class="text-white fa fa-trash"></i>
                      </base-button>
                    </div>
                  </div>
                </div>
              </el-card>
            </el-col>
          </el-row>
          <div class="d-flex" style="margin-top: 10px;">
              <file-input initialLabel="carica file" @change="handleFileChange" class="custom-control-inline"></file-input>
              <base-button type="primary" @click.native="handleSaveFile" :disabled="!pdfmodal.newFile.name">
                <i class="fa fa-upload"></i>
              </base-button>
            </div>
        </template>
      </card>
    </modal>

    <milestone-modal 
      :show.sync="milestoneModal.show" 
      :editable="milestoneModal.editable"
      :id_contratto="milestoneModal.id_reference"
      :total="milestoneModal.total"
      @after-save="handleSaveMilestone">
    </milestone-modal>

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

            <el-table 
              :data="queriedData" 
              row-key="id" 
              header-row-class-name="thead-light"
              show-summary
              :summary-method="getSummaries"
            >
              
              <el-table-column type="expand" >
                <template #default="scope">
                  <div class="row" >
                    <div class="cell" v-for="m in allMilestones.filter( m => m.id_contratto == scope.row.id)">
                      <el-tag v-if="m.id_stato == 10" type="danger">
                        {{ m.descrizione }} <br />
                        {{ (new Intl.NumberFormat('it-IT',{style: 'currency', currency: 'EUR'}).format(m.ritenuta_valore)) }}
                      </el-tag>
                      <el-tag v-else-if="m.id_stato == 11" type="warning">
                        {{ m.descrizione }} <br />
                        {{ (new Intl.NumberFormat('it-IT',{style: 'currency', currency: 'EUR'}).format(m.ritenuta_valore)) }}
                      </el-tag>
                      <el-tag v-else-if="m.id_stato == 12" type="success">
                        {{ m.descrizione }} <br />
                        {{ (new Intl.NumberFormat('it-IT',{style: 'currency', currency: 'EUR'}).format(m.ritenuta_valore)) }}
                      </el-tag>
                      <el-tag v-else type="primary">
                        {{ m.descrizione }} <br />
                        {{ (new Intl.NumberFormat('it-IT',{style: 'currency', currency: 'EUR'}).format(m.ritenuta_valore)) }}
                      </el-tag>
                    </div>
                  </div>
                  <div class="row">&nbsp;</div>
                  <div class="row">
                    <div class="cell" v-for="m in Object.entries(allMilestones.filter( m => m.id_contratto == scope.row.id).reduce( (acc,curr) => {
                      acc[curr.id_stato] = acc.hasOwnProperty(curr.id_stato) ? parseFloat(acc[curr.id_stato]) + parseFloat(curr.ritenuta_valore) : parseFloat(curr.ritenuta_valore)
                      return acc
                    }, {})).sort( (a,b) => b[0] - a[0])">
                      <el-tag v-if="m[0] == 10" type="danger"> {{ (new Intl.NumberFormat('it-IT',{style: 'currency', currency: 'EUR'}).format(m[1])) }} </el-tag>
                      <el-tag v-else-if="m[0] == 11" type="warning"> {{ (new Intl.NumberFormat('it-IT',{style: 'currency', currency: 'EUR'}).format(m[1])) }} </el-tag>
                      <el-tag v-else-if="m[0] == 12" type="success"> {{ (new Intl.NumberFormat('it-IT',{style: 'currency', currency: 'EUR'}).format(m[1])) }} </el-tag>
                      <el-tag v-else type="primary"> {{ (new Intl.NumberFormat('it-IT',{style: 'currency', currency: 'EUR'}).format(m[1])) }} </el-tag>
                    </div>
                  </div>
                </template>
              </el-table-column>

              <!-- All columns -->
              <el-table-column 
              v-for="column in tableColumns" 
              :key="column.label" 
              v-bind="column" 
              :formatter="column.formatter" 
              label-class-name="custom-header-class"
              :min-width="column.minWidth"
              >
                <template #default="scope" v-if="column.prop == 'milestone'">
                  <el-tag v-if="scope.row.milestone" disable-transitions :type="scope.row.tagClass" >{{ scope.row.milestone }}</el-tag>
                </template>
              </el-table-column>
              <!-- Action Column -->
              <el-table-column align="right" label="Actions" min-width="100">
                <template #default="{$index, row}" class="d-flex">
                  <base-button @click.native="handleShowPDF($index, row)"  class="edit" :type="row.has_pdf > 0 ? 'success' : 'primary'" size="sm" icon>PDF</base-button>
                  <base-button @click.native="openMilestoneModal(row)" class="edit" type="warning" size="sm" icon >
                    <i class="ni ni-atom"></i>
                  </base-button>
                </template>
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
import { Table, TableColumn, Select, Option, Form, FormItem, DatePicker, Row, Col, Card, Tag } from 'element-ui';
import FileInput from '@/components/Inputs/FileInput'
import 'element-ui/lib/theme-chalk/index.css';
import RouteBreadCrumb from '@/components/Breadcrumb/RouteBreadcrumb'
import { BasePagination } from '@/components';
import searchTableMixin from '../Tables/PaginatedTables/searchTableMixin'
import swal from 'sweetalert2';
import { Modal } from '@/components';
import pdf from 'vue-pdf'
import moment from 'moment'
moment.updateLocale(moment.locale(), { invalidDate: undefined })

import DashboardHeader from '../Dashboard/DashboardHeader.vue';

import PdfModal from '../Components/PdfModal.vue';
import MilestoneModal from '../Components/MilestoneModal.vue';

import * as __ from '../../store/constants'
import lodash from 'lodash'

export default {
  mixins: [searchTableMixin],
  components: {
    PdfModal,
    pdf,
    FileInput,
    MilestoneModal,
    DashboardHeader,
    Modal,
    BasePagination,
    RouteBreadCrumb,
    [Row.name]: Row,
    [Col.name]: Col,
    [Card.name]: Card,
    [Form.name]: Form,
    [Tag.name]: Tag,
    [FormItem.name]: FormItem,
    [DatePicker.name]: DatePicker,
    [Select.name]: Select,
    [Option.name]: Option,
    [Table.name]: Table,
    [TableColumn.name]: TableColumn
  },
  data() {
    return {
      model: 'contratto',
      title: 'Contratti',
      searchColumns: ['progetto'],
      hiddenColumns: ['trec','created_at','created_by','updated_at','updated_by','id_progetto','id_cliente'],
      tableColumns: [],
      originalTableData: [],
      tableData: [],
      baseTableData: [],
      selectedRow: {},
      selectedRows: [],
      pagination:{
        perPage:25
      },
      filters: {
        id_cliente: '',
        id_progetto: ''
      },
      modal: {
        fields:[],
        hiddenColumns: ['id','trec','created_at','created_by','updated_at','updated_by', 'id_progetto','cliente','id_cliente'],
        show: false,
        type: '', //insert|update
        title: '',
        data: {}
      },
      pdfmodal: {
        data: [],
        title: 'Gestisci file',
        show: false,
        id_reference: -1,
        newFile: {}
      },
      milestoneModal: {
        editable: true,
        show: false,
        tableColumns:[],
        tableData:[],
        id_reference: -1,
        total: 0
      },
      projectSelectOptions: [],
      statusOfferSelectOptions: [],
      customerSelectOptions: [],
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
        filteredOffers = this.baseTableData
        .filter( el => Object.entries(headFilters).every( f => {
          return f[1] ? el[f[0]] == f[1] : true
        } ))
      }
      this.tableData = hasFilterHead ? filteredOffers : this.baseTableData
    },
    getSummaries ( param ) {
      const { columns, data } = param
      let sums = []
      
      columns.forEach( (column, index) => {
        if (index === 0 || column.property === 'id') {
          sums[index] = ''
          return
        }
        
        const values = data.map( item => Number(item[column.property]) )

        if ( !values.every( value => Number.isNaN(value)) ) {
          const sum = values.reduce((prev, curr) => {
            const value = Number(curr)
            return !Number.isNaN(value) ? (prev + curr) : prev
          }, 0)
          sums[index] = column.property != 'kw' ? new Intl.NumberFormat('it-IT',{style:'currency', currency:'EUR'}).format(sum) : sum
        } else {
          sums[index] = ''
        }
      })

      return sums
    },

    async fetchData( ) {
      await Promise.all([
        this.$store.dispatch(__.GETALL,this.model),
        this.$store.dispatch(__.GETALL,'progetto'),
        this.$store.dispatch(__.GETALL,'cliente'),
        this.$store.dispatch(__.GETALL,'milestone'),
        this.$store.dispatch(__.GETWHERE,{model: 'stato', cond: [{field: 'entita', op: '=', value: 'milestone'}]}),
        this.$store.dispatch(__.DESCTABLE, 'contratto'),
        this.$store.dispatch(__.DESCTABLE, 'milestone'),
        this.$store.dispatch(__.GETALL, 'metodo_pagamento'),
      ])

      this.projectSelectOptions = this.$store.getters.projectSelectOptions
      this.statusOfferSelectOptions = this.$store.getters.statusSelectOptions
      this.customerSelectOptions = this.$store.getters.customerSelectOptions
      this.paymentMethodSelectOptions = this.$store.getters.paymentMethodSelectOptions
      
      this.allMilestones = this.$store.state.milestone.records

      this.modal.fields = this.$store.state.tableDescContratto.fields
      .filter( f => !this.modal.hiddenColumns.includes(f))
      .map( f => {
        switch(f){
          case 'data_accettazione':
            return {
              type: 'date',
              prop: f, 
              label: f.replace('_',' ')
            }
          case 'progetto':
            return {
              type: 'select',
              prop: 'id_progetto', 
              label: f.replace('_',' '),
              options: this.projectSelectOptions
            }
          default: 
            return {
              type: 'input',
              prop: f, 
              label: f.replace('_',' '),
            }
        }
      })

      this.tableColumns = [...this.$store.state.tableDescContratto.fields,'milestone','prezzo_al_kw']
      .filter( f => !this.hiddenColumns.includes(f))
      .map( f => {
        switch(f){
          case 'id':
            return {
              formatter: (row, column) => row[column.property],
              prop: f, 
              sortable: true,
              label: f.replace('_',' '),
              minWidth: 50
            }
          case 'data_accettazione':
            return {
              formatter: (row, column) => moment(row[column.property]).format('DD-MM-YYYY'),
              prop: f, 
              sortable: true,
              label: f.replace('_',' ')
            }
          case 'importo_contrattato':
            return {
              formatter: (row, column) => new Intl.NumberFormat('it-IT',{ style: 'currency', currency: 'EUR' }).format(row[column.property]),
              prop: f, 
              sortable: true,
              label: f.replace('_',' ')
            }
          case 'prezzo_al_kw':
            return {
              formatter: (row, column) => new Intl.NumberFormat('it-IT',{ style: 'currency', currency: 'EUR' }).format(row[column.property]),
              prop: f, 
              sortable: true,
              label: f.replace('_',' ')
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
      
      this.tableData = this.baseTableData = this.$store.state.contracts.records.map( c => {
        const milestone = this.$store.state.milestone.records.filter( m => m.id_contratto == c.id)
        
        const daFatturare = milestone.filter( m => m.id_stato == 10) || []
        const fatturato = milestone.filter( m => m.id_stato == 11) || [] 
        const pagato = milestone.filter( m => m.id_stato == 12) || []

        let tagClass = ''
        let milestoneToShow = ''

        if ( daFatturare.length ) {
          tagClass = 'danger'
          milestoneToShow = (daFatturare[0]).descrizione
        }
        else if (fatturato.length ) {
          tagClass = 'warning'
          milestoneToShow = (fatturato.slice(-1).pop()).descrizione
        }
        else if (pagato.length) {
          tagClass = 'success'
          milestoneToShow = (pagato.slice(-1).pop()).descrizione
        }
        
        return {
          ...c, 
          prezzo_al_kw: parseFloat(c.importo_contrattato) / parseFloat(c.kw),
          milestone: milestoneToShow, 
          tagClass: tagClass
        }
      })

      this.handleSearch()
    },

    async openMilestoneModal( row ) {

      this.milestoneModal.id_reference = row.id
      this.milestoneModal.total = parseFloat(row.importo_contrattato)
      this.milestoneModal.show = true
    },

    openCreateModal(){
      this.modal.type = 'insert'
      this.modal.data = {}
      this.modal.show = true
      this.modal.title = 'Crea nuovo contratto'
    },

    openUpdateModal(index, row){
      this.modal.type = 'update'
      this.modal.data = Object.entries(row).reduce( (a,c) => {
        switch(c[0]){
          case "data_accettazione":
            a[c[0]] =  moment(c[1]).format('DD-MM-YYYY')
            break
          case "progetto":
            a[c[0]] = (this.projectSelectOptions.filter( r => r.text == c[1]).pop()).value
            break;
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
      const {id, trec, created_at, created_by, updated_at, updated_by, progetto, ...payload } = this.modal.data
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
        this.$notify({type:'success', message: `Contratto salvato correttamente`})
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

    async handleShowPDF( index, row ) {
      this.selectedRow = row
      const payload = {
        model: 'file', 
        cond: [
          { field:"id_riferimento", op:"=", value:row.id },
          { field:"tipo", op:"=", value:"contratto" }
        ]
      }
      await this.$store.dispatch(__.GETWHERE, payload)
      this.pdfmodal.data = this.$store.state.file.records
      this.pdfmodal.show = true
    },

    async handleSaveFile () {

      const data = {
        type:'contratto', 
        id_riferimento: this.selectedRow.id, 
        file: this.pdfmodal.newFile 
      }
      const res = await this.$store.dispatch(__.UPLOAD, data)
      if (res.error) {
        swal.fire({
          title: `Attenzione`,
          text: 'Upload fallito',
          buttonsStyling: false,
          customClass: {
            confirmButton: 'btn btn-warning'
          },
          icon: 'warning'
        })
      }
      else {
        this.modal.show = false
        swal.fire({
          title: `File caricato`,
          text: 'Il file è stato caricato correttamente!',
          buttonsStyling: false,
          customClass: {
            confirmButton: 'btn btn-success'
          },
          icon: 'success'
        })
        const payload = {
          model: 'file', 
          cond: [
            {field:"id_riferimento", op:"=", value:this.selectedRow.id},
            {field:"tipo", op:"=", value:"offerta"}
          ]
        }
        await this.$store.dispatch(__.GETWHERE, payload)
        this.pdfmodal.data = this.$store.state.file.records
      }
    },

    handleFileChange(files){
      this.pdfmodal.newFile = files[0]
    },

    handleDeleteFile( file ){
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
      .then( async result => {
        if (result.value) {
          const res = await this.$store.dispatch(__.DELETEFILE, file.id)
          if (!res.error){
            swal.fire({
              title: 'Cancellato!',
              text: `File cancellato`,
              type: 'success',
              confirmButtonClass: 'btn btn-success btn-fill',
              buttonsStyling: false
            });
          }
          const idx = this.pdfmodal.data.findIndex( f => f.id == file.id )
          this.pdfmodal.data.splice(idx,1)
        }
      })
      .catch( (error) => {
        swal.fire({
            title: 'Errore!',
            text: `Impossibile cancellare il record`,
            icon: 'error'
          });
      })
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
  .el-table__expand-icon{
    position: absolute;
    left: 23px;
    top: 20px;
  }
</style>
