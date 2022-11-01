<template>
  <v-form
      ref="form"
      v-model="valid"
      lazy-validation
  >
    <v-text-field
        v-model="id"
        label="User ID"
        required
    ></v-text-field>
    <v-text-field
        v-model="name"
        :counter="10"
        :rules="nameRules"
        label="Name"
        required
    ></v-text-field>
    <v-text-field
        v-model="email"
        :rules="emailRules"
        label="E-mail"
        required
    ></v-text-field>
    <v-card-actions>
      <v-btn
          :disabled="!valid"
          color="success"
          @click="createUser"
      >
        Create
      </v-btn>
    </v-card-actions>
  </v-form>
</template>

<script>
import axios from "axios";

export default {
  name: "createUser",
  data() {
    return {
      valid: true,
      id: '',
      name: '',
      nameRules: [
        v => !!v || 'Name is required',
        v => (v && v.length <= 10) || 'Name must be less than 10 characters',
      ],
      email: '',
      emailRules: [
        v => !!v || 'E-mail is required',
        v => /.+@.+\..+/.test(v) || 'E-mail must be valid',
      ],
      url: process.env.VUE_APP_API_URL+"/users",
    }
  },
  methods: {
    createUser() {
      let body = {
        "username": this.name,
        "email": this.email
      };

      axios
          .post(this.url, body)
          .then(response => {
            alert("User : " + response.data.data.username + " has been created.")
          })
          .catch(error => {
            alert("An error occurred.")
          });
    }
  }
}
</script>

<style scoped>

</style>