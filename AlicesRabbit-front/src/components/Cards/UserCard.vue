<template>
  <v-container>
    <v-row justify="space-around">

      <v-card class="mx-auto"
              min-width="300"
              max-width="400"
              elevation="0"
              hover>
        <v-img
            src="https://images.assetsdelivery.com/compings_v2/2nix/2nix1408/2nix140800148.jpg"
            heigth="350"
        ></v-img>


        <v-card-title>
          {{ id }} - {{ username }}
        </v-card-title>

        <v-card-subtitle>
          {{ email }}
        </v-card-subtitle>
      </v-card>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: "UserCard",
  props: [ 'username', 'email', 'id'],
  data () {
    return {
      initial: ''
    }
  },
  beforeMount() {
    this.initial = this.username.substring(0,2).toUpperCase();
  }
}
</script>

<style scoped>

</style>