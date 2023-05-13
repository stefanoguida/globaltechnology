<template>
  <div class="content">
    <dashboard-header>
      <template slot="footer">
        <div class="row align-items-center py-4">
          <div class="col-lg-12 col-5 text-right">
            <base-button size="xl" type="neutral" @click="openCreateModal">Nuovo</base-button>
          </div>
        </div>
      </template>
    </dashboard-header>

    <!-- Create modal-->
    <modal :show.sync="modal.show" @close="handleCloseModal" size="lg" body-classes="p-0">
      <card type="secondary" header-classes="bg-transparent pb-5" body-classes="px-lg-5 py-lg-5" class="border-0 mb-0">
        <template>
          <div class="text-muted mb-4">
            <small>Metodi di Pagamento</small>
          </div>
          <form role="form">
            <div v-for="field in modal.fields">
              <base-input v-if="field.type == 'input'" :label="field.label" v-model="modal.data[field.prop]" alternative class="mb-3" :placeholder="field.label" ></base-input>
              <base-input v-else-if="field.type == 'select'" :label="field.label" alternative class="mb-3" :placeholder="field.label" >
                <select class="form-control" v-model="modal.data[field.prop]">
                  <option v-for="option in field.options" :value="option.value">{{ option.text }}</option>
                </select>
              </base-input>
              <base-input v-else-if="field.type == 'date'" type="date" :label="field.label" v-model="modal.data[field.prop]" alternative class="mb-3" :placeholder="field.label" ></base-input>
              <base-input v-else-if="field.type == 'textarea'" :label="field.label" alternative class="mb-3" :placeholder="field.label">
                <textarea v-model="modal.data[field.prop]" class="form-control" rows="3"></textarea>
              </base-input>
              <base-input v-else-if="field.type == 'slider'" :label="field.label" alternative class="mb-3" >
                <base-slider v-model="modal.data[field.prop]" :options="field.options || slider.options"></base-slider>
                <label class="text-xs">Milestone: {{field.milestones}}</label>
              </base-input>
            </div>
            <div class="text-right">
              <base-button type="primary" class="my-4" @click="modal.show = false">Cancel</base-button>
              <base-button type="primary" class="my-4" @click="handleSave">Save</base-button>
            </div>
          </form>
        </template>
      </card>
    </modal>

    <modal :show.sync="preventCloseModal.show" type="notice">
      <template slot="header"> 
        <h2 id="modal-title-notification" class="modal-title">Attenzione</h2>
      </template>
      <template>
        <div class="py-3 text-center">
          <h4 class="heading mt-4">Stai per chiudere la finestra.</h4>
          <p>Continuare?</p>
        </div>
      </template>
      <template slot="footer"> 
        <div class="text-right">
          <base-button type="primary" class="my-4" @click="preventCloseModal.show = modal.show = false">Si</base-button>
          <base-button type="primary" class="my-4" @click="preventCloseModal.show = false">No</base-button>
        </div>
      </template>
    </modal>

    <div class="container-fluid mt--6">
      <div>
        <card class="no-border-card" body-classes="px-0 pb-1" footer-classes="pb-2">
          <template slot="header">
            <h3 class="mb-0">Metodi di Pagamento</h3>
          </template>
          <div>
            <div class="col-12 d-flex justify-content-center justify-content-sm-between flex-wrap">
              <el-select class="select-primary pagination-select" v-model="pagination.perPage" placeholder="Per page" >
                <el-option class="select-primary" v-for="item in pagination.perPageOptions" :key="item" :label="item" :value="item" ></el-option>
              </el-select>

              <div>
                <base-input v-model="searchQuery" prepend-icon="fas fa-search" placeholder="Search..."> </base-input>
              </div>
            </div>
            <el-table 
              :data="queriedData" 
              row-key="id" 
              header-row-class-name="thead-light"
            >
              <!-- All columns -->
              <el-table-column 
              v-for="column in tableColumns" 
              :key="column.label" 
              v-bind="column" 
              :formatter="column.formatter" 
              label-class-name="custom-header-class"
              :min-width="column.minWidth||0"
              ></el-table-column>
              <!-- Action Column -->
              <el-table-column align="right" label="Actions">
                <div slot-scope="{$index, row}" class="d-flex">
                  <base-button @click.native="openUpdateModal($index, row)" class="edit" type="warning" size="sm" icon >
                    <i class="text-white ni ni-ruler-pencil"></i>
                  </base-button>
                  <base-button @click.native="handleDelete($index, row)" class="remove btn-link" type="danger" size="sm" icon>
                    <i class="text-white fa fa-trash"></i>
                  </base-button>
                </div>
              </el-table-column>
            </el-table>
          </div>
          <div slot="footer" class="col-12 d-flex justify-content-center justify-content-sm-between flex-wrap">
            <div class="">
              <p class="card-category">
                Showing {{ from + 1 }} to {{ to }} of {{ total }} entries
                <span v-if="selectedRows.length">
                  &nbsp; &nbsp; {{selectedRows.length}} rows selected
                </span>
              </p>

            </div>
            <base-pagination class="pagination-no-border" v-model="pagination.currentPage" :per-page="pagination.perPage" :total="total"></base-pagination>
          </div>
        </card>
      </div>
    </div>
  </div>
</template>
<script>
import { Table, TableColumn, Select, Option } from 'element-ui';
import RouteBreadCrumb from '@/components/Breadcrumb/RouteBreadcrumb'
import { BasePagination } from '@/components';
import searchTableMixin from '../Tables/PaginatedTables/searchTableMixin'
import swal from 'sweetalert2';
import { Modal } from '@/components';
import DashboardHeader from '../Dashboard/DashboardHeader.vue';

import * as __ from '../../store/constants'

export default {
  mixins: [searchTableMixin],
  components: {
    DashboardHeader,
    Modal,
    BasePagination,
    RouteBreadCrumb,
    [Select.name]: Select,
    [Option.name]: Option,
    [Table.name]: Table,
    [TableColumn.name]: TableColumn
  },
  data() {
    return {
      model: 'metodo_pagamento',
      fields: [],
      propsToSearch: ['name', 'tipo'],
      tableHiddenFields: ['id','trec','created_at','created_by','updated_at','updated_by'],
      tableColumns: [],
      tableData: [],
      selectedRows: [],
      modal: {
        fields:[],
        hiddenFields: ['id','trec','created_at','created_by','updated_at','updated_by'],
        show: false,
        type: '', //insert|update
        title: '',
        data: {}
      },
      preventCloseModal: {
        show: false
      },
      pagination:{
        perPage:25
      },
      serviceTypeSelectOptions: []
    };
  },
  created() {
    this.$watch(
      () => this.$route.params,
      () => { this.fetchData() },
      {immediate: true}
    )
  },
  methods: {
    async fetchData( ) {
      
      await this.$store.dispatch(__.GETALL,this.model)

      this.modal.fields = this.$store.state.paymentMethod.fields
      .filter( f => !this.modal.hiddenFields.includes(f))
      .map( f => {
        switch(f){
          default: 
            return {
              type: 'input',
              prop: f, 
              label: f.replace('_',' '),
            }
        }
      })

      this.tableColumns = this.$store.state.paymentMethod.fields
      .filter( f => !this.tableHiddenFields.includes(f))
      .map( f => {
        switch (f) {
          case 'id':
            return  {
              prop: f, 
              label: f.replace('_',' '),
              minWidth: 20
            }
          case 'name':
            return  {
              prop: f, 
              label: f.replace('_',' '),
              minWidth: 200
            }
          default:
            return {
              prop: f, 
              label: f.replace('_',' ')
            }
            break;
        }
      })
      
      this.tableData = this.$store.state.paymentMethod.records
    },
    openCreateModal(){
      this.modal.type = 'insert'
      this.modal.data = {}
      this.modal.show = true
      this.modal.title = 'Create new payment method'
    },
    openUpdateModal(index, row){
      this.modal.type = 'update'
      this.modal.data = row
      this.modal.condition = [{field: 'id', op: '=', value: row.id}]
      this.modal.show = true
      this.modal.title = 'Update payment method'
    },
    
    async handleCloseModal(){
      this.preventCloseModal.show = true
      this.modal.show = true
    },

    async handleSave () {
      const method = this.modal.type == 'insert' ? __.INSERT : __.UPDATE
      const data = {
        model: this.model, 
        payload: this.modal.data, 
        cond: this.modal.condition || []
      }

      const response = await this.$store.dispatch(method, data)
      if ( response.error ) {
        this.$notify({type:'danger', message:response.message})
        this.modal = { ...this.modal, type: '', title: '', data: {} }
      }
      else {
        this.$notify({type:'success', message: `Payment method successfully saved`})
        await this.fetchData()
        this.modal.show = false
      }
    },

    handleDelete(index, row) {
      swal.fire({
        title: 'Sicuro?',
        text: `Questa azione non può essere annullata!`,
        type: 'warning',
        showCancelButton: true,
        confirmButtonClass: 'btn btn-success btn-fill',
        cancelButtonClass: 'btn btn-danger btn-fill',
        confirmButtonText: 'Si, cancella!',
        cancelButtonText: 'Annulla',
        buttonsStyling: false
      })
      .then(result => {
        if (result.value) {
          this.deleteRow(row);
          swal.fire({
            title: 'Cancellato!',
            text: `Hai cancellato ${row.name}`,
            type: 'success',
            confirmButtonClass: 'btn btn-success btn-fill',
            buttonsStyling: false
          });
        }
      });
    },
    async deleteRow(row) {
      await this.$store.dispatch(__.DELETE,{model:this.model, id:row.id})
      await this.fetchData()
    },
    selectionChange(selectedRows) {
      this.selectedRows = selectedRows
    }
  }
};
</script>
<style>
  .no-border-card .card-footer{
    border-top: 0;
  }
  .cell.custom-header-class {
    word-break: break-word;
  }
</style>
