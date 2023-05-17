<template>
  <div>
    <dashboard-header></dashboard-header>

    <div class="container-fluid mt--6">
      <div class="row">
        <div class="col-xl-12">
          <el-card type="default" header-classes="bg-transparent">
            <div slot="header" class="row align-items-center">
              <div class="col">
                <h6 class="text-uppercase ls-1 mb-1">Riepilogo progetti da saldare</h6>
              </div>
            </div>

            <el-table :data="invoicedProjectsData">
              <el-table-column sortable prop="impianto" label="Progetto"></el-table-column>
              <el-table-column sortable prop="ragione_sociale" label="Cliente"></el-table-column>
              <el-table-column sortable prop="da_fatturare" label="Da Fatturare" :formatter="(row, column) => new Intl.NumberFormat('it-IT',{ style: 'currency', currency: 'EUR' }).format(row[column.property])"></el-table-column>
              <el-table-column sortable prop="fatturato" label="Fatturato non pagato" :formatter="(row, column) => new Intl.NumberFormat('it-IT',{ style: 'currency', currency: 'EUR' }).format(row[column.property])"></el-table-column>
              <el-table-column sortable prop="pagato" label="Pagato" :formatter="(row, column) => new Intl.NumberFormat('it-IT',{ style: 'currency', currency: 'EUR' }).format(row[column.property])"></el-table-column>
              <el-table-column sortable prop="totale" label="Totale" :formatter="(row, column) => new Intl.NumberFormat('it-IT',{ style: 'currency', currency: 'EUR' }).format(row[column.property])"></el-table-column>
            </el-table>
          </el-card>
        </div>
      </div>
    </div>
  </div>
</template>
<script>

  import { Table, TableColumn, Card } from 'element-ui';

  import DashboardHeader from './DashboardHeader.vue';
  import * as __ from '../../store/constants'

  export default {
    components: {
      DashboardHeader,
      [Card.name]: Card,
      [Table.name]: Table,
      [TableColumn.name]: TableColumn,
    },
    data() {
      return {
        invoicedProjectsData: []
      };
    },
    methods: {
      async init() {
        await this.$store.dispatch(__.GET_INVOICED_PROJECTS)
        this.invoicedProjectsData = this.$store.state.invoiced_projects
      }
    },
    async mounted() {
      await this.init()
    }
  };
</script>