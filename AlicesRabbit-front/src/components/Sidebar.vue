<template>
  <v-container>
    <v-navigation-drawer
        v-model="sidebarMenu"
        app
        :mini-variant.sync="mini"
        color="primary"
    >
      <v-list-item
          class="px-2"
      >
       <v-list-item-avatar>
         <v-icon
           :class="{translatex: toggleMini}">
           mdi-calendar
         </v-icon>
       </v-list-item-avatar>

        <v-list-item-content
            class="text-truncate font-weight-bold"
        >
          Alice's Rabbit
        </v-list-item-content>


        <v-icon>
          mdi-chevron-left
        </v-icon>
      </v-list-item>

      <v-divider></v-divider>
      <v-tabs vertical>
      <v-tab
          v-for="item in items"
          :key="item.name"
          :to="item.link"
      >
        <v-icon
            left
            color="secondary"
            :class="{translatex: toggleMini}"
        >
          {{item.icon}}
        </v-icon>
        {{ item.name }}
      </v-tab>
      </v-tabs>

        <v-list-item
            v-for="item in items"
            :key="item.name"
            :to="item.link"
            link
        >
          <v-list-item-icon>
            <v-icon
                color="secondary"
                :class="{translatex: toggleMini}"
            >
              {{item.icon}}
            </v-icon>
          </v-list-item-icon>
          <transition name="slide-fade">
            <v-list-item-content
              v-show="!toggleMini">
              <v-list-item-title
                class="secondary font-weight-bold">
                {{ item.name }}
              </v-list-item-title>
            </v-list-item-content>
          </transition>
        </v-list-item>
    </v-navigation-drawer>
  </v-container>
</template>

<script>
export default {
  name: "Sidebar",
  data: () => ({
    cards: ['Today', 'Yesterday'],
    sidebarMenu: true,
    toggleMini: false,
    items: [
      { name: 'User', link: "/", icon: "mdi-account-outline"},
      { name: 'Workingtime', link: "/workingtimes", icon: "mdi-calendar-clock"},
      { name: 'ClockManager', link: "/ClockManager", icon: "mdi-clock-time-nine-outline"},
    ],
  })
}
</script>

<style>

</style>