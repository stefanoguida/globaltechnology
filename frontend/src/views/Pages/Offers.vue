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
                <div v-if="field.type=='checkbox'" class="row bg-white p-3" >
                  <el-checkbox 
                  class="ml-0 col-3" 
                  style="display: flex" 
                  v-for="option in field.options" 
                  v-model="modal.choosenServices[option.id]"
                  :inline="true" 
                  >
                    <div class="text-wrap align-self-center" style="max-width:100px">{{option.name}}</div>
                  </el-checkbox>
                </div>
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


    <!-- Detail modal-->
    <modal :show.sync="detailModal.show" size="lg" body-classes="p-0">
      <card type="secondary" header-classes="bg-transparent pb-5" body-classes="px-lg-5 py-lg-5" class="border-0 mb-0">
        <template>
          <div class="text-muted mb-4">
            <small>{{detailModal.title}}</small>
          </div>
          <form role="form">
            <div v-for="field in detailModal.fields">
              <base-input :type="field.type" :label="field.label" v-model="detailModal.data[field.prop]" alternative class="mb-3" :placeholder="field.label" >
                  <select v-if="field.type == 'select'" class="form-control" v-model="detailModal.data[field.prop]" filterable>
                    <option v-for="option in field.options" :value="option.value">{{ option.text }}</option>
                  </select>
                  <textarea v-if="field.type == 'textarea'" v-model="detailModal.data[field.prop]" class="form-control" rows="3"></textarea>
              </base-input>
            </div>
            <div class="text-right">
              <base-button type="primary" class="my-4" @click="detailModal.show = false">Annulla</base-button>
              <base-button type="primary" class="my-4" @click="handleDetailSave">Salva</base-button>
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
                    <el-select placeholder="Cliente" v-model="filters.testata.id_cliente" filterable>
                      <el-option value=""></el-option>
                      <el-option v-for="customer in customerSelectOptions" :key="customer.value" :label="customer.text" :value="customer.value"></el-option>
                    </el-select>
                  </el-form-item>

                  <el-form-item>
                    <el-select placeholder="Progetto" v-model="filters.testata.id_progetto" filterable>
                      <el-option value=""></el-option>
                      <el-option v-for="project in projectSelectOptions" :key="project.value" :label="project.text" :value="project.value"></el-option>
                    </el-select>
                  </el-form-item>

                  <el-form-item>
                    <el-select placeholder="Stato" v-model="filters.testata.id_stato" filterable>
                      <el-option value=""></el-option>
                      <el-option v-for="status in statusOfferSelectOptions" :key="status.value" :label="status.text" :value="status.value"></el-option>
                    </el-select>
                  </el-form-item>

                  <el-form-item>
                    <el-select placeholder="Fornitura" v-model="filters.dettaglio.id_servizio" filterable>
                      <el-option value=""></el-option>
                      <el-option v-for="status in servicesSelectOptions" :key="status.value" :label="status.text" :value="status.value"></el-option>
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
              <el-table-column type="expand" >
                <template #default="props">
                  <div class="row">
                    <div class="col-12 text-right">
                      <base-button icon type="primary" @click="openCreateDetailModal(props.row.id)">
                        <span class="btn-inner--icon"><i class="fa fa-plus"></i></span>
                      </base-button>
                    </div>
                  </div>
                  <el-table :data="tableDetailsData.filter( d => d.id_offerta == props.row.id)">
                    <el-table-column 
                      v-for="detailColumn in tableDetailsColumns" 
                      :key="detailColumn.label" 
                      v-bind="detailColumn" 
                      :formatter="detailColumn.formatter"
                    ></el-table-column>
                    <!-- Action Column -->
                    <el-table-column align="right" label="Actions" >
                      <div slot-scope="{$index, row}" class="d-flex">
                        <base-button @click.native="openUpdateDetailModal($index, {...row, id_offerta: props.row.id})" class="edit" type="warning" size="sm" icon >
                          <i class="text-white ni ni-ruler-pencil"></i>
                        </base-button>
                        <base-button @click.native="handleDetailDelete($index, {...row, id_offerta: props.row.id})" class="remove btn-link" type="danger" size="sm" icon>
                          <i class="text-white fa fa-trash"></i>
                        </base-button>
                      </div>
                    </el-table-column>
                  </el-table>
                </template>
              </el-table-column>
              
              <!-- All columns -->
              <el-table-column 
                v-for="column in tableColumns" 
                :key="column.label" 
                v-bind="column" 
                :formatter="column.formatter"
                :min-width="column.minWidth||180"
                label-class-name="custom-header-class"
              ></el-table-column>

              <!-- Action Column -->
              <el-table-column align="right" label="Actions" min-width="200">
                <div slot-scope="{$index, row}" class="d-flex">
                  <base-button @click="handleShowPDF($index, row)"  class="edit" :type="row.has_pdf > 0 ? 'success' : 'primary'" size="sm" icon>PDF {{ row.has_pdf }}</base-button>
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
import { Table, TableColumn, Select, Option, Form, FormItem, DatePicker, Row, Col, Card, Checkbox } from 'element-ui';
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
    [Form.name]: Form,
    [FormItem.name]: FormItem,
    [DatePicker.name]: DatePicker,
    [Select.name]: Select,
    [Option.name]: Option,
    [Table.name]: Table,
    [TableColumn.name]: TableColumn,
    [Checkbox.name]: Checkbox
  },
  data() {
    return {
      model: 'offerta',
      title: 'Offerte',
      searchColumns: ['progetto'],
      hiddenColumns: ['trec','created_at','created_by','updated_at','updated_by','id_progetto','id_stato','id_cliente','id_tipo_progetto'],
      hiddenDetailColumns: ['id','trec','created_at','created_by','updated_at','updated_by','id_offerta','id_servizio','codice_fornitura'],
      tableColumns: [],
      baseTableData: [],
      tableData: [],
      tableDetailsColumns: [],
      tableDetailsData: [],
      selectedRows: [],
      selectedRow: {},
      pagination:{
        perPage:25
      },
      filters: {
        testata: {
          id_cliente: '',
          id_progetto: '',
          id_stato: ''
        },
        dettaglio: {
          id_servizio: ''
        }
      },
      modal: {
        fields:[],
        hiddenColumns: ['id','trec','created_at','created_by','updated_at','updated_by', 'id_progetto', 'id_stato', 'id_cliente', 'id_tipo_progetto'],
        show: false,
        type: '', //insert|update
        title: '',
        data: {},
        choosenServices:[]
      },
      detailModal: {
        fields:[],
        hiddenColumns: ['id','trec','created_at','created_by','updated_at','updated_by', 'id_offerta','id_servizio','codice_fornitura'],
        show: false,
        type: '', //insert|update
        title: '',
        data: {},
        rowData: []
      },
      pdfmodal: {
        show: false,
        title: 'Gestisci file',
        data: [],
        newFile: {}
      },
      projectSelectOptions: [],
      statusOfferSelectOptions: [],
      customerSelectOptions: [],
      servicesSelectOptions: []
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
      const headFilters = Object.fromEntries(Object.entries(this.filters.testata).filter( el => el[1] ))
      const detailFilters = Object.fromEntries(Object.entries(this.filters.dettaglio).filter( el => el[1] ))

      const hasFilterHead = !lodash.isEmpty(headFilters)
      const hasFilterDetail = !lodash.isEmpty(detailFilters)

      if (!hasFilterHead && !hasFilterDetail) {
        this.tableData = this.baseTableData
      }

      let filteredOfferRows = []
      if( hasFilterDetail ){
        filteredOfferRows = this.$store.state.offerRows.records
        .filter( el => Object.entries(detailFilters).every( f => f[1] ? el[f[0]] == f[1] : true ) )
        .reduce( (acc, curr) => {
          acc.push(curr.id_offerta)
          return acc
        }, [])
      }

      let filteredOffers = []
      if( hasFilterHead || hasFilterDetail ) {
        filteredOffers = this.baseTableData
        .filter( el => Object.entries(headFilters).every( f => f[1] ? el[f[0]] == f[1] : true ))
        .filter( el => filteredOfferRows.length ? filteredOfferRows.includes(el.id) : true )
        this.tableData = filteredOffers
      }
    },

    async fetchData( ) {
      try {
        await Promise.all([
          this.$store.dispatch(__.GETALL,this.model),
          this.$store.dispatch(__.GETALL,'riga_offerta'),
          this.$store.dispatch(__.GETALL,'servizio'),
          this.$store.dispatch(__.GETALL,'progetto'),
          this.$store.dispatch(__.GETALL,'tipo_progetto'),
          this.$store.dispatch(__.GETWHERE,{model: 'stato', cond: [{field: 'entita', op: '=', value: 'offerta'}]}),
          this.$store.dispatch(__.GETALL,'cliente'),
          this.$store.dispatch(__.DESCTABLE,'offerta'),
          this.$store.dispatch(__.DESCTABLE,'riga_offerta')
        ])

        this.customerSelectOptions = this.$store.getters.customerSelectOptions
        this.projectSelectOptions = this.$store.getters.projectSelectOptions
        this.statusOfferSelectOptions = this.$store.getters.statusSelectOptions
        this.servicesSelectOptions = this.$store.getters.servicesSelectOptions
        this.projectTypeSelectOptions = this.$store.getters.projectTypeSelectOptions

        this.baseTableData =  (lodash.has(this.$store.state, 'offers.records') ? this.$store.state.offers.records : [])
        .map( r => ({ 
            ...r, 
            prezzo_al_kw: new Intl.NumberFormat('de-DE', { style: 'currency', currency: 'EUR' }).format((parseFloat(r.importo_contrattato) || parseFloat(r.importo_offerto)) / parseFloat(r.kw))
          }) )

        this.tableData = this.baseTableData
        this.tableDetailsData = lodash.has(this.$store.state, 'offerRows.records') ? this.$store.state.offerRows.records : []
        this.selectedRow = this.tableData.sort( (a,b) => a.id<b.id ? -1 : 1)[0]

        this.modal.fields = this.$store.state.tableDescOfferta.fields
        .filter( f => !this.modal.hiddenColumns.includes(f))
        .map( f => {
          switch(f){
            case 'data_accettazione':
            case 'data_offerta':
              return {
                type: 'date',
                prop: f, 
                label: f.replace('_',' ')
              }
            case 'kw':
            case 'importo_contrattato':
            case 'importo_offerto':
              return {
                type: 'number',
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
            case 'tipo_progetto':
              return {
                type: 'select',
                prop: 'id_tipo_progetto', 
                label: f.replace('_',' '),
                options: this.projectTypeSelectOptions
              }
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
                options: this.statusOfferSelectOptions
              }
            default: 
              return {
                type: 'input',
                prop: f, 
                label: f.replace('_',' '),
              }
          }
        })

        const optionsServizi = lodash.has(this.$store.state, 'services.records') ? this.$store.state.services.records.filter(r => r.tipo == 'servizio').map(r => lodash.pick(r,['id','name']) ) : []
        this.modal.fields.push({type: 'checkbox', prop: 'servizi', label: 'Servizi', options: optionsServizi})

        const optionsForniture = lodash.has(this.$store.state, 'services.records') ? this.$store.state.services.records.filter(r => r.tipo == 'fornitura').map(r => lodash.pick(r,['id','name']) ) : []
        this.modal.fields.push({type: 'checkbox', prop: 'forniture', label: 'Forniture', options: optionsForniture })

        this.detailModal.fields = this.$store.state.tableDescRigaOfferta.fields
        .filter( f => !this.detailModal.hiddenColumns.includes(f))
        .map( f => {
          switch(f){
            case 'fornitura':
              return {
                type: 'select',
                prop: 'id_servizio', 
                label: f.replace('_',' '),
                options: this.servicesSelectOptions
              }
            case 'descrizione':
              return {
                type: 'textarea',
                prop: f, 
                label: f.replace('_',' ')
              }
            case 'data_arrivo_merce':
              return {
                type: 'date',
                prop: f, 
                label: f.replace('_',' ')
              }
            case 'importo_offerto':
            case 'importo_contrattato':
              return {
                type: 'number',
                prop: f, 
                label: f.replace('_',' ')
              }
            case 'pagamento':
              return {
                type: 'select',
                prop: f, 
                label: f.replace('_',' '),
                options: [{text:'NO', value:0}, {text:'SI', value: 1}]
              }
            default: 
              return {
                type: 'input',
                prop: f, 
                label: f.replace('_',' '),
              }
          }
        })

        this.tableColumns = this.$store.state.tableDescOfferta.fields
        .filter( f => !this.hiddenColumns.includes(f))
        .map( f => {
          switch(f){
            case 'id':
              return {
                formatter: (row, column) => row[column.property],
                prop: f, 
                sortable: false,
                label: f.replace('_',' '),
                minWidth: 70
              }
            case 'data_accettazione':
            case 'data_offerta':
              return {
                formatter: (row, column) => row[column.property] ? moment(row[column.property]).format('DD-MM-YYYY') : '',
                prop: f, 
                sortable: true,
                label: f.replace('_',' ')
              }
            case 'importo_offerto':
            case 'importo_contrattato':
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

        this.tableColumns.push({type:'number', prop: 'prezzo_al_kw', label: 'Prezzo/KW', })
        
        this.tableDetailsColumns = this.$store.state.tableDescRigaOfferta.fields
        .filter( f => !this.hiddenDetailColumns.includes(f))
        .map( f => {
          switch(f){
            case 'importo_offerto':
            case 'importo_contrattato':
              return {
                formatter: (row, column) => new Intl.NumberFormat('it-IT',{ style: 'currency', currency: 'EUR' }).format(row[column.property]),
                prop: f, 
                sortable: true,
                label: f.replace('_',' ')
              }
            case 'pagamento':
              return {
                formatter: (row, column) => row[column.property] ? 'Si' : 'No',
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
        
        this.handleSearch()
      }
      catch ( err ) {
        console.log(err)
      } 
    },

    handleRowSelect( row ){
      this.selectedRow = row
    },

    async handleShowPDF( index, row ) {
      const payload = {
        model: 'file', 
        cond: [
          { field:"id_riferimento", op:"=", value:row.id },
          { field:"tipo", op:"=", value:"offerta" }
        ]
      }
      await this.$store.dispatch(__.GETWHERE, payload)
      this.pdfmodal.data = this.$store.state.file.records
      this.pdfmodal.show = true
    },

    openCreateModal(){
      this.modal.type = 'insert'
      this.modal.data = {data_offerta: moment().format('YYYY-MM-DD'), id_stato: 1, id_tipo_progetto:1}
      this.modal.show = true
      this.modal.title = 'Crea nuovo contratto'
      this.modal.fields = this.modal.fields.filter( f => !['id_progetto','data_accettazione','importo_contrattato'].includes(f.prop))
      this.modal.choosenServices = lodash.has(this.$store.state, 'services.records') ? this.$store.state.services.records.reduce( (acc,curr) => {
        acc[curr.id] = false
        return acc
      }, {}) : []
    },

    openCreateDetailModal(offerId){
      this.detailModal.type = 'insert'
      this.detailModal.data = {id_offerta: offerId}
      this.detailModal.show = true
      this.detailModal.title = 'Inserisci un nuovo servizio / fornitura'
    },

    openUpdateModal(index, row){
      this.modal.type = 'update'
      this.modal.data = Object.entries(row).reduce( (a,c) => {
        switch(c[0]){
          case "data_accettazione":
            a[c[0]] =  c[1] ? moment(c[1]).format('YYYY-MM-DD') : c[1]
            break
          case "data_offerta":
            a[c[0]] =  moment(c[1]).format('YYYY-MM-DD')
            break
          case "progetto":
            a[c[0]] = (this.projectSelectOptions.filter( r => r.text == c[1]).pop()).value
            break;
          case "tipo_progetto":
            a[c[0]] = (this.projectTypeSelectOptions.filter( r => r.text == c[1]).pop()).value
            break;
          case "stato":
            a[c[0]] = (this.statusOfferSelectOptions.filter( r => r.text == c[1]).pop()).value
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
      const choosenServices = this.$store.state.offerRows.records
      .filter( r => r.id_offerta == row.id )
      .reduce( (acc,curr) => {
        acc.push(curr.id_servizio)
        return acc
      }, [])
      this.modal.choosenServices = this.$store.state.services.records.reduce( (acc,curr) => {
        acc[curr.id] = choosenServices.includes(curr.id) 
        return acc
      }, {})
    },

    openUpdateDetailModal(index, row){
      this.detailModal.type = 'update'
      this.detailModal.data = Object.entries(row).reduce( (a,c) => {
        switch(c[0]){
          case "data_offerta":
            a[c[0]] =  moment(c[1]).format('YYYY-MM-DD')
            break
          default:
            a[c[0]] = c[1]
            break;
        }
        return a
      },{})
      this.detailModal.condition = [{field: 'id', op: '=', value: row.id}]
      this.detailModal.show = true
      this.detailModal.title = `Modifica riga offerta`
    },

    checkTotalOffer(){
      const importo_contrattato = parseFloat(this.selectedRow.importo_contrattato) || parseFloat(this.selectedRow.importo_offerto)
      const importo_servizi = this.tableDetailsData.filter( r => r.id_offerta === this.selectedRow.id )
      .reduce( (acc, curr) => acc += parseFloat(curr.importo_contrattato) || parseFloat(curr.importo_offerto) || 0 ,0)
      return {isValid: importo_contrattato == importo_servizi, importo_contrattato, importo_servizi}
    },

    async saveMilestone( payload ) {
      
      const data = {
        model: 'milestone', 
        payload: {
          'id_contratto':payload.id_contratto,
          'descrizione':'SAL 1',
          'note':'',
          'importo_percentuale': 100,
          'importo_valore': payload.importo_contrattato,
          'id_stato':10
        }
      }
      const response = await this.$store.dispatch(__.INSERT, data)
      if(response.error) {
        this.$notify({type:'danger', message:"(code: 2) - Errore Creazione contratto!"})
        this.modal.show = false
        return 
      }

      return response.data.insertId
    },

    async saveContract( payload ) {
      const projectFields = ['id_cliente','id_progetto','data_accettazione','importo_contrattato','kw']
      const projectData = lodash.pick(payload, projectFields)

      const data = {
        model: 'contratto', 
        payload: projectData
      }
      const response = await this.$store.dispatch(__.INSERT, data)
      if(response.error) {
        this.$notify({type:'danger', message:"(code: 2) - Errore Creazione contratto!"})
        this.modal.show = false
        return 
      }

      return response.data.insertId
    },

    async saveProject () {
      const projectFields = ['id_cliente','id_tipo_progetto','luogo','impianto']
      const projectData = lodash.pick(this.modal.data, projectFields)

      const data = {
        model: 'progetto', 
        payload: {...projectData, id_stato: 13}
      }
      const response = await this.$store.dispatch(__.INSERT, data)
      if(response.error) {
        this.$notify({type:'danger', message:"(code: 1) - Errore Creazione offerta!"})
        this.modal.show = false
        return 
      }

      return response.data.insertId
    },

    async saveOffer( method, payload ) {
      const data = {
        model: this.model, 
        payload: lodash.omit(payload, ['cliente','progetto','stato','tipo_progetto']),
        cond: this.modal.condition || []
      }
      const response = await this.$store.dispatch(method, data)
      if ( response.error ) {
        this.$notify({type:'danger', message:response.message})
        this.modal = { ...this.modal, type: '', title: '', data: {} }
      }
      else {
        const offer_id = method == __.INSERT ? response.data.insertId : this.selectedRow.id
        await this.saveServices(method, offer_id)
        this.$notify({type:'success', message: `Offerta salvata correttamente`})
      }
    },

    async saveServices (method, offer_id) {
      if(method == __.UPDATE){
        await this.$store.dispatch(__.DELETEWHERE, {
          model: 'riga_offerta',
          cond: [{field:'id_offerta', op:'=', value: offer_id}]
        })
      }
      const servicesData = {
        model: 'riga_offerta',
        payload: Object.entries(this.modal.choosenServices).reduce( (acc, curr) => {
          if(curr[1]) acc.push({id_offerta: offer_id, id_servizio: curr[0]})
          return acc
        }, []),
        cond: [{field:'id_offerta', op:'=', value: offer_id}]
      }
      console.log(servicesData)
      await this.$store.dispatch(__.INSERT, servicesData)
    },

    async saveOrders ( id_progetto ) {
      let data = {
        model: 'ordine', 
        payload: {id_progetto, id_stato: 7}, // stato da ordinare
      }
      const response = await this.$store.dispatch(__.INSERT,data)
      const id_ordine = response.data.insertId
      const id_forniture = this.$store.state.services.records.filter(r => r.tipo == 'fornitura').reduce( (acc, curr) => {
        acc.push(curr.id)
        return acc
      }, [])
      
      const righe_ordine = Object.entries(this.modal.choosenServices)
      .filter( s => s[1] && id_forniture.includes(parseInt(s[0])))
      .reduce( (acc,curr) => {
        acc.push({id_ordine, id_servizio: curr[0]})
        return acc
      }, [])
      
      data = {
        model: 'riga_ordine',
        payload: righe_ordine
      }
      console.log(data)
      await this.$store.dispatch(__.INSERT,data)
    },

    async saveOfferRows () {
      const offerRows = this.tableDetailsData.filter( r => r.id_offerta == this.selectedRow.id)
      const jobs = []
      for( const row of offerRows ) {
        const data = {
          model: 'riga_offerta', 
          payload: {... lodash.omit(row,['codice_fornitura','fornitura']), importo_contrattato: row.importo_contrattato || row.importo_offerto},
          cond: [{field:'id', op:'=', value:row.id}]
        }
        jobs.push(this.$store.dispatch(__.UPDATE, data))
      }
      const responses = await Promise.all(jobs)
      if (responses.some( r => r.error) ){
        this.$notify({type:'danger', message:"Errore durante il l'aggiornamento delle righe offerta"})
        return false
      }
      return true
    },

    async handleSave () {
      const method = this.modal.type == 'insert' ? __.INSERT : __.UPDATE
      
      const payload = lodash.omit(this.modal.data, ['id', 'trec', 'created_at', 'created_by', 'updated_at', 'updated_by', 'prezzo_al_kw', 'has_pdf'])

      if( method == __.INSERT ){
        payload.id_progetto = await this.saveProject()
      }
      // se è contrattualizzato
      if ( payload.id_stato == 2 ) {
        payload.data_accettazione = !payload.data_accettazione ? moment().format('YYYY-MM-DD') : moment(payload.data_accettazione).format('YYYY-MM-DD')
        payload.importo_contrattato = !payload.importo_contrattato ? payload.importo_offerto : payload.importo_contrattato
        await this.saveOffer( method, payload )
        await this.saveOfferRows()
        const id_contratto = await this.saveContract( payload )
        await this.saveMilestone( {id_contratto, importo_contrattato: payload.importo_contrattato} )
        await this.saveOrders(payload.id_progetto)

        this.modal.show = false
        await this.fetchData()
        // const {isValid, importo_servizi} = this.checkTotalOffer()
        // if ( !isValid ) {
        //   swal.fire({
        //     title: 'Attenzione!',
        //     text: `
        //     La somma degli importi dei servizi non corrisponde al totale dell'offerta.
        //     Nel contratto verrà inserita la somma degli importi dei contratti.
        //     Continuare ?`,
        //     type: 'warning',
        //     showCancelButton: true,
        //     confirmButtonClass: 'btn btn-success btn-fill',
        //     cancelButtonClass: 'btn btn-danger btn-fill',
        //     confirmButtonText: 'Si',
        //     cancelButtonText: 'No',
        //     buttonsStyling: false
        //   })
        //   .then( async result => {
        //     payload.importo_contrattato = result.isConfirmed ? importo_servizi : payload.importo_contrattato
        //     await this.saveOffer( method, payload )
        //     await this.saveOfferRows()
        //     const id_contratto = await this.saveContract( payload )
        //     await this.saveMilestone( {id_contratto, importo_contrattato: payload.importo_contrattato} )
        //     await this.saveOrders(payload.id_progetto)

        //     this.modal.show = false
        //     await this.fetchData()
        //   })
        //   .catch( error => console.log(error) )
        // }
        // else {
        //   await this.saveOffer( method, payload )
        //   const id_contratto = await this.saveContract( payload )
        //   await this.saveMilestone( {id_contratto, importo_contrattato: payload.importo_contrattato} )
        //   this.modal.show = false
        //   await this.fetchData()
        // }
      }
      else {
        await this.saveOffer( method, payload )
        this.modal.show = false
        await this.fetchData()
      }
      
      
    },

    async handleDetailSave () {
      const method = this.detailModal.type == 'insert' ? __.INSERT : __.UPDATE
      let {id, trec, created_at, created_by, updated_at, updated_by,  ...payload } = this.detailModal.data
      const data = {
        model: 'riga_offerta', 
        payload: lodash.omit(payload,['codice_fornitura','fornitura']), 
        cond: this.detailModal.condition || []
      }
      const response = await this.$store.dispatch(method, data)
      if ( response.error ) {
        this.$notify({type:'danger', message:response.message})
        this.detailModal = { ...this.detailModal, type: '', title: '', data: {} }
      }
      else {
        this.$notify({type:'success', message: `Contratto salvato correttamente`})
        this.detailModal.show = false
        await this.fetchData()
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
    
    handleDetailDelete(index, row) {
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
          this.deleteDetailRow(row);
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

    async deleteDetailRow(row) {
      await this.$store.dispatch(__.DELETE,{model:'riga_offerta', id:row.id})
      let indexToDelete = this.tableDetailsData.findIndex(
        tableRow => tableRow.id === row.id
      );
      if (indexToDelete >= 0) {
        this.tableDetailsData.splice(indexToDelete, 1);
      }
    },

    selectionChange(selectedRows) {
      this.selectedRows = selectedRows
    },

    async handleSaveFile () {

      const data = {
        type:'offerta', 
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
