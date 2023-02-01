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
        <div class="row">
            <div class="col-xl-12">
                <slot name="footer"></slot>
            </div>
        </div>
      </base-header>
    </div>
</template>
<script>
import StatsCard from '@/components/Cards/StatsCard';
import * as __ from '../../store/constants'

export default {
  components: {
    StatsCard
  },
  data() {
    return {};
  },
  computed: {
    kpi(){
      return this.$store.getters.getKPIs
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
</script>