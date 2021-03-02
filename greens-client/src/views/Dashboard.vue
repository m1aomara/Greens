<template>
  <v-container app>
    <div>
      <AppBar @toMiniVariant="changeMiniVariant" />
      <SideBar :navItems="dashboardNavItems" :miniVariant="miniVariant" />
      <v-main app>
        <router-view></router-view>
      </v-main>
    </div>
    <Footer />
  </v-container>
</template>

<script>
import SideBar from "@/components/SideBar.vue";
import AppBar from "@/components/AppBar.vue";
import Footer from "@/components/Footer.vue";

export default {
  name: "Dashboard",
  methods: {
    changeMiniVariant() {
      this.miniVariant = !this.miniVariant;
    },
  },
  components: {
    SideBar,
    AppBar,
    Footer,
  },
  data() {
    return {
      miniVariant: false,
      dashboardNavItems: [
        {
          title: "Home",
          icon: "fa-home",
          route: { name: "Home" },
        },
        {
          title: "Security Deposit",
          icon: "fa-shield-alt",
          route: { name: "SecurityDeposit" },
        },
        {
          title: "KYC",
          icon: "fa-address-card",
          route: { name: "UserKyc" },
        },
        {
          title: "Billing Status",
          icon: "fas fa-coins",
          route: { name: "BillingStatus" },
        },
        {
          title: "Capacity Request",
          icon: "fa-car-battery",
          route: { name: "CapacityRequest" },
        },
      ],
    };
  },
};
</script>
