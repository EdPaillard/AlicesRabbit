<template>
  <v-app id="inspire">
      <v-toolbar  color="secondary" app flat>
        <v-toolbar-title>Alice's Rabbit</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-toolbar-items>
         <v-btn
           v-for="item in nav"
           :key="item.icon"
           :to="item.href"
           :title="item.title"
           plain
         >{{ item.text }}</v-btn>
        </v-toolbar-items>
      </v-toolbar>
  </v-app>
</template>

<script>
export default {
name: "NavBar",

data () {
return {
    nav: [
    {
        icon: 'home',
        text: 'Home',
        title: 'Back to Home page',
        href: '/',
        active: true
    },
    {
        icon: 'info',
        text: 'User',
        title: 'Search User',
        href: "/user",
        active: false
    },
    ]
}
}
}
</script>

<style>
</style>