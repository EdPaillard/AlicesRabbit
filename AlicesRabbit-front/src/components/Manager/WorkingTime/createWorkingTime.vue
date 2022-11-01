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
    <v-dialog
        ref="dialog_date_start"
        v-model="modal_date_start"
        :return-value.sync="date_start"
        persistent
        width="290px"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-text-field
            v-model="date_start"
            label="Date de début"
            prepend-icon="mdi-calendar"
            readonly
            v-bind="attrs"
            v-on="on"
        ></v-text-field>
      </template>
      <v-date-picker
          v-model="date_start"
          scrollable
      >
        <v-spacer></v-spacer>
        <v-btn
            text
            color="primary"
            @click="modal_date_start = false"
        >
          Cancel
        </v-btn>
        <v-btn
            text
            color="primary"
            @click="$refs.dialog_date_start.save(date_start)"
        >
          OK
        </v-btn>
      </v-date-picker>
    </v-dialog>
    <v-dialog
        ref="dialog_time_start"
        v-model="modal_time_start"
        :return-value.sync="time_start"
        persistent
        width="290px"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-text-field
            v-model="time_start"
            label="Heure de début"
            prepend-icon="mdi-clock-outline"
            readonly
            v-bind="attrs"
            v-on="on"
        ></v-text-field>
      </template>
      <v-time-picker
          v-if="modal_time_start"
          v-model="time_start"
          format="24hr"
          full-width
      >
        <v-spacer></v-spacer>
        <v-btn text color="primary" @click="modal_time_start = false">Cancel</v-btn>
        <v-btn text color="primary" @click="$refs.dialog_time_start.save(time_start)">OK</v-btn>
      </v-time-picker>
    </v-dialog>

    <v-dialog
        ref="dialog_date_end"
        v-model="modal_date_end"
        :return-value.sync="date_end"
        persistent
        width="290px"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-text-field
            v-model="date_end"
            label="Date de fin"
            prepend-icon="mdi-calendar"
            readonly
            v-bind="attrs"
            v-on="on"
        ></v-text-field>
      </template>
      <v-date-picker
          v-model="date_end"
          :min="date_start"
          scrollable
      >
        <v-spacer></v-spacer>
        <v-btn
            text
            color="primary"
            @click="modal_date_end = false"
        >
          Cancel
        </v-btn>
        <v-btn
            text
            color="primary"
            @click="$refs.dialog_date_end.save(date_end)"
        >
          OK
        </v-btn>
      </v-date-picker>
    </v-dialog>
    <v-dialog
        ref="dialog_time_end"
        v-model="modal_time_end"
        :return-value.sync="time_end"
        persistent
        width="290px"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-text-field
            v-model="time_end"
            label="Heure de fin"
            prepend-icon="mdi-clock-outline"
            readonly
            v-bind="attrs"
            v-on="on"
        ></v-text-field>
      </template>
      <v-time-picker
          v-if="modal_time_end"
          v-model="time_end"
          :min=time_start
          format="24hr"
          full-width
      >
        <v-spacer></v-spacer>
        <v-btn text color="primary" @click="modal_time_end = false">Cancel</v-btn>
        <v-btn text color="primary" @click="$refs.dialog_time_end.save(time_end)">OK</v-btn>
      </v-time-picker>
    </v-dialog>

    <v-card-actions>
      <v-btn
          :disabled="!valid"
          color="success"
          @click="createWorkingTime"
      >
        Create
      </v-btn>
    </v-card-actions>
  </v-form>
</template>

<script>
import axios from "axios";

export default {
  name: "createWorkingTime",
  data() {
    return {
      userIDRules: [
        v => !!v || 'ID is required',
        v => (!isNaN(parseFloat(v)) && v >= 0 && v <= 999) || 'Name must be less than 10 characters',
      ],
      valid: true,
      url: process.env.VUE_APP_API_URL + "/workingtimes",
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
    createWorkingTime(){
      let final_date_start = this.date_start + " " + this.time_start;
      let final_date_end = this.date_end + " " + this.time_end;

      let body = {
        "start": final_date_start,
        "end": final_date_end
      }
      axios
          .post(this.url+"/"+this.userId, body)
          .then(response => {
            alert("WorkingTime created.")
          })
          .catch(error => {
            alert("An error occurred.")
          })
    },
  }
}
</script>

<style scoped>

</style>