<template>
  <v-app-bar app color="#5b8c4a" dark>
    <v-app-bar-nav-icon @click="toMiniVariant"></v-app-bar-nav-icon>

    <v-toolbar-title class="ml-2">Greens Project</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-avatar color="blue" size="36">
      <v-icon>mdi-account-circle</v-icon>
    </v-avatar>
    <v-menu offset-y>
      <template v-slot:activator="{ attrs, on }">
        <v-btn dark text small v-on="on" v-bind="attrs">Full Name</v-btn>
      </template>

      <v-list>
        <v-list-item v-for="item in items" :key="item" link>
          <v-list-item-title v-text="item"></v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>
  </v-app-bar>
</template>
<script>
export default {
  methods: {
    toMiniVariant() {
      this.$emit("toMiniVariant");
    },
  },
  data() {
    return {
      items: ["Account Settings", "Log out"],
    };
  },
};
</script>
