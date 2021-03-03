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
              v-model="user"
              prepend-icon="mdi-account-circle"
              placeholder="User Name"
            >
              User Name
            </v-text-field>

            <v-text-field
              v-model="pass"
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
          <v-btn @click="login" color="info">Login</v-btn>
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
    user:'demo',
    pass:'demo',
    loading: false,
  }),
  methods: {
    async login() {
      if (this.user === "demo" && this.pass === "demo"){

        await this.$session.start();
        await this.$session.set("customerId", "123456");
        console.log(this.$session.get("customerId"));
        this.$router.push("/dashboard");
      }
      else {
        window.alert("Enter Correct Credentials")
      }
    }
  },
};
</script>
