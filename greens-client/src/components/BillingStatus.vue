<template>
  <v-container>
    <v-row>
      <v-col align="center">
        <h1>Provenance Data</h1>
      </v-col>
    </v-row>
    <v-divider></v-divider>
    <br />
    <v-row justify="center">
      <v-dialog v-model="dialog" persistent max-width="600px">
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            color="#32a852"
            dark
            v-bind="attrs"
            v-on="on"
            @click="updateOracle"
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
                    :value="totalUnits"
                    disabled
                  ></v-text-field>
                </v-col>
                <v-col cols="12">
                  <v-text-field
                    label="Last Meter Reading"
                    :value="lastMeterReading"
                    disabled
                  ></v-text-field>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="blue darken-1" text @click="dialog = false">
              Close
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-row>
  </v-container>
</template>

<script>
import Web3 from "web3";
const testNetworkUrl = process.env.TEST_NETWORK_URL || "http://127.0.0.1:7545";

export default {
  name: "BillingStatus",
  data: () => ({
    dialog: false,
    abi: [
      {
        inputs: [],
        stateMutability: "nonpayable",
        type: "constructor",
      },
      {
        inputs: [
          {
            internalType: "uint256",
            name: "customerId",
            type: "uint256",
          },
        ],
        name: "getLastMeterRead",
        outputs: [
          {
            internalType: "uint256",
            name: "",
            type: "uint256",
          },
        ],
        stateMutability: "view",
        type: "function",
      },
      {
        inputs: [
          {
            internalType: "uint256",
            name: "customerId",
            type: "uint256",
          },
        ],
        name: "getSerialNumber",
        outputs: [
          {
            internalType: "uint256",
            name: "",
            type: "uint256",
          },
        ],
        stateMutability: "view",
        type: "function",
      },
      {
        inputs: [
          {
            internalType: "uint256",
            name: "customerId",
            type: "uint256",
          },
        ],
        name: "getTotalUnits",
        outputs: [
          {
            internalType: "uint256",
            name: "",
            type: "uint256",
          },
        ],
        stateMutability: "view",
        type: "function",
      },
      {
        inputs: [
          {
            internalType: "uint256",
            name: "customerId",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "serialNumber",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "totalUnits",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "lastMeterRead",
            type: "uint256",
          },
        ],
        name: "setMeterReading",
        outputs: [],
        stateMutability: "nonpayable",
        type: "function",
      },
    ],
    lastMeterReading: "",
    totalUnits: "",
  }),
  methods: {
    async updateOracle() {
      let provider = new Web3(new Web3.providers.HttpProvider(testNetworkUrl));
      let ownerAddress = "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4";
      // await provider.eth.getAccounts((error, result) => {
      //   ownerAddress = result[0];
      //   console.log("Address", ownerAddress);
      // });
      //From Remix
      let contractAddress = "0xd9145CCE52D386f254917e481eB44e9943F39138"
      let contractInstance = new provider.eth.Contract(
        this.abi,
        contractAddress
      );
      console.log("Contract instance", contractInstance);

      let result = await fetch("http://192.168.0.101:3001");
      let json = await result.json();
      console.log(`Price: ${json.serialNumber}`);
      console.log(`Total Units: ${json.totalUnits}`);
      console.log(`Last Meter Reading: ${json.lastMeterRead}`);

      //Call the contract to set a meter reading data
      await contractInstance.methods
        .setMeterReading(
          parseInt(this.$session.get("customerId")),
          parseInt(json.serialNumber),
          parseInt(json.totalUnits),
          parseInt(json.lastMeterRead)
        )
        .send({ from: ownerAddress })
        .on("receipt", () => {
          console.log("Values Updated");
        });

      //Call the contract to get the the meter readings
      await contractInstance.methods
        .getLastMeterRead(parseInt(json.customerId))
        .send({ from: ownerAddress })
        .then((val) => {
          this.lastMeterReading = val;
          console.log("Last Meter Read: ", val);
        });

      //Call the contract to get the stock volume
      await contractInstance.methods
        .getTotalUnits(parseInt(json.customerId))
        .send({ from: ownerAddress })
        .then((val) => {
          this.totalUnits = val;
          console.log("Total Units: ", val);
        });
    },
  },
};
</script>

<style scoped></style>
