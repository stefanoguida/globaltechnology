<template>
  <div>
    <!-- Header -->
    <div class="header bg-gradient-success py-7 py-lg-8 pt-lg-9">
      <div class="container">
        <div class="header-body text-center mb-7">
          <div class="row justify-content-center">
            <div class="col-xl-5 col-lg-6 col-md-8 px-5">
              <h1 class="text-white">Create an account</h1>
            </div>
          </div>
        </div>
      </div>
      <div class="separator separator-bottom separator-skew zindex-100">
        <svg x="0" y="0" viewBox="0 0 2560 100" preserveAspectRatio="none" version="1.1"
             xmlns="http://www.w3.org/2000/svg">
          <polygon class="fill-default" points="2560 0 2560 100 0 100"></polygon>
        </svg>
      </div>
    </div>
    <!-- Page content -->
    <div class="container mt--8 pb-5">
      <!-- Table -->
      <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
          <div class="card bg-secondary border-0">
            <div class="card-body px-lg-5 py-lg-5">
              <div class="text-center text-muted mb-4">
                <small>Sign up with credentials</small>
              </div>
              <validation-observer v-slot="{handleSubmit}" ref="formValidator">
                <form role="form" @submit.prevent="handleSubmit(onSubmit)">
                  <base-input alternative
                              class="mb-3"
                              prepend-icon="ni ni-hat-3"
                              placeholder="Name"
                              name="Name"
                              :rules="{required: true}"
                              v-model="user.name">
                  </base-input>
                  <base-input alternative
                              class="mb-3"
                              prepend-icon="ni ni-hat-3"
                              placeholder="Surname"
                              name="Surname"
                              :rules="{required: true}"
                              v-model="user.surname">
                  </base-input>

                  <base-input alternative
                              class="mb-3"
                              prepend-icon="ni ni-email-83"
                              placeholder="Email"
                              name="Email"
                              :rules="{required: true, email: true}"
                              v-model="user.email">
                  </base-input>

                  <base-input alternative
                              class="mb-3"
                              prepend-icon="ni ni-lock-circle-open"
                              placeholder="password"
                              type="password"
                              name="Password"
                              :rules="{required: true, min: 6}"
                              v-model="user.password">
                  </base-input>
                  <div class="text-center">
                    <button type="submit" class="btn btn-primary mt-4">Create account</button>
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
    name: 'register',
    data() {
      return {
        user: {}
      }
    },
    methods: {
      async onSubmit() {
        // this will be called only after form is valid. You can do an api call here to register users
        this.loading = true

        if (this.user.email && this.user.password) {
          try {
            await this.$store.dispatch(__.SIGNUP, this.user)
            this.$router.push('dashboard')
          }
          catch( error ) {
            this.loading = false
            this.message = (error.response && error.response.data) || error.message || error.toString();
          }
        }
        this.loading = false
      }
    }

  };
</script>
<style></style>
