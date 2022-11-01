<template>
  <v-app id="app">
    <v-main class="grey lighten-3">
      <v-app-bar>
        <v-container>
          <v-tabs>
            <v-tab @click="user = true; workingtime = false; clockmanager = false;"> User </v-tab>
            <v-tab @click="workingtime = true; user = false; clockmanager = false"> WorkingTime </v-tab>
            <v-tab @click="clockmanager = true; workingtime = false; user = false"> ClockManager </v-tab>
          </v-tabs>
        </v-container>
      </v-app-bar>

      <v-content>
        <v-container v-if="user">
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

        <v-container v-if="workingtime">
          <v-row>
            <v-col cols="3">
              <v-sheet rounded="lg">
                <v-list color="transparent">
                  <working-times></working-times>
                </v-list>
              </v-sheet>
            </v-col>
          </v-row>
        </v-container>
      </v-content>

    </v-main>
  </v-app>
</template>

<script>
import Sidebar from "@/components/Sidebar";
import User from "@/components/Manager/User";
import UserCard from "@/components/Cards/UserCard";
import WorkingTime from "@/components/Manager/WorkingTime";
import WorkingTimes from "@/components/Manager/WorkingTimes";

export default {
  name: "App",
  data: () => ({
    user: true,
    users: [],
    workingtime: false,
    clockmanager: false,
    items: [
      { name: 'User', link: "/", icon: "mdi-account-outline"},
      { name: 'Workingtime', link: "/workingtimes", icon: "mdi-calendar-clock"},
      { name: 'ClockManager', link: "/ClockManager", icon: "mdi-clock-time-nine-outline"},
    ],
  }),
  components: {
    WorkingTimes,
    WorkingTime,
    User, Sidebar, UserCard
  },
  methods: {
    async getUsers(users) {
      this.users = users;
    }
  }

};
</script>
