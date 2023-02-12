<template>
  <div class="card">
    <div class="card-header border-0">
      <div class="row align-items-center">
        <div class="col-4">
          <h3 class="mb-0">Offerte</h3>
        </div>
        <div class="col-4">
          <base-input v-model="searchQuery" prepend-icon="fas fa-search" placeholder="Cerca..."> </base-input>
        </div>
        <div class="col-4 text-xl-right">
          <base-button v-if="Object.keys(rowSelected).length > 0">Edit</base-button>
          <base-button>Add</base-button>
        </div>
      </div>
    </div>

    <div class="table-responsive">
      <el-table 
        class="table-responsive table" 
        :data="queriedData" 
        header-row-class-name="thead-light" 
        @row-click="handleRowClick"
        highlight-current-row
      >
        <el-table-column v-for="field in fields" :key="field" :label="field[0].toUpperCase()+field.slice(1)" :prop="field" :formatter="formatter" label-class-name="custom-header-class"></el-table-column>

      </el-table>
    </div>
    <div slot="footer" class="col-12 d-flex justify-content-center justify-content-sm-between flex-wrap" >
      <div class="">
        <p class="card-category">
          Showing {{ from + 1 }} to {{ to }} of {{ total }} entries
        </p>

      </div>
      <base-pagination
        class="pagination-no-border"
        v-model="pagination.currentPage"
        :per-page="pagination.perPage"
        :total="total"
      ></base-pagination>
    </div>

  </div>
</template>
<script>
  import { BaseProgress, BaseSlider } from '@/components';
  import { Table, TableColumn, DropdownMenu, DropdownItem, Dropdown } from 'element-ui'
  import searchTableMixin from '../Tables/PaginatedTables/searchTableMixin'
  import * as __ from '../../store/constants'
  import _ from 'lodash'
  import moment from 'moment'
  export default {
    mixins: [searchTableMixin],
    name: 'offers',
    components: {
      BaseProgress,
      BaseSlider,
      [Table.name]: Table,
      [TableColumn.name]: TableColumn,
      [Dropdown.name]: Dropdown,
      [DropdownItem.name]: DropdownItem,
      [DropdownMenu.name]: DropdownMenu,
    },
    props:{
      tableData: {
        type: Array,
        default: []
      },
      tableLimit: {
        type: Number,
        default: 0
      }
    },
    computed:{
      fields(){
        return Object.keys(this.tableData[0]).filter(f => !this.hiddenFields.includes(f))
      }
    },
    data() {
      return {
        rowSelected: {},
        searchColumns: ['ragione_sociale', 'impianto'],
        hiddenFields: ['trec','created_at','created_by','updated_at','updated_by']
      }
    },
    methods: {
      formatter(row, columnCtx){
        switch(columnCtx.property){
          case 'stato':
            return this.$store.getters.contractStatus.filter( item => item.id === row.stato )[0]['name']
          case 'progetto':
            const data = this.$store.getters.projects.filter( item => item.id === row.progetto)[0]
            const value = (data['impianto'] || '')  + " " + (data['luogo'] || '')
            return value[0].toUpperCase() + value.slice(1)
          case 'data_offerta':
          case 'data_accettazione':
            return moment(row[columnCtx.property]).format('YYYY-MM-DD')
          case 'importo_richiesto':
          case 'importo_accettato':
            return new Intl.NumberFormat('it-IT',{style: 'currency', currency: 'EUR'}).format(row[columnCtx.property])
          default:
            return row[columnCtx.property]

        }
        // return this.states.filter( cs => cs.id === row.id)['name']
      },
      handleRowClick(data){
        this.rowSelected = _.isEqual(data, this.rowSelected) ? {} : data
      }
    }
  }
</script>
<style>
  .cell.custom-header-class {
    word-break: break-word;
  }
</style>
