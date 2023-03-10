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
              <base-input v-else-if="field.type == 'date'" type="date" :label="field.label" v-model="modal.data[field.prop]" alternative class="mb-3" :placeholder="field.label" ></base-input>
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
              <base-button type="primary" class="my-4" @click=" () => modal.type == 'upload' ? handleSaveFile() : handleSaveCustomer() ">Salva</base-button>
            </div>
          </form>
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
                  <base-input v-model="searchQuery" prepend-icon="fas fa-search" placeholder="Search..."> </base-input>
                </div>
              </div>

              <el-table :data="queriedData" row-key="id" header-row-class-name="thead-light" highlight-current-row @sort-change="sortChange" @current-change="handleRowSelect">
                <!-- All columns -->
                <el-table-column v-for="column in tableColumns" :key="column.label" v-bind="column" :formatter="column.formatter"></el-table-column>
                
                <!-- Icon Files Column -->
                <el-table-column align="right" label="File" width="80px">
                  <div slot-scope="{$index, row}" class="d-flex" v-if="row.files">
                    <base-button 
                      class="btn-tooltip"
                      type="danger" 
                      size="sm" 
                      icon 
                      @click.native="handleShowFiles(row)"
                    >
                      <i class="text-white fa fa-file-pdf"></i>
                    </base-button>
                  </div>
                </el-table-column>

                <!-- Action Column -->
                <el-table-column align="right" label="Actions" min-width="100px">
                  <div slot-scope="{$index, row}" class="d-flex">
                    <base-button @click.native="handleShowDetails(row)" type="primary" size="sm" icon >
                      <i class="text-white fa fa-info"></i>
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
                  <!-- <span v-if="selectedRows.length">
                    &nbsp; &nbsp; {{selectedRows.length}} righe selezionate
                  </span> -->
                </p>
              </div>
              <base-pagination class="pagination-no-border" v-model="pagination.currentPage" :per-page="pagination.perPage" :total="total"></base-pagination>
            </div>

          </card>
        </div>
      </div>

      <!-- Files table -->  
      <div class="container-fluid mt--6 col-4" v-if="showFiles">
        <div>
          <card class="no-border-card" body-classes="px-0 pb-1" footer-classes="pb-2">
            <div class="card-header border-0">
              <div class="row">
                <div class="col-6">
                  <h3 class="mb-0">Files per l'ordine di {{ selectedRow.progetto }}</h3>
                </div>
                <div class="col-6 text-right">
                  <el-tooltip content="Export" placement="top">
                    <base-button type="neutral" icon size="sm" @click="openUploadFileModal">
                      <span class="btn-inner--icon"><i class="fa-cloud-upload-alt fas"></i></span>
                      <span class="btn-inner--text">Carica</span>
                    </base-button>
                  </el-tooltip>
                </div>
              </div>
            </div>
            <div>
              <el-table :data="reactiveFileData" row-key="id" header-row-class-name="thead-light" ref="fileTable">
                <!-- Files Column -->
                <el-table-column align="right" label="File">
                  <div slot-scope="{$index, row}" class="d-flex">
                    <base-button class="btn-tooltip" type="danger" size="sm" icon @click.native="showPDFViewver(row)">
                      <a :href="row.path" target="_blank"><i class="text-white fa fa-file-pdf"></i></a>
                      <!-- <i class="text-white fa fa-file-pdf"></i> -->
                    </base-button>
                  </div>
                </el-table-column>
                <el-table-column label="nome" :formatter="(row) => row.path.split('/').pop()"></el-table-column>

                <!-- Action Column -->
                <el-table-column align="right" label="Actions">
                  <div slot-scope="{$index, row}" class="d-flex">
                    <base-button @click.native="handleDeleteFile($index, row)" class="remove btn-link" type="danger" size="sm" icon>
                      <i class="text-white fa fa-trash"></i>
                    </base-button>
                  </div>
                </el-table-column>
              </el-table>

            </div>
          </card>
        </div>
      </div>
      <!-- Details table -->  
      <div class="container-fluid mt--6 col-4" v-if="showDetails">
        <div>
          <card class="no-border-card" body-classes="px-0 pb-1" footer-classes="pb-2">
            <div class="card-header border-0">
              <div class="row">
                <div class="col-6">
                  <h3 class="mb-0">Dettagli per l'ordine di {{ selectedRow.progetto }}</h3>
                </div>
              </div>
            </div>
            <div>
              <el-table :data="detailsData" row-key="id" header-row-class-name="thead-light" ref="fileTable">
                <!-- All columns -->
                <el-table-column v-for="column in Object.keys(detailsData[0])" :key="column.label" v-bind="column" :formatter="column.formatter"></el-table-column>
              </el-table>

            </div>
          </card>
        </div>
      </div>

    </div>
  </div>
</template>
<script>
import { Table, TableColumn, Select, Option } from 'element-ui';
import RouteBreadCrumb from '@/components/Breadcrumb/RouteBreadcrumb'
import FileInput from '@/components/Inputs/FileInput'
import { BasePagination } from '@/components';
import searchTableMixin from '../Tables/PaginatedTables/searchTableMixin'
import swal from 'sweetalert2';
import { Modal } from '@/components';
import pdf from 'vue-pdf'
import moment from 'moment'
import lodash from 'lodash'

import * as __ from '../../store/constants'

export default {
  mixins: [searchTableMixin],
  components: {
    pdf,
    Modal,
    BasePagination,
    RouteBreadCrumb,
    FileInput,
    [Select.name]: Select,
    [Option.name]: Option,
    [Table.name]: Table,
    [TableColumn.name]: TableColumn
  },
  props: ['id'],
  data() {
    return {
      model: 'ordine',
      title: 'Ordini',
      searchColumns: ['progetto'],
      hiddenColumns: ['trec','created_at','created_by','updated_at','updated_by','id_progetto','id_stato'],
      tableColumns: [],
      tableData: [],
      tableDataCSSClassBase: 'container-fluid mt--6 col-12',
      tableDataCSSClass: 'container-fluid mt--6 col-12',
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
        hiddenColumns: ['id','trec','created_at','created_by','updated_at','updated_by','id_progetto','id_stato','cliente'],
        show: false,
        type: '', //insert|update
        title: '',
        data: {}
      }
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
    async fetchData( ) {
      
      await this.$store.dispatch(__.GETALL,this.model)
      await this.$store.dispatch(__.GETALL,'progetto')
      await this.$store.dispatch(__.GETWHERE,{model: 'stato', cond: [{field: 'entita', op: '=', value: 'ordine'}]})

      this.projectSelectOptions = this.$store.getters.projectSelectOptions
      this.statusOrderSelectOptions = this.$store.getters.statusSelectOptions

      this.modal.fields = this.$store.state.orders.fields
      .filter( f => !this.modal.hiddenColumns.includes(f))
      .map( f => {
        switch(f){
          case 'data_consegna':
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
          case 'importo':
            return {
              type: 'currency',
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

      this.tableColumns = this.$store.state.orders.fields
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
          default: 
            return {
              formatter: (row, column) => row[column.property],
              prop: f, 
              sortable: true,
              label: f.replace('_',' '),
            }
          }
        })
      
      this.tableData = this.$store.state.orders.records

      // this.$store.state.file.records.map( file => {
      //   const progetto = (this.$store.state.projects.records.filter( i => i.id == file.progetto ).pop() || {}).impianto
      //   const idx = this.tableData.findIndex( i => i.progetto == progetto)
      //   if( idx >= 0 ) {
      //     if (!_.isArray(this.tableData[idx].files)) this.tableData[idx].files = []
      //     this.tableData[idx].files.push(file)
      //   }
      // })
    },
    handleRowSelect( row ){
      this.selectedRow = row
    },
    handleShowFiles ( row ) {
      this.fileData = !_.isEqual(this.fileData, row.files) && row.files ? row.files : []
      this.showFiles = this.fileData.length
      this.tableDataCSSClass = this.showFiles ? 'container-fluid mt--6 col-8' : this.tableDataCSSClassBase
    },
    handleShowDetails ( row ) {
      this.detailsData = !_.isEqual(this.detailsData, this.$store.state.orderRows.records) ? this.$store.state.orderRows.records : []
      this.showDetails = this.detailsData.length
      this.tableDataCSSClass = this.showDetails ? 'container-fluid mt--6 col-8' : this.tableDataCSSClassBase
    },
    showPDFViewver(row){
      this.pdf_path = row.path
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
    openUploadFileModal( row ) {
      this.modal.type = 'upload'
      this.modal.data.file = {}
      this.modal.condition = [{field: 'id', op: '=', value: row.id}]
      this.modal.show = true
      this.modal.title = 'Aggiungi file a '
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
        this.$notify({type:'success', message: `Contratto salvato correttamente`})
        await this.fetchData()
        this.modal.show = false
      }
    },
    async handleSaveFile () {
      const res = await this.$store.dispatch(__.UPLOAD,{type:'ordine', id : this.selectedRow.id, file: this.modal.data.file })
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
        this.refreschFileData()
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
    handleDeleteFile( fileIndex, file ){
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
          this.refreschFileData()
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
      this.modal.data.file = files[0]
    }
  }
};
</script>
<style>
  .no-border-card .card-footer{
    border-top: 0;
  }
</style>
