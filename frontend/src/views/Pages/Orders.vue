<template>
  <div class="content">
    <dashboard-header>
      <template slot="footer">
        <div class="row align-items-center py-4">
          <div class="col-lg-12 col-5 text-right">
            <base-button size="xl" type="primary" @click="handleShowPDF" :disabled="!Object.keys(selectedRow).length">Mostra PDF ordine {{ selectedRow.id_ordine }}</base-button>
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

            <div v-for="field in modal.fields" v-if="modal.type != 'upload'">
              <base-input v-if="field.type == 'input'" :label="field.label" v-model="modal.data[field.prop]" alternative class="mb-3" :placeholder="field.label" ></base-input>
              <base-input v-else-if="field.type == 'select'" :label="field.label" alternative class="mb-3" :placeholder="field.label" >
                <select class="form-control" v-model="modal.data[field.prop]">
                  <option v-for="option in field.options" :value="option.value">{{ option.text }}</option>
                </select>
              </base-input>
              <base-input v-else-if="field.type == 'currency'" :label="field.label" v-model="modal.data[field.prop]" alternative class="mb-3" :placeholder="field.label">
                <template #append>€</template>
              </base-input>
              <base-input v-else-if="field.type == 'date'" type="date" :label="field.label" v-model="modal.data[field.prop]" alternative class="mb-3" :placeholder="field.label" :formatter=" val => moment(val).format('DD-MM-YYYY') "></base-input>
              <base-input v-else-if="field.type == 'textarea'" :label="field.label" alternative class="mb-3" :placeholder="field.label">
                <textarea v-model="modal.data[field.prop]" class="form-control" rows="3"></textarea>
              </base-input>
              <base-input v-else-if="field.type == 'slider'" :label="field.label" alternative class="mb-3" >
                <base-slider v-model="modal.data[field.prop]" :options="slider.options"></base-slider>
              </base-input>
            </div>
            
            <div v-if="modal.type == 'upload'">
              <label> File </label>
              <file-input initialLabel="carica file" @change="handleFileChange"></file-input>
            </div>

            <div class="text-right">
              <base-button type="primary" class="my-4" @click="modal.show = false">Annulla</base-button>
              <base-button type="primary" class="my-4" @click=" () => modal.type == 'upload' ? handleSaveFile() : handleSave() ">Salva</base-button>
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
                  <div class="d-flex">
                    <base-button type="primary" size="sm" icon>
                      <a :href="file.path" target="_blank"><i class="text-white fa fa-eye"></i></a>
                    </base-button>
                    <base-button type="danger" @click="handleDeleteFile(file)" size="sm" icon>
                      <i class="text-white fa fa-trash"></i>
                    </base-button>
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

    <div class="row">
      
      <!-- Data Table -->
      <div :class="tableDataCSSClass">
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
                      <el-input placeholder="Ordine" v-model="filters.id_ordine"></el-input>
                    </el-form-item>

                    <el-form-item>
                      <el-select placeholder="Cliente" v-model="filters.cliente" filterable>
                        <el-option value=""></el-option>
                        <el-option v-for="customer in customerSelectOptions" :key="customer.value" :label="customer.text" :value="customer.text"></el-option>
                      </el-select>
                    </el-form-item>
  
                    <el-form-item>
                      <el-select placeholder="Progetto" v-model="filters.id_progettot" filterable>
                        <el-option value=""></el-option>
                        <el-option v-for="project in projectSelectOptions" :key="project.value" :label="project.text" :value="project.value"></el-option>
                      </el-select>
                    </el-form-item>
  
                    <el-form-item>
                      <el-select placeholder="Stato" v-model="filters.id_stato" filterable>
                        <el-option value=""></el-option>
                        <el-option v-for="status in statusOrderSelectOptions" :key="status.value" :label="status.text" :value="status.value"></el-option>
                      </el-select>
                    </el-form-item>
                    
                    <el-form-item>
                      <el-select placeholder="Servizio" v-model="filters.id_servizio" filterable>
                        <el-option value=""></el-option>
                        <el-option v-for="service in servicesOrderSelectOptions" :key="service.value" :label="service.text" :value="service.value"></el-option>
                      </el-select>
                    </el-form-item>

                    <el-form-item>
                      <base-button type="primary" @click="handleSearch">Cerca</base-button>
                    </el-form-item>

                  </el-form >
                </div>

              </div>

              <el-table :data="queriedData" row-key="id" header-row-class-name="thead-light" highlight-current-row @sort-change="sortChange" @current-change="handleRowSelect">
                <!-- All columns -->
                <el-table-column v-for="column in tableColumns" :key="column.label" v-bind="column" :formatter="column.formatter" label-class-name="custom-header-class" width="180"></el-table-column>

                <!-- Action Column -->
                <el-table-column align="right" label="Actions" min-width="200">
                  <div slot-scope="{$index, row}" class="d-flex">
                    <!-- <base-button @click.native="handleShowPDF(row)" type="primary" size="sm" icon >
                      <i class="text-white fa fa-file-pdf"></i>
                    </base-button> -->
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
                </p>
              </div>
              <base-pagination class="pagination-no-border" v-model="pagination.currentPage" :per-page="pagination.perPage" :total="total"></base-pagination>
            </div>

          </card>
        </div>
      </div>

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
    pdf,
    Modal,
    BasePagination,
    RouteBreadCrumb,
    FileInput,
    [Row.name]: Row,
    [Col.name]: Col,
    [Card.name]: Card,
    [Select.name]: Select,
    [Option.name]: Option,
    [Form.name]: Form,
    [FormItem.name]: FormItem,
    [DatePicker.name]: DatePicker,
    [Table.name]: Table,
    [TableColumn.name]: TableColumn
  },
  data() {
    return {
      model: 'riga_ordine',
      title: 'Ordini',
      searchColumns: ['progetto'],
      hiddenColumns: ['trec','created_at','created_by','updated_at','updated_by','id_progetto','id_stato','id_servizio','id_ordine'],
      tableColumns: [],
      tableData: [],
      tableDataCSSClassBase: 'container-fluid mt--6 col-12',
      tableDataCSSClass: 'container-fluid mt--6 col-12',
      filters: {
        cliente: '',
        id_progetto: '',
        id_stato: '',
        id_servizio: '',
        id_ordine: ''
      },
      fileData: [],
      detailsData:[],
      showDetails: false,
      showFiles: false,
      selectedRow: {},
      pagination:{
        perPage:25
      },
      modal: {
        fields:[],
        hiddenColumns: ['id','trec','created_at','created_by','updated_at','updated_by','id_ordine','id_progetto','id_stato','id_servizio','cliente'],
        show: false,
        type: '', //insert|update
        title: '',
        data: {}
      },
      pdfmodal: {
        show: false,
        title: 'Gestisci file',
        data: [],
        newFile: {}
      },
      projectSelectOptions:[],
      statusOrderSelectOptions:[],
      servicesOrderSelectOptions:[],
      customerSelectOptions:[],
    };
  },
  computed: {
    choosenFileName(){
      return this.modal.data.file.name || 'Carica file' 
    },
    reactiveFileData(){
      return this.fileData || []
    }
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
      this.tableData = this.$store.state.orderRows.records
      .filter( el => Object.entries(this.filters).every( f => f[1] ? el[f[0]] == f[1] : true))
    },
    async fetchData( ) {
      
      await this.$store.dispatch(__.GETALL,this.model)
      await this.$store.dispatch(__.GETALL,'progetto')
      await this.$store.dispatch(__.GETALL,'cliente')
      await this.$store.dispatch(__.GETALL,'servizio')
      await this.$store.dispatch(__.GETWHERE,{model: 'stato', cond: [{field: 'entita', op: '=', value: 'ordine'}]})

      this.projectSelectOptions = this.$store.getters.projectSelectOptions
      this.statusOrderSelectOptions = this.$store.getters.statusSelectOptions
      this.servicesOrderSelectOptions = this.$store.getters.servicesSelectOptions
      this.customerSelectOptions = this.$store.getters.customerSelectOptions

      this.modal.fields = this.$store.state.orderRows.fields
      .filter( f => !this.modal.hiddenColumns.includes(f))
      .map( f => {
        switch(f){
          case 'data_arrivo_merce':
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
          case 'stato':
            return {
              type: 'select',
              prop: 'id_stato', 
              label: f.replace('_',' '),
              options: this.statusOrderSelectOptions
            }
          case 'servizio':
            return {
              type: 'select',
              prop: 'id_servizio', 
              label: f.replace('_',' '),
              options: this.servicesOrderSelectOptions
            }
          case 'importo':
            return {
              type: 'currency',
              prop: f, 
              label: f.replace('_',' ')
            }
          case 'costo':
            return {
              type: 'currency',
              prop: f, 
              label: f.replace('_',' ')
            }
          case 'costo_spedizione':
            return {
              type: 'currency',
              prop: f, 
              label: f.replace('_',' ')
            }
          case 'descrizione':
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

      this.tableColumns = this.$store.state.orderRows.fields
      .filter( f => !this.hiddenColumns.includes(f))
      .map( f => {
        switch(f){
          case 'importo':
            return {
              formatter: (row, column) => new Intl.NumberFormat('it-IT',{style: 'currency', currency: 'EUR'}).format(row[column.property]),
              prop: f, 
              sortable: true,
              label: f.replace('_',' ')
            }
          case 'data_arrivo_merce':
            return {
              formatter: (row, column) => row[column.property] ? moment(row[column.property]).format('YYYY-MM-DD') : '',
              prop: f, 
              label: f.replace('_',' ')
            }
          default: 
            return {
              formatter: (row, column) => row[column.property],
              prop: f, 
              sortable: true,
              label: f.replace('_', ' ').replace(/^\w/, c => c.toUpperCase()),
            }
          }
        })
      
      this.tableData = this.$store.state.orderRows.records
      this.selectedRow = this.$store.state.orderRows.records[0] 
    },
    handleRowSelect( row ){
      this.selectedRow = row
    },
    async handleShowPDF(  ) {
      const row = this.selectedRow
      await this.$store.dispatch(__.GETWHERE, {model: 'file', cond: [{field:"id_progetto", op:"=", value:row.id_progetto},{field:"tipo", op:"=", value:"ordine"}]})
      this.pdfmodal.data = this.$store.state.file.records
      this.pdfmodal.show = true
    },
    handleShowDetails ( row ) {
      this.$router.push('orderrows')
    },
    openCreateModal(){
      this.modal.type = 'insert'
      this.modal.data = {}
      this.modal.show = true
      this.modal.title = 'Crea nuovo ordine'
    },
    openUpdateModal(index, row){
      this.modal.type = 'update'
      this.modal.data = Object.entries(row).reduce( (a,c) => {
        switch(c[0]){
          case "progetto":
            a[c[0]] = (this.projectSelectOptions.filter( r => r.text == c[1]).pop()).value
            break;
            case "stato":
              a[c[0]] = (this.statusOrderSelectOptions.filter( r => r.text == c[1]).pop()).value
            break;
            case "servizio":
              a[c[0]] = (this.servicesOrderSelectOptions.filter( r => r.text == c[1]).pop()).value
            break;
          default:
            a[c[0]] = c[1]
            break;
        }
        return a
      },{})
      this.modal.condition = [{field: 'id', op: '=', value: row.id}]
      this.modal.show = true
      this.modal.title = 'Modifica ordine'
    },
    async handleSave () {
      const method = this.modal.type == 'insert' ? __.INSERT : __.UPDATE
      let {id, trec, created_at, created_by, updated_at, updated_by, cliente, servizio, progetto, stato,  ...filteredData } = this.modal.data
      let {id_progetto, id_stato, importo, ...detailsData} = filteredData
      let head = {
        model: 'ordine', 
        payload: {id_progetto, id_stato, importo}, 
        cond: method === __.UPDATE ? [{field:"id", op:"=", value:filteredData.id_ordine}] : []
      }
      let response = await this.$store.dispatch(method, head)

      if ( response.error ) {
        this.$notify({type:'danger', message:response.message})
        this.modal = { ...this.modal, type: '', title: '', data: {} }
      }
      else {
        let details = {
          model: this.model, 
          payload: method === __.INSERT ? {...detailsData, id_ordine: response.data.insertId} : detailsData, 
          cond: this.modal.condition || []
        }
        console.log(details, response)
        response = await this.$store.dispatch(method, details)
        
        if ( response.error ) {
          this.$notify({type:'danger', message:response.message})
          this.modal = { ...this.modal, type: '', title: '', data: {} }
        }
        else {
          this.$notify({type:'success', message: `Contratto salvato correttamente`})
          await this.fetchData()
          this.modal.show = false
        }
      }
      
    },
    async handleSaveFile () {

      const data = {
        type:'ordine', 
        id: this.selectedRow.id_progetto, 
        id_riferimento: this.selectedRow.id_ordine, 
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

        await this.$store.dispatch(__.GETWHERE, {model: 'file', cond: [{field:"id_progetto", op:"=", value:this.selectedRow.id_progetto},{field:"tipo", op:"=", value:"ordine"}]})
        this.pdfmodal.data = this.$store.state.file.records
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
    async refreschFileData () {
      await this.fetchData()
      const idx = this.tableData.findIndex( t => t.id == this.selectedRow.id)
      this.fileData = this.tableData[idx].files
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
    handleFileChange(files){
      this.pdfmodal.newFile = files[0]
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
