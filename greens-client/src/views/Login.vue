<template>
  <v-app>
    <v-app-bar app color="#5b8c4a" dark>
      <v-toolbar-title class="ml-2 ">GREENS</v-toolbar-title>
      <v-spacer></v-spacer>
    </v-app-bar>
    <v-main>
      <v-card
        class="text-xs-center, mx-auto my-12"
        elevation="12"
        max-width="600"
      >
        <v-card-title class="ma-3 text-xs-center">
          WELCOME TO GREENS
        </v-card-title>

        <v-card-text>
          <v-row align="center" class="mx-0"> </v-row>
        </v-card-text>

        <v-divider class="mx-4"></v-divider>
        <v-card-text>
          <v-form>
            <v-text-field
              prepend-icon="mdi-account-circle"
              placeholder="User Name"
            >
              User Name
            </v-text-field>

            <v-text-field
              prepend-icon="mdi-lock"
              :type="showPassword ? 'text' : 'password'"
              :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
              placeholder="Password"
              @click:append="showPassword = !showPassword"
            >
              Password
            </v-text-field>
          </v-form>
        </v-card-text>
        <v-card-actions align="center">
          <v-btn color="info">Login</v-btn>
        </v-card-actions>
      </v-card>
    </v-main>

    <img width="auto" src="../assets/bg-energy.png" />
  </v-app>
</template>

<script>
export default {
  name: "Login",

  data: () => ({
    showPassword: false,
  }),
};
</script>
