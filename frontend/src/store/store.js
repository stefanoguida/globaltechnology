import Vue from 'vue';
import Vuex from 'vuex';
import * as __ from "./constants";
import Services from '../services';

Vue.use(Vuex);

const baseService = new Services.Base()
const userService = new Services.User()

const modelMapping = {
    contratto: "contracts",
    offerta: "offers",
    cliente: "customers",
    progetto: "projects",
    servizio: "services",
    ordine: "orders",
    riga_ordine: "orderRows",
    pagamento_ordine: "orderPayments",
    stato: "status",
}

const state = {
    login: {}, 
    user: { loggedIn: false },
    kpi: {
        running_offers: '',
        accepted_offers: '',
        running_projects: '',
        total_kw: '',
        total_invoiced: ''
    },
    projects_progress: [],
    contracts: {fields:[], records:[]},
    customers: {fields:[], records:[]},
    projects: {fields:[], records:[]},
    services: {fields:[], records:[]},
    contractStatus: {fields:[], records:[]},
    projectStatus: {fields:[], records:[]}
}

const user = JSON.parse(localStorage.getItem('user')) || {}
if( Object.keys(user).length > 0 ) state.user = {...state.user, ...user} 

const getters = {
    getKPIs(state) {
        return state.kpi
    },
    offers(state){
        return state.contracts.records.filter( c => c.stato == 1)
    },
    contracts(state){
        return state.contracts.records.filter( c => c.stato == 2)
    },
    projects(state){
        return state.projects.records
    },
    customers(state){
        return state.customers.records
    },
    customerSelectOptions(state){
        return state.customers.records.map( r => ({text: r.ragione_sociale, value: r.id}) )
    },
    projectSelectOptions(state){
        return state.projects.records.map( r => ({text: r.impianto, value: r.id}) )
    },
    statusSelectOptions(state){
        return state.status.records.map( r => ({text: r.name, value: r.id}) )
    },
    servicesSelectOptions(state){
        return state.services.records.map( r => ({text: r.name, value: r.id}) )
    },
    projectSelectOptions(state){
        return state.projects.records.map( r => ({text: r.impianto, value: r.id}) )
    },
    services(state){
        return state.services.records
    },
}

const actions = {
    async [__.LOGIN]({commit}, user) {
        try {
            const userInfo = await userService.login(user)
            localStorage.setItem('user',JSON.stringify(userInfo.user))
            commit(__.LOGIN, userInfo)
        }
        catch ( error ) {
            const data = {error: true, user: null, message: error}
            commit(__.LOGIN, data);
        }
    },
    
    async [__.LOGOUT]({commit}) {
        await userService.logout();
        commit(__.LOGOUT);
    },
    
    async [__.SIGNUP]({commit}, user) {
        try {
            const response = await userService.register(user)
            commit(__.SIGNUP)
            return response.data
        }
        catch( error ) {
            commit(__.SIGNUP);
            return error
        }
    },

    async [__.GETFLATDATA]({commit}) {
        try {
            const response = await baseService.getFlatData()
            commit(__.GETFLATDATA,response)
        }
        catch ( error ) {

        }
    },

    async [__.GETWHERE]({commit}, {model, cond}) {
        try {
            const response = await baseService.getWhere(model, cond)
            commit(__.GETWHERE,{model, data: response.data})
        }
        catch ( error ) {

        }
    },

    async [__.GETALL]({commit}, model) {
        try {
            const response = await baseService.getAll(model)
            commit(__.GETALL,{model, data: response.data})
        }
        catch ( error ) {

        }
    },

    async [__.GET]({commit}, {model, id}) {
        try {
            const response = await baseService.get(model, id)
            commit(__.GET,{model, data: response.data})
        }
        catch ( error ) {

        }
    },

    async [__.INSERT]({commit}, {model, payload}) {
        try {
            const response = await baseService.insert(model, payload)
            commit(__.INSERT,{model, data: response.data})
            return response
        }
        catch ( error ) {
            return error
        }
    },

    async [__.UPDATE]({commit}, {model, cond, payload}) {
        try {
            const response = await baseService.update(model, cond, payload)
            commit(__.UPDATE,{model, data: response.data})
            return response
        }
        catch ( error ) {
            return error
        }
    },
    
    async [__.DELETE]({commit}, {model, id}) {
        try {
            const response = await baseService.delete(model, id)
            commit(__.DELETE,{model, data: response.data})
            return response
        }
        catch ( error ) {
            return error
        }
    },

    async [__.DELETEFILE]({commit}, id) {
        try {
            const response = await baseService.deleteFile(id)
            commit(__.DELETEFILE,response.data)
            return response
        }
        catch ( error ) {
            return error
        }
    },

    async [__.UPLOAD]({commit}, data) {
        try {
            const response = await baseService.upload(data)
            commit(__.UPLOAD,data)
            return response
        }
        catch ( error ) {
            return error
        }
    },

    async [__.GET_RUNNING_OFFERS]({commit}) {
        try {
            const response = await baseService.getRunnigOffers()
            commit(__.GET_RUNNING_OFFERS,response)
            return response
        }
        catch ( error ) {
            return error
        }
    },

    async [__.GET_ACCEPTED_OFFERS]({commit}) {
        try {
            const response = await baseService.getAcceptedOffers()
            commit(__.GET_ACCEPTED_OFFERS,response)
            return response
        }
        catch ( error ) {
            return error
        }
    },

    async [__.GET_RUNNING_PROJECTS]({commit}) {
        try {
            const response = await baseService.getRunningProjects()
            commit(__.GET_RUNNING_PROJECTS,response)
            return response
        }
        catch ( error ) {
            return error
        }
    },
    
    async [__.GET_TOTAL_KW]({commit}) {
        try {
            const response = await baseService.getTotalKw()
            commit(__.GET_TOTAL_KW,response)
            return response
        }
        catch ( error ) {
            return error
        }
    },

    async [__.GET_TOTAL_INVOICED]({commit}) {
        try {
            const response = await baseService.getTotalInvoiced()
            commit(__.GET_TOTAL_INVOICED,response)
            return response
        }
        catch ( error ) {
            return error
        }
    },

    async [__.GET_PROJECTS_PROGRESS]({commit}) {
        try {
            const response = await baseService.getProjectsProgress()
            commit(__.GET_PROJECTS_PROGRESS,response)
            return response
        }
        catch ( error ) {
            return error
        }
    }
}
const mutations = {
    [__.LOGIN](state, data) {
        state.login.status = data.error ? 'fail' : 'success'
        state.user.loggedIn = !data.error && data.user.token 
        state.login.message = data.message
        state.user = {...state.user, ...data.user}
    },
    [__.LOGOUT](state) {
        state.user = {};
        state.user.loggedIn = false;
    },
    [__.SIGNUP](state) {
        state.user.loggedIn = false;
    },
    [__.GETFLATDATA](state, data){
        state.flatData = {}
        state.flatData.fields = Object.keys(data.data[0])
        state.flatData.records = data.data
    },
    [__.GETALL](state, data){
        state[modelMapping[data.model] || data.model ] = {}
        state[modelMapping[data.model] || data.model ].fields = Object.keys(data.data[0])
        state[modelMapping[data.model] || data.model ].records = data.data
    },
    [__.GETWHERE](state, data) {
        state[modelMapping[data.model] || data.model ] = {}
        state[modelMapping[data.model] || data.model ].fields = Object.keys(data.data[0])
        state[modelMapping[data.model] || data.model ].records = data.data
    },
    [__.GET](state, data) {
        state[modelMapping[data.model] || data.model ] = {}
        state[modelMapping[data.model] || data.model ].fields = Object.keys(data.data[0])
        state[modelMapping[data.model] || data.model ].records = data.data
    },

    [__.UPLOAD](state, data) {},
    [__.INSERT](state, data) {},
    [__.UPDATE](state, data) {},
    [__.DELETE](state, data) {},
    [__.DELETEFILE](state, data){},

    [__.GET_RUNNING_OFFERS](state, data) {
        state.kpi.running_offers = data.toString()
    },
    [__.GET_ACCEPTED_OFFERS](state, data) {
        state.kpi.accepted_offers = data.toString()
    },
    [__.GET_RUNNING_PROJECTS](state, data) {
        state.kpi.running_projects = data.toString()
    },
    [__.GET_TOTAL_KW](state, data) {
        state.kpi.total_kw = new Intl.NumberFormat('it-IT').format(data)
    },
    [__.GET_TOTAL_INVOICED](state, data) {
        state.kpi.total_invoiced = Intl.NumberFormat('it-IT',{style:'currency', currency:'EUR'}).format(data)
    },
    [__.GET_PROJECTS_PROGRESS](state, data) {
        state.projects_progress = data
    },
}

export default new Vuex.Store({
  namespaced: true,
  state,
  getters,
  actions,
  mutations
});