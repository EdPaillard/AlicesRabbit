<template>
  <v-container>
    <v-row justify="space-around">
      <v-card width="400" elevation="0">
        <v-tabs>
          <v-tab @click="create = true; deleteWT = false; update = false">Create</v-tab>
          <v-tab @click="update = true; deleteWT = false; create = false">Update</v-tab>
          <v-tab @click="deleteWT = true; update = false; create = false">Delete</v-tab>
        </v-tabs>

        <v-card-text>
          <create-working-time v-if="create"></create-working-time>
          <update-working-time v-if="update"></update-working-time>
          <delete-working-time v-if="deleteWT"></delete-working-time>
        </v-card-text>
      </v-card>
    </v-row>
  </v-container>
</template>

<script>
import axios from "axios";
import CreateWorkingTime from "@/components/Manager/WorkingTime/createWorkingTime";
import DeleteWorkingTime from "@/components/Manager/WorkingTime/deleteWorkingTime";
import UpdateWorkingTime from "@/components/Manager/WorkingTime/updateWorkingTime";

export default {
  name: "WorkingTime",
  components: {UpdateWorkingTime, DeleteWorkingTime, CreateWorkingTime},
  data() {
    return {
      create: true,
      deleteWT: false,
      update: false,
      userIDRules: [
        v => !!v || 'ID is required',
        v => (!isNaN(parseFloat(v)) && v >= 0 && v <= 999) || 'Name must be less than 10 characters',
      ],
      valid: true,
      url: process.env.VUE_APP_API_URL+"/workingtimes",
      userId: "",
      date_start: (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10),
      time_start: null,
      date_end: (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10),
      time_end: null,
      modal_date_start: false,
      modal_date_end: false,
      modal_time_start: false,
      modal_time_end: false,
    }
  },
  methods: {
    saveDate(date){
      this.date_start = date;
      console.log(this.date_start);
    },
    updateWorkingTime(){
      let body = {
        //TODO
      }

      axios
        .put(this.url+"/"+this.userId,body)
        .then(response =>{
          alert("WorkingTime updated.")
        })
        .catch(error => {
          alert("An error occurred.")
        })
    },

    getWorkingTimeOne(){
      axios
        .get(this.url+"/"+this.userId+"/"+this.id)
        .then(response => {
          this.workingtime = response.data.data;
          this.$emit('getWorkingTime', response.data.data);
        })
    }
  }
}
</script>

<style scoped>

</style>