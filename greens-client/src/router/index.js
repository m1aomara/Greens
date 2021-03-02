import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    redirect: "/login",
  },
  {
    path: "/login",
    name: "Login",
    component: () => import("@/views/Login.vue"),
  },
  {
    path: "/dashboard",
    name: "Dashboard",
    component: () => import("@/views/Dashboard.vue"),
    redirect: "/dashboard/home",
    children: [
      {
        path: "home",
        name: "Home",
        component: () => import("@/components/Home.vue"),
      },
      {
        path: "securityDeposit",
        name: "SecurityDeposit",
        component: () => import("@/components/SecurityDeposit.vue"),
      },
      {
        path: "userKyc",
        name: "UserKyc",
        component: () => import("@/components/UserKyc.vue"),
      },
      {
        path: "billingStatus",
        name: "BillingStatus",
        component: () => import("@/components/BillingStatus.vue"),
      },
      {
        path: "capacityRequest",
        name: "CapacityRequest",
        component: () => import("@/components/CapacityRequest.vue"),
      }
    ],
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
