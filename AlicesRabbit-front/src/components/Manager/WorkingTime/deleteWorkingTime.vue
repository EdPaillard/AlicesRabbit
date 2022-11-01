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
          @click="deleteWorkingTime"
      >
        Delete
      </v-btn>
    </v-card-actions>
  </v-form>
</template>

<script>
import axios from "axios";

export default {
  name: "deleteWorkingTime",
  data() {
    return {
      userIDRules: [
        v => !!v || 'ID is required',
        v => (!isNaN(parseFloat(v)) && v >= 0 && v <= 999) || 'Name must be less than 10 characters',
      ],
      valid: true,
      url: process.env.VUE_APP_API_URL + "/workingtimes",
      userId: "",
    }
  },
  methods: {
    deleteWorkingTime(){
      axios
          .delete(this.url+"/"+this.userId)
    }
  }
}
</script>

<style scoped>

</style>