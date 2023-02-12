<template>
  <!-- PDF Modal -->
  <modal :show.sync="show" size="xl" body-classes="p-0">
    <card type="secondary" header-classes="bg-transparent pb-5" body-classes="px-lg-5 py-lg-5" class="border-0 mb-0">
        <template>
          <div class="text-muted mb-4">
            <small>{{title}}</small>
          </div>
          <div class="row">
            <div class="col-11 text-right">
              <span v-if="percentageLeft < 0" class="text-danger text-xs text-monospace">Raggiunto il 100% dell'importo. Non è possibile più aggiungere milestone</span>
            </div>
            <div class="col-1 text-right">
              <base-button @click.native="addNewEmptyRow()" :disabled="percentageLeft<0" class="edit" type="primary" size="sm" icon >
              <i class="ni ni-fat-add"></i>
              </base-button>
            </div>
          </div>
          <form v-if="editable" role="form">
            <el-table :data="tableData" row-key="id" header-row-class-name="thead-light">
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
                  <base-input v-if="column.type == 'select'" @blur="handleBlur(column.prop, scope.row)" >
                    <select class="form-control" v-model="scope.row[column.prop]" filterable>
                      <option v-for="option in column.options" :value="option.value">{{ option.text }}</option>
                    </select>
                  </base-input>
                  <textarea v-else-if="column.type == 'textarea'" v-model="scope.row[column.prop]" class="form-control" rows="1"  @blur="handleBlur(column.prop, scope.row)"></textarea>
                  <!-- <base-input v-else-if="column.type == 'number'" :min="0" :max="percentageLeft" :type="column.type" v-model="scope.row[column.prop]" :disabled="column.disabled"  @blur="handleBlur(column.prop, scope.row)" ></base-input> -->
                  <base-input v-else :type="column.type" v-model="scope.row[column.prop]" :disabled="column.disabled"  @blur="handleBlur(column.prop, scope.row)" ></base-input>
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
          
          <!-- <el-table v-if="!editable" :data="tableData" row-key="id" header-row-class-name="thead-light">
            <el-table-column 
              v-for="column in tableColumns" 
              :key="column.label" 
              v-bind="column" 
              :formatter="column.formatter" 
              :min-width="column.minWidth||0"
            >
            </el-table-column>
            <el-table-column align="right" label="Actions" :min-width="50">
              <div slot-scope="{row}" class="d-flex">
                <base-button @click.native="handleDelete(row)" class="remove btn-link" type="danger" size="sm" icon>
                  <i class="text-white fa fa-trash"></i>
                </base-button>
              </div>
            </el-table-column>
          </el-table> -->

          <div class="text-right">
            <base-button type="primary" class="my-4" @click="show = false">Annulla</base-button>
            <base-button type="primary" class="my-4" @click="handleSave()">Salva</base-button>
          </div>
        </template>
      </card>
  </modal>
</template>
<script>
  import { Table, TableColumn, Select, Option, Row, Col, Card } from 'element-ui';
  import { Modal } from '@/components';
  import swal from 'sweetalert2';
  import FileInput from '@/components/Inputs/FileInput'
  import * as __ from '../../store/constants'
  import lodash from 'lodash'

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
      [TableColumn.name]: TableColumn
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
      tableColumns:{
        type: Array,
        default: []
      },
      tableData: {
        type: Array,
        default: []
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
      percentageLeft(){
        const tot_percentage =  this.tableData.reduce( (acc, curr) => (acc += parseInt(curr.importo_percentuale || 0) ), 0)
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

      }
    },
    data(){
      return {
        dataFields: []
      }
    },
    methods: {
      async init() {
        await this.$store.dispatch(__.DESCTABLE, 'milestones')
      },
      addNewEmptyRow() {
        const emptyRow = Object.keys(this.tableData[0]).reduce( (acc,curr) => {
          acc[curr] = curr == 'id_stato' ? 10 : ''
          return acc
        },{})
      this.tableData.push(emptyRow)
      },

      handleBlur(fieldName, row) {
        console.log(fieldName, row)
        if ( fieldName === 'importo_percentuale' ) {
          const idx = row.id ? this.tableData.findIndex( t => t.id == row.id) : this.tableData.length -1 
          const val = (this.total * this.tableData[idx].importo_percentuale) / 100
          this.tableData[idx].importo_valore = Math.round( (val + Number.EPSILON) * 100 ) / 100 || 0

          if ( this.percentageLeft < 0 ) {
            this.$notify({type:'danger', message:'Percentuali superiori al 100%!'})
            this.tableData[idx].importo_percentuale = 0
            this.tableData[idx].importo_valore = 0
          }
        }
        else if (fieldName === 'id_stato') {
          console.log(row)
        }
      },

      async handleSave() {
        const data = {
          model: 'milestone', 
          payload: this.tableData
          .filter( td => td.importo_percentuale > 0)
          .map( td => {
            const data = {
              ...lodash.pick(td, ['id_contratto','descrizione','Note','importo_percentuale','importo_valore','id_stato']),
              id_contratto: this.id_contratto,
            }
            if (td.id) data.id = td.id 
            return data
          } )
        }
        const response = await this.$store.dispatch(__.INSERT, data)
        if(response.error) {
          this.$notify({type:'danger', message:"(code: 2) - Errore Creazione contratto!"})
          this.modal.show = false
          return 
        }

        const paidMilestones = this.tableData.reduce( (acc, curr) => (acc += curr.id_stato == 12 ? 1 : 0), 0) // id_stato: 12 -> PAGATO
        const totMilestones = this.tableData.length
        const completamentoProgetto = parseInt(((paidMilestones / totMilestones) * 100))
        const projectId = (this.$store.state.contracts.records.filter( c => c.id == this.id_contratto).pop()).id_progetto

        await this.$store.dispatch(__.UPDATE,{model:'progetto', cond:[{field:'id', op:'=', value:projectId}], payload: {completamento: completamentoProgetto}})

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
