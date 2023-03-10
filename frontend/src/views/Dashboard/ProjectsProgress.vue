<template>
  <div class="card">
    <div class="card-header border-0">
      <div class="row align-items-center">
        <div class="col-8">
          <h3 class="mb-0">Avanzamento Progetti</h3>
        </div>
        <div class="col-4">
          <base-input v-model="searchQuery" prepend-icon="fas fa-search" placeholder="Cerca..."> </base-input>
        </div>
      </div>

      <div class="row heading" v-if="slider.show">
        <div class="col-4">
          <span class="range-slider-value">{{slider.label}}</span>
        </div>
        <div class="col-7">
          <base-slider v-model="slider.value" :options="slider.options"></base-slider>
        </div>
        <div class="col-1">
          <base-button size="sm" type="success" @click="saveProjectProgress">Salva</base-button>
        </div>
      </div>
      <div class="row heading" v-else>
        <div class="col-4">
          <span class="range-slider-value"></span>
        </div>
      </div>
    </div>

    <div class="table-responsive">
      <el-table 
        class="table-responsive table" 
        :data="queriedData" 
        header-row-class-name="thead-light" 
        @row-click="handleProjectProgressRowClick"
        highlight-current-row
      >
        <el-table-column label="Cliente" prop="ragione_sociale"></el-table-column>

        <el-table-column label="Impianto" prop="impianto"></el-table-column>

        <el-table-column prop="completamento">
          <template v-slot="{row}">
            <div class="d-flex align-items-center">
              <span class="mr-2">{{row.completamento}}%</span>
              <base-progress :type="row.progressType" :value="row.completamento" />
            </div>
          </template>
        </el-table-column>

      </el-table>
    </div>
    <div
            slot="footer"
            class="col-12 d-flex justify-content-center justify-content-sm-between flex-wrap"
          >
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
            >
            </base-pagination>
          </div>
  </div>
</template>
<script>
  import { BaseProgress, BaseSlider } from '@/components';
  import { Table, TableColumn, DropdownMenu, DropdownItem, Dropdown } from 'element-ui'
  import searchTableMixin from '../Tables/PaginatedTables/searchTableMixin'
  import * as __ from '../../store/constants'
  export default {
    mixins: [searchTableMixin],
    name: 'project-progress',
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
    data() {
      return {
        slider: {
          show: false,
          label: '',
          value:0,
          options:{
            step:5,
            tooltips:true
          }
        },
        rowSelected: {},
        searchColumns: ['ragione_sociale', 'impianto']
      }
    },
    methods:{
      saveProjectProgress () {
        const data = {
          model: 'progetto', 
          cond: [
            {field:'id', op:'=', value: this.rowSelected.id}
          ],
          payload: { completamento: this.slider.value }
        }
        this.$store.dispatch(__.UPDATE, data).then( () => {
          this.slider.show = false
          const idx = this.tableData.findIndex( row => row.id === this.rowSelected.id) 
          this.tableData[idx].completamento = parseInt(this.slider.value)
          this.tableData[idx].progressType = this.tableData[idx].completamento  >= 66 ? 'success' : this.tableData[idx].completamento >= 33 ? 'warning' : 'danger'
        })
        
      },
      handleProjectProgressRowClick ( data ) {
        const label = [data.ragione_sociale, data.impianto].join(' ')
        this.rowSelected = data
        this.slider.show = label == this.slider.label ? !this.slider.show : true,
        this.slider.value = data.completamento
        this.slider.label = this.slider.show ? label : ''
      },
    },
    created() {
      this.originalLimit = this.tableLimit
    }
  }
</script>
<style>
</style>
