<template>
  <div>
    <v-navigation-drawer
      v-model="drawer"
      color="#5b8c4a"
      :mini-variant="miniVariant"
      app
      fixed
      dark
    >
      <v-img
        src="../assets/bg-energy.png"
        v-if="!miniVariant"
        width="100%"
        gradient="to top right, rgba(100,115,201,.33), rgba(25,32,72,.7)"
      >
        <v-row align="end">
          <v-col align="center">
            <v-avatar color="white" size="100">
              <v-icon size="50" color="black">fa-user-alt</v-icon>
            </v-avatar>
            <p>
              <strong class="nav-img">User Name</strong>
            </p>
          </v-col>
        </v-row>
      </v-img>
      <v-list v-if="miniVariant" nav dense>
        <v-list-item-avatar color="white">
          <v-icon color="black">fa-user-alt</v-icon>
        </v-list-item-avatar>
      </v-list>
      <v-divider></v-divider>

      <v-list nav dense>
        <v-list-item
          v-for="item in navItems"
          :key="item.title"
          link
          :to="item.route"
        >
          <v-list-item-icon>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>{{ item.title }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
  </div>
</template>

<script>
export default {
  name: "SideBar",
  props: {
    navItems: {
      type: Array,
      required: true,
    },
    miniVariant: {
      type: Boolean,
      default: true,
    },
  },
  data() {
    return {
      drawer: true,
    };
  },
};
</script>

<style lang="scss" scoped>
.nav-img {
  color: white;
}
</style>
