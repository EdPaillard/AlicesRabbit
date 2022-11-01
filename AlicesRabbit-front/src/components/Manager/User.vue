<template>
  <v-container>
    <v-row justify="space-around">
      <v-card width="400" elevation="0">
        <v-tabs>
          <v-tab @click="create = true; deleteUser = false; update = false">Create</v-tab>
          <v-tab @click="update = true; deleteUser = false; create = false">Update</v-tab>
          <v-tab @click="deleteUser = true; update = false; create = false">Delete</v-tab>
          <v-tab @click="getAllUsers">Display All</v-tab>
        </v-tabs>

        <v-card-text>
          <create-user v-if="create"></create-user>
          <update-user v-if="update"></update-user>
          <delete-user v-if="deleteUser"></delete-user>
        </v-card-text>
      </v-card>
    </v-row>
  </v-container>
</template>

<script>
import axios from 'axios';
import CreateUser from "@/components/Manager/User/createUser";
import UpdateUser from "@/components/Manager/User/updateUser";
import DeleteUser from "@/components/Manager/User/deleteUser";

export default {
  name: "User",
  components: {DeleteUser, UpdateUser, CreateUser},
  data() {
    return {
      create: true,
      deleteUser: false,
      update: false,
      url: process.env.VUE_APP_API_URL+"/users",
      users: null
    }
  },
  methods: {
    getAllUsers() {
      axios
          .get(this.url)
          .then(response => {
            this.users = response.data.data;
            this.$emit('getUsers', response.data.data);
          });
    }
  }
}

</script>

<style>
</style>