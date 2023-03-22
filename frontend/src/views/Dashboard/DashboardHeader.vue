<template>
    <div>
      <base-header class="pb-6">
        <!-- Card stats -->
        <div class="row">
          <div class="col-xl-12">
            <div class="row">
              <div class="col-md-3">
                <stats-card title="Contratti" type="gradient-danger" :sub-title="kpi.accepted_offers" icon="fa fa-file-contract">
                  <template slot="footer">
                    <span class="text-success mr-2">su {{ kpi.running_offers }} offerte</span>
                  </template>
                </stats-card>
              </div>
              <div class="col-md-3">
                <stats-card title="Progetti" type="gradient-orange" :sub-title="kpi.running_projects" icon="ni ni-building">
                  <template slot="footer">
                    <span class="text-success mr-2">{{ kpi.accepted_offers }} sotto contratto</span>
                  </template>
                </stats-card>
              </div>
              <div class="col-md-3">
                <stats-card title="Kw" type="gradient-purple" :sub-title="kpi.installed_kw" icon="ni ni-sound-wave">
                  <template slot="footer">
                    <span class="text-success mr-2">{{ kpi.total_kw }} sotto contratto</span>
                  </template>
                </stats-card>
              </div>
              <div class="col-md-3">
                <stats-card title="Fatturato" type="gradient-info" :sub-title="kpi.total_invoiced" icon="ni ni-money-coins">
                  <template slot="footer">
                    <span class="text-success mr-2">{{ kpi.total_contracts_value }} in contrattato</span>
                  </template>
                </stats-card>
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
        this.$store.dispatch(__.GET_INSTALLED_KW),
        this.$store.dispatch(__.GET_TOTAL_CONTRACTS_VALUE),
        this.$store.dispatch(__.GET_TOTAL_INVOICED),
      ])
    }
  },
  async mounted() {
    await this.initKPI()
  }
};
</script>
</script>