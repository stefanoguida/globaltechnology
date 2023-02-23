<template>
  <div>
    <dashboard-header></dashboard-header>

    <!--Charts-->
    <div class="container-fluid mt--6">
      <div class="row">
        <div class="col-xl-6">
          <card type="default" header-classes="bg-transparent">
            <div slot="header" class="row align-items-center">
              <div class="col">
                <h6 class="text-light text-uppercase ls-1 mb-1">Overview</h6>
                <h5 class="h3 text-white mb-0">Kw/mese ultimi 12 mesi</h5>
              </div>
            </div>
            <line-chart
              :height="350"
              ref="bigChart"
              :chart-data="kwPerMonth.chartData"
              :extra-options="kwPerMonth.extraOptions" 
            >
            </line-chart>
          </card>
        </div>
        <!-- <div class="col-xl-6">
          <card type="default" header-classes="bg-transparent">
            <div slot="header" class="row align-items-center">
              <div class="col">
                <h6 class="text-light text-uppercase ls-1 mb-1">Overview</h6>
                <h5 class="h3 text-white mb-0">Contratti/mese ultimi 12 mesi</h5>
              </div>
            </div>
            <line-chart
              :height="350"
              ref="bigChart"
              :chart-data="contractsPerMonth.chartData"
              :extra-options="contractsPerMonth.extraOptions" 
            >
            </line-chart>
          </card>
        </div> -->
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

  import ProjectProgress from './ProjectsProgress.vue';
  import Offers from './Offers.vue'
  import FlatData from './FlatData.vue'

  import DashboardHeader from './DashboardHeader.vue';
  import * as __ from '../../store/constants'
  import moment from 'moment'

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
      DashboardHeader
    },
    data() {
      return {
        kwPerMonth: {
          chartData: {
            datasets: [{ label: 'Kw', data: [] }],
            labels: [],
          },
          extraOptions: chartConfigs.basicOptions,
        },

        contractsPerMonth: {
          activeIndex: 0,
          chartData: {
            datasets: [
              {
                label: 'Contratti',
                data: [0, 20, 10, 30, 15, 40, 20, 60, 60],
              }
            ],
            labels: ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
          },
          extraOptions: chartConfigs.basicOptions,
        }
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
      }
    },
    async mounted() {
      await this.init()
      this.kwPerMonth.chartData = this.$store.state.kw_per_month.data.reduce( (acc,curr) => {
        acc.datasets[0].data.push(parseFloat(curr.kw))
        acc.labels.push(moment(curr.data_accettazione).locale('it').format('MMM'))
        return acc
      } ,this.kwPerMonth.chartData);
      console.log(this.kwPerMonth.chartData)
    }
  };
</script>
<style></style>
