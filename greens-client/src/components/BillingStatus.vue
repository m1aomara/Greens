<template>
<v-container>
  <v-row>
    <v-col align="center">
      <h1>Provnance Data</h1>
    </v-col>
  </v-row>
  <v-divider ></v-divider>
  <br>
  <v-row justify="center">
    <v-dialog
        v-model="dialog"
        persistent
        max-width="600px"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-btn
            color="#32a852"
            dark
            v-bind="attrs"
            v-on="on"
        >
          Get Data
        </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="headline">Bill Details</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-text-field
                    label="Total Units"
                    disabled
                ></v-text-field>
              </v-col>
              <v-col cols="12">
                <v-text-field
                    label="Meter Reading"
                    disabled
                ></v-text-field>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
              color="blue darken-1"
              text
              @click="dialog = false"
          >
            Close
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</v-container>
</template>

<script>
export default {
  name: "BillingStatus",
  data: () => ({
    dialog: false,
  }),

}
</script>

<style scoped>

</style>