<template>
  <div class="wrapper">
    <notifications></notifications>
    <side-bar logo="img/brand/global_tech.png">
      <template slot="links">
        <sidebar-item :link="{ name: 'Dashboard', path: '/dashboard', icon: 'ni ni-shop text-primary', }" ></sidebar-item>
        <sidebar-item :link="{ name: 'Clienti', path: '/customers', icon: 'fa fa-users text-primary' }" ></sidebar-item>
        <sidebar-item :link="{ name: 'Offerte', path: '/offers', icon: 'ni ni-single-copy-04 text-primary' }" ></sidebar-item>
        <sidebar-item :link="{ name: 'Contratti', path: '/contracts', icon: 'fa fa-file-contract text-primary' }" ></sidebar-item>
        <sidebar-item :link="{ name: 'Progetti', path: '/projects', icon: 'ni ni-building text-primary' }" ></sidebar-item>
        <sidebar-item :link="{ name: 'Milestones', path: '/milestones', icon: 'ni ni-atom text-primary' }" ></sidebar-item>
        <sidebar-item :link="{ name: 'Ordini', path: '/orders', icon: 'ni ni-cart text-primary' }" ></sidebar-item>
        <sidebar-item :link="{ name: 'Anagrafiche', icon: 'fa fa-table text-primary'}">
          <sidebar-item :link="{ name: 'Servizi & Forniture', path: '/services', icon: 'ni ni-books text-primary' }" ></sidebar-item>
          <sidebar-item :link="{ name: 'Tipi Progetto', path: '/project-types', icon: 'ni ni-books text-primary' }" ></sidebar-item>
          <sidebar-item :link="{ name: 'Metodi di Pagamento', path: '/payment-methods', icon: 'fa fa-money text-primary' }" ></sidebar-item>
        </sidebar-item>
      </template>
    </side-bar>
    <div class="main-content">
      <dashboard-navbar :type="$route.meta.navbarType"></dashboard-navbar>
      <div @click="$sidebar.displaySidebar(false)">
        <fade-transition :duration="200" origin="center top" mode="out-in">
          <!-- your content here -->
          <router-view></router-view>
        </fade-transition>
      </div>
      <content-footer v-if="!$route.meta.hideFooter"></content-footer>
    </div>
  </div>
</template>
<script>
  /* eslint-disable no-new */
  import PerfectScrollbar from 'perfect-scrollbar';
  import 'perfect-scrollbar/css/perfect-scrollbar.css';

  function hasElement(className) {
    return document.getElementsByClassName(className).length > 0;
  }

  function initScrollbar(className) {
    if (hasElement(className)) {
      new PerfectScrollbar(`.${className}`);
    } else {
      // try to init it later in case this component is loaded async
      setTimeout(() => {
        initScrollbar(className);
      }, 100);
    }
  }

  import DashboardNavbar from './DashboardNavbar.vue';
  import ContentFooter from './ContentFooter.vue';
  import { FadeTransition } from 'vue2-transitions';

  export default {
    components: {
      DashboardNavbar,
      ContentFooter,
      FadeTransition
    },
    methods: {
      initScrollbar() {
        let isWindows = navigator.platform.startsWith('Win');
        if (isWindows) {
          initScrollbar('sidenav');
        }
      }
    },
    mounted() {
      this.initScrollbar()
    }
  };
</script>
<style lang="scss">
</style>
