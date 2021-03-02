<template>
  <v-container>
    <v-row>
      <v-col v-for="sale in sales" :key="`${sale.title}`" cols="12" md="4">
        <SalesGraph :sale="sale" />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import SalesGraph from "@/components/SalesGraph";
import salesData from "./data/sales.json";
export default {
  name: "Home",
  components: {
    SalesGraph,
  },
  data() {
    return {
      miniVariant: false,
      sales: salesData,
    };
  },
};
</script>

<style lang="scss" scoped></style>
