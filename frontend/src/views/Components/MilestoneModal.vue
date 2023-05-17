<template>
  <div>
    <modal :show.sync="showModal" size="xl" @close="handleCloseModal" >
      <template>
        <div class="text-muted mb-4">
          <h1>{{title}}</h1>
        </div>
        <div class="row">
          <div class="col-5 text-right">
            <span v-if="InvoicedPercentageLeft == 0" class="text-success text-xs text-monospace">Raggiunto il 100% dell'importo</span>
            <span v-else-if="InvoicedPercentageLeft < 0" class="text-danger text-xs text-monospace">Superato il 100% dell'importo. Ricalcolare le percentuali dei SAL</span>
          </div>
          <div class="col-4 text-right">
            <span>Importo contratto: {{ Intl.NumberFormat('it-IT',{style:'currency', currency:'EUR'}).format(total) }}</span><br />
            <span>Importo totale SAL: {{ Intl.NumberFormat('it-IT',{style:'currency', currency:'EUR'}).format(totaleSal) }}</span><br />
            <span>Importo totale Fatturato: {{ Intl.NumberFormat('it-IT',{style:'currency', currency:'EUR'}).format(totaleFatturato) }}</span><br />
            <span>Importo Ritenute: {{ Intl.NumberFormat('it-IT',{style:'currency', currency:'EUR'}).format(totaleRitenute) }}</span>
          </div>
          <div class="col-1 text-right">
            <base-button @click.native="addNewEmptyRow()" :disabled="InvoicedPercentageLeft <= 0" class="edit" type="primary" size="sm" icon >
            <i class="ni ni-fat-add"></i>
            </base-button>
          </div>
        </div>
        <form v-if="editable" role="form">
          <el-table :data="tableData" row-key="descrizione" header-row-class-name="thead-light">
            <el-table-column 
              v-for="column in tableColumns" 
              :key="column.label" 
              v-bind="column" 
              :formatter="column.formatter" 
              :min-width="column.minWidth||0"
              :readonly="!column.editable"
              label-class-name="custom-header-class"
            >
              <template slot-scope="scope">
                <el-select v-if="column.type == 'select'" v-model="scope.row[column.prop]" filterable>
                  <el-option v-for="option in column.options" :value="option.value" :label="option.text"></el-option>
                </el-select>
                <textarea v-else-if="column.type == 'textarea'" v-model="scope.row[column.prop]" class="form-control" rows="1"></textarea>
                <el-input v-else :type="column.type" v-model="scope.row[column.prop]" :formatter="column.formatter" :disabled="column.disabled" @change="handleRowChange(scope.row)"></el-input>
              </template>
            </el-table-column>
            <el-table-column align="right" :min-width="50">
              <div slot-scope="{$index, row}" class="d-flex">
                <base-button @click.native="handleDelete($index, row)" class="remove btn-link" type="danger" size="sm" icon>
                  <i class="text-white fa fa-trash"></i>
                </base-button>
              </div>
            </el-table-column>
          </el-table>
        </form>
        <div style="display: flex; flex-wrap: wrap;">
          <div class="text-left" style="width: 50%;">
            <base-button type="success" class="my-4" @click="addNewEmptyRow(true)" :disabled="InvoicedPercentageLeft <= 0 || totaleRitenute == 0">Genera SAL Ritenuta</base-button>
          </div>
          <div class="text-right" style="width: 50%;">
            <base-button type="primary" class="my-4" @click="showModal = false">Annulla</base-button>
            <base-button type="primary" class="my-4" @click="handleSave()">Salva</base-button>
          </div>
        </div>
      </template>
    </modal>
  
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
          <base-button type="primary" class="my-4" @click="preventCloseModal.show = showModal = false">Si</base-button>
          <base-button type="primary" class="my-4" @click="preventCloseModal.show = false">No</base-button>
        </div>
      </template>
    </modal>
  </div>
  
</template>
<script>
  import { Table, TableColumn, Select, Option, Row, Col, Card, Switch } from 'element-ui';
  import { Modal } from '@/components';
  import swal from 'sweetalert2';
  import FileInput from '@/components/Inputs/FileInput'
  import * as __ from '../../store/constants'
  import lodash from 'lodash'
  import moment from 'moment'
  moment.updateLocale(moment.locale(), { invalidDate: undefined })

  export default {
    name: 'MilestoneModal',
    components: {
      swal,
      Modal,
      FileInput,
      [Row.name]: Row,
      [Col.name]: Col,
      [Card.name]: Card,
      [Select.name]: Select,
      [Option.name]: Option,
      [Table.name]: Table,
      [TableColumn.name]: TableColumn,
      [Switch.name]: Switch
    },
    props: {
      show: {
        type: Boolean,
        default: false
      },
      title: {
        type: String,
        default: 'Milestones'
      },
      editable: {
        type: Boolean,
        default: false
      },
      total: {
        type: Number,
        default: 0
      },
      id_contratto: {
        type: Number,
        default: -1
      },
      id_progetto: {
        type: Number,
        default: -1
      }
    },
    computed: {
      showModal:{
        get(){
          return this.show
        },
        set(val){
          this.$emit("update:show", val);
          this.$emit("close");
        }
      },
      totaleSal(){
        return this.tableData.reduce( (acc, curr) => (acc += !/^SAL [0-9]+ R$/.test(curr.descrizione) ? parseFloat(curr.importo_valore || 0) : 0 ), 0)
      },
      totaleRitenute(){
        return this.tableData.reduce( (acc, curr) => (acc += parseFloat(curr.importo_valore || 0) - parseFloat(curr.ritenuta_valore || 0) ), 0)
      },
      totaleFatturato(){
        return this.tableData.reduce( (acc, curr) => (acc += parseFloat(curr.ritenuta_valore || 0) ), 0)
      },
      percentageLeft(){
        const tot_percentage =  this.tableData.reduce( (acc, curr) => (acc += parseInt(curr.importo_percentuale || 0) ), 0)
        return 100 - tot_percentage 
      },
      holdPercentageLeft(){
        const tot_percentage =  this.tableData.reduce( (acc, curr) => (acc += parseFloat(curr.ritenuta_percentuale || 0) ), 0)
        return 100 - tot_percentage 
      },
      InvoicedPercentageLeft(){
        const tot_percentage =  this.tableData.reduce( (acc, curr) => (acc += parseFloat(curr.fatturato_percentuale || 0) ), 0)
        return 100 - tot_percentage 
      }
    },
    watch: {
      show(newVal, oldVal) {
        if (newVal) {
          this.init() 
        }
        else{
          this.$emit("update:show", false);
          this.$emit("close");
        }
      },

      async id_contratto(newVal, oldVal) {
        const payload = {
          model: 'milestone', 
          cond: [{field:"id_contratto", op:"=", value: newVal}]
        } 

        await this.$store.dispatch(__.GETWHERE, payload)
        await this.$store.dispatch(__.GETWHERE,{model: 'stato', cond: [{field: 'entita', op: '=', value: 'milestone'}]})
        await this.$store.dispatch(__.GETALL, 'metodo_pagamento')

        this.tableColumns = (this.$store.state.tableDescMilestone.fields || [])
        .filter( f => ![
          'id',
          'trec',
          'created_at',
          'created_by',
          'updated_at',
          'updated_by',
          'id_contratto',
          'id_stato',
          'id_payment_method',
          'impianto',
        ].includes(f))
        .map( f => {
          switch(f){
            case 'id':
              return {
                formatter: (row, column) => row[column.property],
                prop: f, 
                label: f.replace('_',' '),
                type: 'text',
                minWidth: 50,
                disabled:true
              }
            case 'descrizione':
              return {
                formatter: (row, column) => row[column.property],
                prop: f, 
                label: 'ID',
                type: 'input',
                minWidth: 100,
                disabled: true
              }
            case 'Note':
              return {
                formatter: (row, column) => row[column.property],
                prop: f, 
                label: f.replace('_',' '),
                type: 'textarea',
                minWidth: 120
              }
            case 'stato': 
              return {
                formatter: (row, column) => row[column.property],
                prop: 'id_stato', 
                label: f.replace('_',' '),
                type: 'select',
                options: this.$store.getters.statusSelectOptions,
                minWidth: 100
              }
            case 'tipo_pagamento': 
              return {
                formatter: (row, column) => row[column.property],
                prop: 'id_payment_method', 
                label: f.replace('_',' '),
                type: 'select',
                options: this.$store.getters.paymentMethodSelectOptions,
                minWidth: 100
              }
            case 'importo_percentuale': 
              return {
                formatter: (row, column) => new Intl.NumberFormat('it-IT').format(row[column.property]),
                prop: f, 
                label: 'importo %',
                type: 'number',
                minWidth: 90
              }
            case 'importo_valore': 
              return {
                formatter: (row, column) => new Intl.NumberFormat('it-IT').format(row[column.property]),
                prop: f, 
                label: 'importo val',
                type: 'number',
                disabled:true,
                minWidth: 120
              }
            case 'ritenuta_percentuale': 
              return {
                formatter: (row, column) => new Intl.NumberFormat('it-IT').format(row[column.property]),
                prop: f, 
                label: 'ritenuta %',
                type: 'number',
                minWidth: 90
              }
            case 'ritenuta_valore': 
              return {
                formatter: (row, column) => new Intl.NumberFormat('it-IT').format(row[column.property]),
                prop: f, 
                label: 'fatturato val',
                type: 'number',
                disabled:true,
                minWidth: 120
              }
            case 'fatturato_percentuale': 
              return {
                formatter: (row, column) => new Intl.NumberFormat('it-IT').format(row[column.property]),
                prop: f, 
                label: 'fatturato %',
                type: 'number',
                disabled:true,
                minWidth: 90
              }
            case 'data_fatturazione': 
              return {
                formatter: (row, column) => moment(row[column.property]).format('DD-MM-YYYY'),
                prop: f, 
                label: f.replace('_',' '),
                type: 'date',
                minWidth: 120,
              }
            case 'data_pagamento': 
              return {
                formatter: (row, column) => row[column.property],
                prop: f, 
                label: f.replace('_',' '),
                type: 'date',
                minWidth: 120,
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

        this.tableData = (this.$store.state.milestone.records || [])
        .map( r => (
          {
            ... r, 
            data_fatturazione: moment(r.data_fatturazione).format('YYYY-MM-DD'), 
            data_pagamento: moment(r.data_pagamento).format('YYYY-MM-DD')
          }
        ))
      }
    },
    data(){
      return {
        dataFields: [],
        tableColumns: [],
        tableData: [],
        ritenuta_su_milestones: 0,
        preventCloseModal: {
          show: false
        }
      }
    },
    methods: {
      async init() {
        await this.$store.dispatch(__.DESCTABLE, 'milestone')
      },

      handleRowChange( row ){
        const idx = this.tableData.findIndex( t => t.id == row.id)
        if( idx < 0 ) return 

        this.tableData[idx].importo_valore = Number(Math.round((this.total * row.importo_percentuale) / 100 + 'e4') + 'e-4')
        this.tableData[idx].ritenuta_valore = Number(Math.round(row.importo_valore - ((row.importo_valore * row.ritenuta_percentuale) / 100) + 'e4') + 'e-4')
        this.tableData[idx].fatturato_percentuale = Number(Math.round((row.ritenuta_valore / this.total) * 100 + 'e8') + 'e-8')
      },

      async handleCloseModal(){
        this.preventCloseModal.show = true
        this.showModal = true
      },
      
      addNewEmptyRow(ritenuta = false) {
        const emptyRow = Object.keys(this.tableData[0]).reduce( (acc,curr) => {
          const perc = 100 - this.tableData.reduce( (acc, curr) => acc += parseFloat(curr.fatturato_percentuale), 0)
          switch (curr) {
            case 'id_stato':
              acc[curr] = 10
              break;
            case 'id_payment_method':
              acc[curr] = 1
              break;
            case 'descrizione':
              acc[curr] =  'SAL ' + (parseInt(this.tableData.length) + 1) + (ritenuta ? ' R' : '')
              break;
            case 'importo_percentuale':
            case 'fatturato_percentuale':
              acc[curr] = ritenuta ? perc : 0
              break
            case 'importo_valore':
              acc[curr] = ritenuta ? parseFloat(this.totaleSal) * (perc/100) : 0
              break
            case 'ritenuta_valore':
              acc[curr] = ritenuta ? parseFloat(this.totaleSal) * (perc/100): 0
              break
            case 'ritenuta_percentuale':
              acc[curr] = 0
              break
            default:
              acc[curr] = ''
              break;
          }
          return acc
        },{})

        emptyRow.ritenuta = true
        this.tableData.push(emptyRow)
      },

      beforeSave () {
        return new Promise( (resolve, reject) => {
          if (this.totaleFatturato.toFixed(2) == this.total.toFixed(2)) {
            resolve(true)
            return
          }
          swal.fire({
            title: 'Il totale dei SAL non raggiunge il 100% dell\'importo da fatturare. Procedere ?',
            text: `Questa azione non può essere annullata!`,
            type: 'warning',
            showCancelButton: true,
            confirmButtonClass: 'btn btn-success btn-fill',
            cancelButtonClass: 'btn btn-danger btn-fill',
            confirmButtonText: 'Salva!',
            cancelButtonText: 'Annulla',
            buttonsStyling: false
          })
          .then(result => {
            resolve(result.isConfirmed)
          })
          .catch( () => {
            resolve(false)
          })
        })
      },

      async handleSave() {
        const beforeSaveRet = await this.beforeSave()

        if (!beforeSaveRet)  return false

        const data = {
          model: 'milestone', 
          payload: this.tableData
          .filter( td => td.importo_percentuale > 0)
          .map( td => {
            const data = {
              ...lodash.pick(td, [
                'id_contratto',
                'descrizione',
                'Note',
                'importo_percentuale',
                'importo_valore',
                'ritenuta_percentuale',
                'ritenuta_valore',
                'fatturato_percentuale',
                'id_stato',
                'id_payment_method',
                'data_fatturazione',
                'data_pagamento'
              ]),
              id_contratto: this.id_contratto,
            }
            if (td.id) data.id = td.id 
            data.data_fatturazione = data.data_fatturazione || undefined
            data.data_pagamento = data.data_pagamento || undefined
            return data
          } )
        }
        const response = await this.$store.dispatch(__.INSERT, data)
        if(response.error) {
          this.$notify({type:'danger', message:"(code: 2) - Errore Creazione contratto!"})
          this.modal.show = false
          return 
        }

        const paidMilestones = this.tableData.length ? this.tableData.reduce( (acc, curr) => (acc += [11,12].includes(curr.id_stato) ? parseInt(curr.fatturato_percentuale) : 0), 0) : 0
        const completamentoProgetto = paidMilestones
        const projectId = (this.$store.state.contracts.records.filter( c => c.id == this.id_contratto).pop()).id_progetto

        await this.$store.dispatch(__.UPDATE,{model:'progetto', cond:[{field:'id', op:'=', value:projectId}], payload: {completamento: completamentoProgetto}})
        await this.$store.dispatch(__.UPDATE,{model:'contratto', cond:[{field:'id', op:'=', value:this.id_contratto}], payload: {ritenuta_su_milestones: this.ritenuta_su_milestones}})

        this.$emit("after-save")
      },

      handleDelete(index, row) {
        this.tableData.splice(index,1)
        this.$store.dispatch(__.DELETE,{model: 'milestone', id: row.id})
      }
    }
  };
</script>
<style>
  .cell.custom-header-class {
    word-break: break-word;
  }
</style>
