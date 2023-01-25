import axios from 'axios'

export default class BaseService {
  constructor() {
    
    this.axios = axios
    this.SERVICE_URL = process.env.VUE_APP_API_HOST || 'http://localhost'
    this.headers = {}
  }

  setHeaders () {
    const token = JSON.parse(localStorage.getItem('user')).token || ''
    if( token ) this.headers.Authorization = 'Bearer ' + token 

  }

  async getAll(model) {
    try {
      this.setHeaders()   
      const response = await this.axios.get(`${this.SERVICE_URL}${model}`, {headers: this.headers})
      return response.data
    }
    catch( error ) {
      console.log(error)
      return {}
    }
  }

  async getFlatData() {
    try {
      this.setHeaders()   
      const response = await this.axios.get(`${this.SERVICE_URL}getFlatData`, {headers: this.headers})
      return response.data
    }
    catch( error ) {
      console.log(error)
      return {}
    }
  }

  async getWhere(model, cond = {}) {
    try {
      this.setHeaders()   
      const response = await this.axios.post(`${this.SERVICE_URL}${model}/where`, {condition: cond}, {headers: this.headers})
      return response.data
    }
    catch( error ) {
      console.log(error)
      return {}
    }
  }

  async get(model, id) {
    try {
      this.setHeaders()   
      const response = await this.axios.get(`${this.SERVICE_URL}${model}/${id}`, {headers: this.headers})
      return response.data
    }
    catch( error ) {
      console.log(error)
      return {}
    }
  }

  async insert(model, payload) {
    try {
      this.setHeaders()   
      const response = await this.axios.post(`${this.SERVICE_URL}${model}`, {data: payload}, {headers: this.headers})
      return response.data
    }
    catch( error ) {
      console.log(error)
      return error
    }
  }

  async delete(model, id) {
      this.setHeaders()   
      const response = await this.axios.delete(`${this.SERVICE_URL}${model}/${id}` ,{headers: this.headers})
      return response.data
  }

  async update(model, cond, payload) {
    try {
      this.setHeaders()   
      const response = await this.axios.put(`${this.SERVICE_URL}${model}`, {condition: cond, data: payload}, {headers: this.headers})
      return response.data
    }
    catch( error ) {
      console.log(error)
      return {}
    }
  }

  async getRunnigOffers() {
    try {
      this.setHeaders()   
      const response = await this.axios.get(`${this.SERVICE_URL}getRunnigOffers`, {headers: this.headers})
      return response.data.data.running_offers || 0
    }
    catch( error ) {
      console.log(error)
      return {}
    }
  }

  async getAcceptedOffers() {
    try {
      this.setHeaders()   
      const response = await this.axios.get(`${this.SERVICE_URL}getAcceptedOffers`, {headers: this.headers})
      return response.data.data.accepted_offers
    }
    catch( error ) {
      console.log(error)
      return {}
    }
  }

  async getRunningProjects() {
    try {
      this.setHeaders()   
      const response = await this.axios.get(`${this.SERVICE_URL}getRunningProjects`, {headers: this.headers})
      return response.data.data.running_projects
    }
    catch( error ) {
      console.log(error)
      return {}
    }
  }

  async getTotalKw() {
    try {
      this.setHeaders()   
      const response = await this.axios.get(`${this.SERVICE_URL}getTotalKw`, {headers: this.headers})
      return response.data.data.total_kw
    }
    catch( error ) {
      console.log(error)
      return {}
    }
  }

  async getTotalInvoiced() {
    try {
      this.setHeaders()   
      const response = await this.axios.get(`${this.SERVICE_URL}getTotalInvoiced`, {headers: this.headers})
      return response.data.data.total_invoiced
    }
    catch( error ) {
      console.log(error)
      return {}
    }
  }

  async getProjectsProgress() {
    try {
      this.setHeaders()   
      const response = await this.axios.get(`${this.SERVICE_URL}getProjectsProgress`, {headers: this.headers})
      return response.data.data
    }
    catch( error ) {
      console.log(error)
      return {}
    }
  }

  async upload (data) {
    try {
      this.setHeaders()  
      const formData = new FormData();
      Object.entries(data).forEach( d => formData.append(d[0], d[1]) )
      this.headers['Content-Type'] = 'multipart/form-data'
      const response = await this.axios.post(`${this.SERVICE_URL}uploadFile`, formData, {headers: this.headers})
      return response.data
    }
    catch ( error ) {
      console.log(error)
      return {}
    }
  }

  async deleteFile ( id ) {
    try {
      this.setHeaders()  
      const response = await this.axios.delete(`${this.SERVICE_URL}file/${id}`, {headers: this.headers})
      return response.data
    }
    catch ( error ) {
      console.log(error)
      return {}
    }
  }

  

}
