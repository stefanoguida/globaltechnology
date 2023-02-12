<template>
  <!-- PDF Modal -->
  <modal :show.sync="show" size="lg" body-classes="p-0">
    <card type="secondary" header-classes="bg-transparent pb-5" body-classes="px-lg-5 py-lg-5" class="border-0 mb-0">
      <template>
        <div class="text-muted mb-4">
          <small>{{title}}</small>
        </div>
        <el-row>
          <el-col v-for="file in data" :span="8">
            <el-card>
              <template slot="header">
                <pdf :src="file.path" :page=1></pdf>
              </template>
              <div>
                {{ file.path.split('/').slice(-1).pop() }}
                <div class="row">
                  <div class="col-12 text-right">
                    <base-button type="primary" size="sm" icon>
                      <a :href="file.path" target="_blank"><i class="text-white fa fa-eye"></i></a>
                    </base-button>
                    <base-button type="danger" @click="handleDeleteFile(file)" size="sm" icon>
                      <i class="text-white fa fa-trash"></i>
                    </base-button>
                  </div>
                </div>
              </div>
            </el-card>
          </el-col>
        </el-row>
        <div class="d-flex" style="margin-top: 10px;">
            <file-input initialLabel="carica file" @change="handleFileChange" class="custom-control-inline"></file-input>
            <base-button type="primary" @click.native="handleSaveFile" :disabled="!newFile.name">
              <i class="fa fa-upload"></i>
            </base-button>
          </div>
      </template>
    </card>
  </modal>
</template>
<script>
  import { Row, Col, Card } from 'element-ui';
  import { Modal } from '@/components';
  import swal from 'sweetalert2';
  import FileInput from '@/components/Inputs/FileInput'
  import pdf from 'vue-pdf'
  import * as __ from '../../store/constants'

  export default {
    name: 'PdfModal',
    components: {
      swal,
      pdf,
      Modal,
      FileInput,
      [Row.name]: Row,
      [Col.name]: Col,
      [Card.name]: Card
    },
    props: {
      show: {
        type: Boolean,
        default: false
      },
      title: {
        type: String,
        default: 'Gestisci file'
      },
      data: {
        type: Array,
        default: []
      },
      id_reference: {
        type: Number,
        default: -1
      }
    },
    watch: {
      show(newVal, oldVal) {
        if (!newVal) {
          this.$emit("update:show", false);
          this.$emit("close");
        }

      }
    },
    data(){
      return {
        newFile: {}
      }
    },
    methods: {
      async handleSaveFile () {

        const data = {
          type:'contratto', 
          id_riferimento: this.id_reference, 
          file: this.newFile 
        }

        const res = await this.$store.dispatch(__.UPLOAD, data)
        if (res.error) {
          swal.fire({
            title: `Attenzione`,
            text: 'Upload fallito',
            buttonsStyling: false,
            customClass: {
              confirmButton: 'btn btn-warning'
            },
            icon: 'warning'
          })
        }
        else {
          swal.fire({
            title: `File caricato`,
            text: 'Il file è stato caricato correttamente!',
            buttonsStyling: false,
            customClass: {
              confirmButton: 'btn btn-success'
            },
            icon: 'success'
          })

          this.$emit("after-save", this.id_reference)
        }
      },

      handleFileChange(files){
        this.newFile = files[0]
      },

      handleDeleteFile( file ){
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
        .then( async result => {
          if (result.value) {
            const res = await this.$store.dispatch(__.DELETEFILE, file.id)
            if (!res.error){
              swal.fire({
                title: 'Cancellato!',
                text: `File cancellato`,
                type: 'success',
                confirmButtonClass: 'btn btn-success btn-fill',
                buttonsStyling: false
              });
            }
            const idx = this.data.findIndex( f => f.id == file.id )
            this.data.splice(idx,1)
          }
        })
        .catch( (error) => {
          swal.fire({
              title: 'Errore!',
              text: `Impossibile cancellare il record`,
              icon: 'error'
            });
        })
      }
    }
  };
</script>
<style>
</style>
