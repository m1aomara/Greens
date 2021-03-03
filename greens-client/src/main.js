import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import vuetify from "./plugins/vuetify";
import VueSession from "vue-session";

var options = {
  persist: true,
};

Vue.use(VueSession, options);

Vue.config.productionTip = false;

new Vue({
  VueSession,
  router,
  vuetify,
  render: (h) => h(App),
}).$mount("#app");
