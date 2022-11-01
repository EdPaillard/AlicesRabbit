<template>
  <v-form
      ref="form"
      v-model="valid"
      lazy-validation
  >
    <v-text-field
        v-model="userId"
        label="User ID"
        required
    ></v-text-field>
    <v-card-actions>
      <v-btn
          :disabled="!valid"
          color="error"
          @click="deleteUser"
      >
        delete
      </v-btn>
    </v-card-actions>
  </v-form>
</template>

<script>
import axios from "axios";

export default {
  name: "deleteUser",
  data() {
    return {
      valid: true,
      userId: '',
      url: process.env.VUE_APP_API_URL+"/users",
    }
  },
  methods: {
    deleteUser() {
      if (this.userId !== '' && this.userId != undefined && this.userId != null) {
        const url_delete = this.url + "/" + this.userId;
        axios
            .delete(url_delete)
            .then(response => {
              alert("User with id : " + this.userId + " has been successfully deleted.")
            })
            .catch(error => {
              alert("An error occurred: User not found, please verify your id.")
            });
      }
    }
  }
}
</script>

<style scoped>

</style>