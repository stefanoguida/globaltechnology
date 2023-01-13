import Vue from 'vue';
import VueRouter from 'vue-router';
import routes from './routes';
import axios from 'axios'

Vue.use(VueRouter);

// configure router
const router = new VueRouter({
  routes, // short for routes: routes
  linkActiveClass: 'active',
  scrollBehavior: (to, from ,savedPosition) => {
    if (savedPosition) {
      return savedPosition;
    }
    if (to.hash) {
      return { selector: to.hash };
    }
    return { x: 0, y: 0 };
  }
});

router.beforeEach( async (to,from,next) => {
  const publicPages = ['/login', '/register', '/lock'];
  const authRequired = !publicPages.includes(to.path);
  const user = JSON.parse(localStorage.getItem('user')) || {};
  const token = user.token || false
  const verification = !token ? {message: 'login'} : (await axios.get('http://localhost/auth/verify-token',{headers: {'authorization': `Bearer ${token}`}})).data
  const expired = verification.expiredAt || false
  const tokenVerified = verification.message === 'verified'
  // trying to access a restricted page + not logged in
  // redirect to login page
  if ( authRequired && (!tokenVerified || expired)) {
    localStorage.removeItem('user')
    next('/login')
  } else {
    verification.message == 'verified' && to.path == '/login' ? next('dashboard') : next()
  }
})

export default router;
