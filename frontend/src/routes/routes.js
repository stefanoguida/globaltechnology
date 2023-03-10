import DashboardLayout from '@/views/Layout/DashboardLayout.vue';
import AuthLayout from '@/views/Pages/AuthLayout.vue';
// GeneralViews
import NotFound from '@/views/GeneralViews/NotFoundPage.vue';

// Calendar
const Calendar = () => import(/* webpackChunkName: "extra" */ '@/views/Calendar/Calendar.vue');

// Charts
const Charts = () => import(/* webpackChunkName: "dashboard" */ '@/views/Charts.vue');

// Components pages
const Buttons = () => import(/* webpackChunkName: "components" */ '@/views/Components/Buttons.vue');
const Cards = () => import(/* webpackChunkName: "components" */ '@/views/Components/Cards.vue');
const GridSystem = () => import(/* webpackChunkName: "components" */ '@/views/Components/GridSystem.vue');
const Notifications = () => import(/* webpackChunkName: "components" */ '@/views/Components/Notifications.vue');
const Icons = () => import(/* webpackChunkName: "components" */ '@/views/Components/Icons.vue');
const Typography = () => import(/* webpackChunkName: "components" */ '@/views/Components/Typography.vue');

// Dashboard pages
const Dashboard = () => import(/* webpackChunkName: "dashboard" */ '@/views/Dashboard/Dashboard.vue');
const AlternativeDashboard = () => import(/* webpackChunkName: "dashboard" */ '@/views/Dashboard/AlternativeDashboard.vue');
const Widgets = () => import(/* webpackChunkName: "dashboard" */ '@/views/Widgets.vue');

// Forms pages
const FormElements = () => import(/* webpackChunkName: "forms" */ '@/views/Forms/FormElements.vue');
const FormComponents = () => import(/* webpackChunkName: "forms" */ '@/views/Forms/FormComponents.vue');
const FormValidation = () => import(/* webpackChunkName: "forms" */ '@/views/Forms/FormValidation.vue');

// Maps pages
const GoogleMaps = () => import(/* webpackChunkName: "extra" */ '@/views/Maps/GoogleMaps.vue');
const VectorMaps = () => import(/* webpackChunkName: "extra" */ '@/views/Maps/VectorMaps.vue');

// Pages
const User = () => import(/* webpackChunkName: "pages" */ '@/views/Pages/UserProfile.vue');
const Pricing = () => import(/* webpackChunkName: "pages" */ '@/views/Pages/Pricing.vue');
const TimeLine = () => import(/* webpackChunkName: "pages" */ '@/views/Pages/TimeLinePage.vue');
const Login = () => import(/* webpackChunkName: "pages" */ '@/views/Pages/Login.vue');
const Home = () => import(/* webpackChunkName: "pages" */ '@/views/Pages/Home.vue');
const Register = () => import(/* webpackChunkName: "pages" */ '@/views/Pages/Register.vue');
const Lock = () => import(/* webpackChunkName: "pages" */ '@/views/Pages/Lock.vue');

// TableList pages
const RegularTables = () => import(/* webpackChunkName: "tables" */ '@/views/Tables/RegularTables.vue');
const SortableTables = () => import(/* webpackChunkName: "tables" */ '@/views/Tables/SortableTables.vue');
const PaginatedTables = () => import(/* webpackChunkName: "tables" */ '@/views/Tables/PaginatedTables.vue');

// Global Technology
const Customers = () => import('@/views/Pages/Customers.vue');
const Projects  = () => import('@/views/Pages/Projects.vue');
const Contracts = () => import('@/views/Pages/Contracts.vue');
const Offers = () => import('@/views/Pages/Offers.vue');
const Orders    = () => import('@/views/Pages/Orders.vue');
const OrderRows    = () => import('@/views/Pages/OrderRows.vue');
const Services  = () => import('@/views/Pages/Services.vue');
const ProjectTypes  = () => import('@/views/Pages/ProjectTypes.vue');
const Milestones  = () => import('@/views/Pages/Milestones.vue');
const PaymentMethods  = () => import('@/views/Pages/PaymentMethods.vue');


let componentsMenu = {
  path: '/components',
  component: DashboardLayout,
  redirect: '/components/buttons',
  name: 'Components',
  children: [
    {
      path: 'buttons',
      name: 'Buttons',
      component: Buttons
    },
    {
      path: 'cards',
      name: 'Cards',
      component: Cards
    },
    {
      path: 'grid-system',
      name: 'Grid System',
      component: GridSystem
    },
    {
      path: 'notifications',
      name: 'Notifications',
      component: Notifications
    },
    {
      path: 'icons',
      name: 'Icons',
      component: Icons
    },
    {
      path: 'typography',
      name: 'Typography',
      component: Typography
    }
  ]
};

let formsMenu = {
  path: '/forms',
  component: DashboardLayout,
  redirect: '/forms/elements',
  name: 'Forms',
  children: [
    {
      path: 'elements',
      name: 'Form elements',
      component:  FormElements
    },
    {
      path: 'components',
      name: 'Form components',
      component:  FormComponents
    },
    {
      path: 'validation',
      name: 'Form validation',
      component:  FormValidation
    }
  ]
};

let tablesMenu = {
  path: '/tables',
  component: DashboardLayout,
  redirect: '/table/regular',
  name: 'Tables menu',
  children: [
    {
      path: 'regular',
      name: 'Tables',
      component: RegularTables
    },
    {
      path: 'sortable',
      name: 'Sortable',
      component: SortableTables
    },
    {
      path: 'paginated',
      name: 'Paginated Tables',
      component: PaginatedTables
    }
  ]
};

let mapsMenu = {
  path: '/maps',
  component: DashboardLayout,
  name: 'Maps',
  redirect: '/maps/google',
  children: [
    {
      path: 'google',
      name: 'Google Maps',
      component: GoogleMaps
    },
    {
      path: 'vector',
      name: 'Vector Map',
      component: VectorMaps
    }
  ]
};

let pagesMenu = {
  path: '/pages',
  component: DashboardLayout,
  name: 'Pages',
  redirect: '/pages/user',
  children: [
    {
      path: 'user',
      name: 'User Page',
      component: User
    },
    {
      path: 'timeline',
      name: 'Timeline Page',
      component: TimeLine
    }
  ]
};

let authPages = {
  path: '/',
  component: AuthLayout,
  name: 'Authentication',
  children: [
    {
      path: '/home',
      name: 'Home',
      component: Home,
      meta: {
        noBodyBackground: true
      }
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    },
    {
      path: '/register',
      name: 'Register',
      component: Register
    },
    {
      path: '/pricing',
      name: 'Pricing',
      component: Pricing
    },
    {
      path: '/lock',
      name: 'Lock',
      component: Lock
    },
    { path: '*', component: NotFound }
  ]
};

let DashboardPages = {
  path: '/',
  component: DashboardLayout,
  redirect: '/dashboard',
  children: [
    {
      path: 'alternative',
      name: 'Alternative',
      component: AlternativeDashboard,
      meta: {
        navbarType: 'light'
      }
    },
    {
      path: 'calendar',
      name: 'Calendar',
      component: Calendar
    },
    {
      path: 'charts',
      name: 'Charts',
      component: Charts
    },
    {
      path: 'widgets',
      name: 'Widgets',
      component: Widgets
    },
  ]
}

const GlobalTechPages = {
  path: '/',
  component: DashboardLayout,
  redirect: '/dashboard',
  children: [
    {
      path: 'dashboard',
      name: 'Dashboard',
      component: Dashboard
    },
    {
      path: 'customers',
      name: 'customers',
      component: Customers
    },
    {
      path: 'projects',
      name: 'projects',
      component: Projects
    },
    {
      path: 'offers',
      name: 'offer',
      component: Offers
    },
    {
      path: 'contracts',
      name: 'contracts',
      component: Contracts
    },
    {
      path: 'orders',
      name: 'orders',
      component: Orders
    },
    {
      path: 'orderrows',
      name: 'order-rows',
      component: OrderRows
    },
    {
      path: 'services',
      name: 'services',
      component: Services
    },
    {
      path: 'project-types',
      name: 'project-types',
      component: ProjectTypes
    },
    {
      path: 'milestones',
      name: 'milestones',
      component: Milestones
    },
    {
      path: 'payment-methods',
      name: 'payment-methods',
      component: PaymentMethods
    }
  ]
}

const routes = [
  {
    path: '/',
    redirect: '/dashboard'
  },
  componentsMenu,
  formsMenu,
  tablesMenu,
  mapsMenu,
  pagesMenu,
  DashboardPages,
  GlobalTechPages,
  authPages
];

export default routes;
