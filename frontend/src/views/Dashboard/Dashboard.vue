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
  // Charts
  import * as chartConfigs from '@/components/Charts/config';
  import LineChart from '@/components/Charts/LineChart';
  import BarChart from '@/components/Charts/BarChart';

  // Components
  import BaseProgress from '@/components/BaseProgress';
  import RouteBreadCrumb from '@/components/Breadcrumb/RouteBreadcrumb';
  import StatsCard from '@/components/Cards/StatsCard';

  // Lists
  import ActivityFeed from './ActivityFeed';
  import TaskList from './TaskList';
  import UserList from './UserList';
  import ProgressTrackList from './ProgressTrackList';

  // Tables
  import LightTable from './LightTable';
  import SocialTrafficTable from './SocialTrafficTable';
  import PageVisitsTable from './PageVisitsTable';
  import { Table, TableColumn, Select, Option, Form, FormItem, DatePicker, Row, Col, Card, Checkbox } from 'element-ui';

  import ProjectProgress from './ProjectsProgress.vue';
  import Offers from './Offers.vue'
  import FlatData from './FlatData.vue'

  import DashboardHeader from './DashboardHeader.vue';
  import * as __ from '../../store/constants'
  import moment from 'moment'
  import lodash from 'lodash'

  export default {
    components: {
      ActivityFeed,
      LineChart,
      BarChart,
      BaseProgress,
      RouteBreadCrumb,
      StatsCard,
      TaskList,
      PageVisitsTable,
      SocialTrafficTable,
      LightTable,
      UserList,
      ProgressTrackList,
      ProjectProgress,
      Offers,
      FlatData,
      DashboardHeader,
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
        kwPerMonthChartData : null,
        invoicedProjectsData: []
      };
    },
    computed: {
      kpi(){
        return this.$store.getters.getKPIs
      },
      flatData(){
        try {
          return this.$store.state.flatData.records || []
        }
        catch ( error ) {
          return []
        }
      }
    },
    methods: {
      async init() {
        await this.$store.dispatch(__.GET_KW_PER_MONTH)
        await this.$store.dispatch(__.GET_INVOICED_PROJECTS)
        this.invoicedProjectsData = this.$store.state.invoiced_projects
      }
    },
    async mounted() {
      await this.init()
    }
  };
</script>