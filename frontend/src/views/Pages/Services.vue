<template>
  <div class="content">
    <base-header class="pb-6">
      <div class="row align-items-center py-4">
        <div class="col-lg-6 col-7">
          <!-- <h6 class="h2 text-white d-inline-block mb-0">Paginated tables</h6> -->
          <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
            <route-bread-crumb></route-bread-crumb>
          </nav>
        </div>
        <div class="col-lg-6 col-5 text-right">
          <base-button size="xl" type="neutral" @click="openCreateModal">New</base-button>
        </div>
      </div>
    </base-header>

    <!-- Create modal-->
    <modal :show.sync="modal.show" size="lg" body-classes="p-0">
      <card type="secondary" header-classes="bg-transparent pb-5" body-classes="px-lg-5 py-lg-5" class="border-0 mb-0">
        <template>
          <div class="text-muted mb-4">
            <small>{{modal.title}}</small>
          </div>
          <form role="form">
            <div v-for="field in modal.fields.filter(t=>t.label && t.prop)">
              <base-input :label="field.label"  v-model="modal.data[field.prop]" alternative class="mb-3" :placeholder="field.label" ></base-input>
            </div>
            <div class="text-right">
              <base-button type="primary" class="my-4" @click="modal.show = false">Cancel</base-button>
              <base-button type="primary" class="my-4" @click="handleSaveCustomer">Save</base-button>
            </div>
          </form>
        </template>
      </card>
    </modal>

    <div class="container-fluid mt--6">
      <div>
        <card class="no-border-card" body-classes="px-0 pb-1" footer-classes="pb-2">
          <template slot="header">
            <h3 class="mb-0">Clienti</h3>
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
            <el-table :data="queriedData" row-key="id" header-row-class-name="thead-light" @sort-change="sortChange" @selection-change="selectionChange">
              <el-table-column v-for="column in tableColumns" :key="column.label" v-bind="column"></el-table-column>
              <el-table-column min-width="180px" align="right" label="Actions">
                <div slot-scope="{$index, row}" class="d-flex">
                  <base-button @click.native="openUpdateModal($index, row)" class="edit" type="warning" size="sm" icon >
                    <i class="text-white ni ni-ruler-pencil"></i>
                  </base-button>
                  <base-button @click.native="handleDelete($index, row)" class="remove btn-link" type="danger" size="sm" icon>
                    <i class="text-white ni ni-fat-remove"></i>
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
import clientPaginationMixin from '../Tables/PaginatedTables/clientPaginationMixin'
import swal from 'sweetalert2';
import { Modal } from '@/components';

import * as __ from '../../store/constants'

export default {
  mixins: [clientPaginationMixin],
  components: {
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
      model: 'servizio',
      fields: [],
      propsToSearch: ['ragione_sociale', 'piva'],
      tableHiddenFields: ['trec','created_at','created_by','updated_at','updated_by'],
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
      }
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
      
      console.log(this.$store.state.services)


      this.modal.fields = this.$store.state.services.fields
      .filter( f => !this.modal.hiddenFields.includes(f))
      .map( f => ({prop: f, label: f.replace(/^\w/, c => c.toUpperCase())}))

      this.tableColumns = this.$store.state.services.fields
      .filter( f => !this.tableHiddenFields.includes(f))
      .map( f => ({prop: f, label: f.replace(/^\w/, c => c.toUpperCase())}))
      
      this.tableColumns.unshift({type: 'selection'})
      this.tableData = this.$store.state.services.records
    },
    openCreateModal(){
      this.modal.type = 'insert'
      this.modal.data = {}
      this.modal.show = true
      this.modal.title = 'Create new customer'
    },
    openUpdateModal(index, row){
      console.log(row)
      this.modal.type = 'update'
      this.modal.data = row
      this.modal.condition = [{field: 'id', op: '=', value: row.id}]
      this.modal.show = true
      this.modal.title = 'Update customer'
    },
    async handleSaveCustomer () {
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
        this.$notify({type:'success', message: `Customer successfully saved`})
        await this.fetchData()
        this.modal.show = false
      }
    },
    handleDelete(index, row) {
      swal({
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
          swal({
            title: 'Cancellato!',
            text: `Hai cancellato ${row.name}`,
            type: 'success',
            confirmButtonClass: 'btn btn-success btn-fill',
            buttonsStyling: false
          });
        }
      });
    },
    deleteRow(row) {
      let indexToDelete = this.tableData.findIndex(
        tableRow => tableRow.id === row.id
      );
      if (indexToDelete >= 0) {
        this.tableData.splice(indexToDelete, 1);
      }
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
</style>
