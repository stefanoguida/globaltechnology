<template>
  <div>
    <!-- Header -->
    <div class="header bg-gradient-success py-7 py-lg-8 pt-lg-9">
      <div class="separator separator-bottom separator-skew zindex-100">
        <svg x="0" y="0" viewBox="0 0 2560 100" preserveAspectRatio="none" version="1.1" xmlns="http://www.w3.org/2000/svg">
          <polygon class="fill-default" points="2560 0 2560 100 0 100"></polygon>
        </svg>
      </div>
    </div>
    <!-- Page content -->
    <div class="container mt--8 pb-5">
      <div class="row justify-content-center">
        <div class="col-lg-5 col-md-7">
          <div class="card bg-secondary border-0 mb-0">
            <div class="card-header">
              <div class="text-muted text-center">
                <img src="img/brand/global_tech.png" style="max-width: 300px;">
                <!-- <span>Sign in with asdas</span> -->
              </div>
            </div>
            <div class="card-body px-lg-5 py-lg-5">
              <validation-observer v-slot="{handleSubmit}" ref="formValidator">
                <form role="form" @submit.prevent="handleSubmit(onSubmit)">
                  <base-input alternative
                              class="mb-3"
                              name="Email"
                              :rules="{required: true, email: true}"
                              prepend-icon="ni ni-email-83"
                              placeholder="Email"
                              v-model="user.email">
                  </base-input>

                  <base-input alternative
                              class="mb-3"
                              name="Password"
                              :rules="{required: true, min: 6}"
                              prepend-icon="ni ni-lock-circle-open"
                              type="password"
                              placeholder="Password"
                              v-model="user.password">
                  </base-input>

                  <div class="text-center">
                    <base-button type="primary" native-type="submit" class="my-4" :disabled="loading">Sign in</base-button>
                  </div>
                </form>
              </validation-observer>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
  import * as __ from '../../store/constants'
  export default {
    data() {
      return {
        user: { name: "", surname: "", email: "", password: "" },
        loading: false
      };
    },
    methods: {
      async onSubmit() {
        this.loading = true;
        if (this.user.email && this.user.password) {
          try {
            await this.$store.dispatch(`${__.LOGIN}`, this.user);
            if( this.$store.state.login.status == 'fail' ) {
              this.message = this.$store.state.login.message
              this.notifyVue('danger')
            }
            else {
              this.$router.push("dashboard");
            }
          }
          catch (error) {
            this.loading = false;
            this.message = (error.response && error.response.data) || error.message || error.toString();
            this.notifyVue('danger')
          }
        }
        this.loading = false;
      },
      notifyVue(type = 'default') {
        this.$notify({
          type,
          message: this.message
        });
      },
    }
};
</script>
