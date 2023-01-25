<template>
  <div>
    <base-header class="pb-6">
      <!-- Card stats -->
      <div class="row">
        <div class="col-xl-12">
          <div class="row">
            <div class="col-md-3">
              <stats-card title="Contratti" type="gradient-orange" :sub-title="kpi.accepted_offers" icon="ni ni-chart-pie-35">
                <template slot="footer">
                  <span class="text-success mr-2">su {{ kpi.running_offers }} offerte</span>
                </template>
              </stats-card>
            </div>
            <div class="col-md-3">
              <stats-card title="Progetti" type="gradient-info" :sub-title="kpi.running_projects" icon="ni ni-chart-bar-32"></stats-card>
            </div>
            <div class="col-md-3">
              <stats-card title="Kw" type="gradient-info" :sub-title="kpi.total_kw" icon="ni ni-chart-bar-32"></stats-card>
            </div>
            <div class="col-md-3">
              <stats-card title="Fatturato" type="gradient-info" :sub-title="kpi.total_invoiced" icon="ni ni-chart-bar-32"></stats-card>
            </div>
          </div>
        </div>
      </div>
    </base-header>

    <!--Charts-->
    <div class="container-fluid mt--6">
      <div class="row">
        <div class="col-xl-12">
          <!-- <offers :tableData="offersData" :tableLimit="5"></offers> -->
          <!-- <flat-data :tableData="flatData" :tableLimit="20"></flat-data> -->
        </div>
      </div>
      <!-- End charts-->
    </div>
  </div>
</template>
<script>
  // Charts
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

  import * as __ from '../../store/constants'

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
      FlatData
    },
    data() {
      return {};
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

      async initKPI() {
        await Promise.all([
          this.$store.dispatch(__.GET_RUNNING_OFFERS),
          this.$store.dispatch(__.GET_ACCEPTED_OFFERS),
          this.$store.dispatch(__.GET_RUNNING_PROJECTS),
          this.$store.dispatch(__.GET_TOTAL_KW),
          this.$store.dispatch(__.GET_TOTAL_INVOICED),

          // this.$store.dispatch(__.GETFLATDATA),
        ])
      }
    },
    async mounted() {
      await this.initKPI()
    }
  };
</script>
<style></style>
