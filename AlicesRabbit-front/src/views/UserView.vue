<template>
  <v-app id="inspire">
    <Sidebar></Sidebar>
    <v-main class="grey lighten-3">
      <v-container>
        <v-row>
          <v-col cols="3">
            <v-sheet rounded="lg">
              <v-list color="transparent">
                <User @getUsers="getUsers"></User>
              </v-list>
            </v-sheet>
          </v-col>
        <v-col
              v-for="user in users">
            <UserCard
                :username="user.username"
                :email="user.email"
                :id="user.id"
            ></UserCard>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import User from '@/components/Manager/User.vue';
import UserCard from "@/components/Cards/UserCard";
import Sidebar from "@/components/Sidebar";
export default {
  name:"UserView",
  components: {
    Sidebar,
    UserCard,
    User
  },
  data: () => ({
    users: []
  }),
  methods: {
    async getUsers(users) {
      this.users = users;
    }
  }
}
</script>