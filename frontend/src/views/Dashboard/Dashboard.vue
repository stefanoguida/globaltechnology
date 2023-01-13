<template>
  <div>
    <base-header class="pb-6">
      <!-- Card stats -->
      <div class="row">
        <!-- <div class="col-xl-6">
          <project-progress :tableData="projectProgressData" :tableLimit=5></project-progress>
        </div> -->
        <div class="col-xl-12">
          <div class="row">
            <div class="col-md-2">
              <stats-card title="Offerte in corso" type="gradient-red" :sub-title="kpi.running_offers" icon="ni ni-collection"></stats-card>
            </div>
            <div class="col-md-2">
              <stats-card title="Offerte accettate" type="gradient-orange" :sub-title="kpi.accepted_offers" icon="ni ni-chart-pie-35"></stats-card>
            </div>
          <!-- </div>
          <div class="row"> -->
            <div class="col-md-2">
              <stats-card title="Progetti" type="gradient-info" :sub-title="kpi.running_projects" icon="ni ni-chart-bar-32"></stats-card>
            </div>
            <div class="col-md-2">
              <stats-card title="Kw" type="gradient-info" :sub-title="kpi.total_kw" icon="ni ni-chart-bar-32"></stats-card>
            </div>
          <!-- </div>
          <div class="row"> -->
            <div class="col-md-4">
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
          <flat-data :tableData="flatData" :tableLimit="20"></flat-data>
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
      // projectProgressData() {
      //   return this.$store.state.projects_progress.map( pp => ({...pp, progressType: pp.completamento  >= 66 ? 'success' : pp.completamento >= 33 ? 'warning' : 'danger'}))
      // },
      // contractsData(){
      //   return this.$store.getters.contracts
      // },
      // offersData(){
      //   return this.$store.getters.offers
      // },
      flatData(){
        return this.$store.state.flatData.records
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

          this.$store.dispatch(__.GETFLATDATA),

          // this.$store.dispatch(__.GETALL, 'contratto'),
          // this.$store.dispatch(__.GETALL, 'progetto'),
          // this.$store.dispatch(__.GETALL, 'servizio'),
          // this.$store.dispatch(__.GETALL, 'cliente'),
          // this.$store.dispatch(__.GETALL, 'stato_contratto'),
          // this.$store.dispatch(__.GETALL, 'stato_progetto')
        ])
      },

      async initProjectsProgessChart() {
        await this.$store.dispatch(__.GET_PROJECTS_PROGRESS)
      }
    },
    async mounted() {
      await this.initKPI()
      await this.initProjectsProgessChart()
    }
  };
</script>
<style></style>
