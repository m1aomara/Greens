<template>
  <v-container>
    <v-card flat>
      <v-row>Current Deposit Amount: {{ this.depositedAmount }}</v-row>
      <v-snackbar v-model="snackbar" absolute top right color="success">
        <span>{{ this.message }}</span>
        <v-icon dark>
          mdi-checkbox-marked-circle
        </v-icon>
      </v-snackbar>
      <v-container fluid>
        <v-col cols="12" sm="6">
          <v-text-field
            v-model="depositAmount"
            color="purple darken-2"
            label="Amount"
            outlined
          ></v-text-field>
        </v-col>
        <v-card-actions>
          <v-btn color="primary" type="submit" @click="depositSecurityAmount">
            Deposit Amount
          </v-btn>
          <v-btn color="warning" type="submit" @click="refund">
            Refund All Amount
          </v-btn>
          
        </v-card-actions>

      </v-container>
    </v-card>
  </v-container>
</template>

<script>
import Web3 from "web3";
const testNetworkUrl = process.env.TEST_NETWORK_URL || "http://127.0.0.1:7545";
let provider = new Web3(new Web3.providers.HttpProvider(testNetworkUrl));

export default {
  name: "SecurityDeposit",
  energyUtilityAddress:
    process.env.UTILITY_COMPANY_ADDRESS ||
    "0x15D426f65bC50C71f3B2Bf131BAeC22293FD2938",
  data() {
    return {
      message: "",
      depositedAmount: "",
      depositAmount: "",
      snackbar: false,
      testNetworkUrl: process.env.TEST_NETWORK_URL || "http://localhost:7545",
      privateKey:
        process.env.ACCOUNT_PRIVATE_KEY ||
        "877ba3ef56a5cd2689e6411f2cfac562375b67168906009f796f68df6f6cfafd",
      ethAdresses: "",
      abi: [
        {
          inputs: [],
          name: "beneficiaryWithdraw",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [],
          name: "close",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [],
          name: "closed",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "address payable",
              name: "_energyUtility",
              type: "address",
            },
          ],
          stateMutability: "nonpayable",
          type: "constructor",
        },
        {
          anonymous: false,
          inputs: [
            {
              indexed: false,
              internalType: "address",
              name: "energyUtility",
              type: "address",
            },
            {
              indexed: false,
              internalType: "string",
              name: "msg",
              type: "string",
            },
            {
              indexed: false,
              internalType: "uint256",
              name: "depositAmt",
              type: "uint256",
            },
          ],
          name: "ConsumerDepositAmount",
          type: "event",
        },
        {
          inputs: [
            { internalType: "address", name: "_consumer", type: "address" },
            { internalType: "uint256", name: "_depositAmt", type: "uint256" },
          ],
          name: "deposit",
          outputs: [],
          stateMutability: "payable",
          type: "function",
        },
        {
          inputs: [
            { internalType: "address", name: "refundee", type: "address" },
          ],
          name: "deposit",
          outputs: [],
          stateMutability: "payable",
          type: "function",
        },
        {
          anonymous: false,
          inputs: [
            {
              indexed: true,
              internalType: "address",
              name: "payee",
              type: "address",
            },
            {
              indexed: false,
              internalType: "uint256",
              name: "weiAmount",
              type: "uint256",
            },
          ],
          name: "Deposited",
          type: "event",
        },
        {
          inputs: [],
          name: "enableRefunds",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          anonymous: false,
          inputs: [
            {
              indexed: true,
              internalType: "address",
              name: "previousOwner",
              type: "address",
            },
            {
              indexed: true,
              internalType: "address",
              name: "newOwner",
              type: "address",
            },
          ],
          name: "OwnershipTransferred",
          type: "event",
        },
        {
          anonymous: false,
          inputs: [
            {
              indexed: false,
              internalType: "address",
              name: "energyUtility",
              type: "address",
            },
            {
              indexed: false,
              internalType: "address",
              name: "consumer",
              type: "address",
            },
            {
              indexed: false,
              internalType: "uint256",
              name: "depositAmt",
              type: "uint256",
            },
          ],
          name: "RefundAction",
          type: "event",
        },
        { anonymous: false, inputs: [], name: "RefundsClosed", type: "event" },
        { anonymous: false, inputs: [], name: "RefundsEnabled", type: "event" },
        {
          inputs: [],
          name: "renounceOwnership",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "address payable",
              name: "_consumer",
              type: "address",
            },
          ],
          name: "returnOfDeposit",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "address payable",
              name: "_consumer",
              type: "address",
            },
          ],
          name: "setConsumer",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "address payable",
              name: "_energyUtility",
              type: "address",
            },
          ],
          name: "setEnergyUtility",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [
            { internalType: "address", name: "newOwner", type: "address" },
          ],
          name: "transferOwnership",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [
            { internalType: "address payable", name: "payee", type: "address" },
          ],
          name: "withdraw",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          anonymous: false,
          inputs: [
            {
              indexed: true,
              internalType: "address",
              name: "payee",
              type: "address",
            },
            {
              indexed: false,
              internalType: "uint256",
              name: "weiAmount",
              type: "uint256",
            },
          ],
          name: "Withdrawn",
          type: "event",
        },
        { stateMutability: "payable", type: "fallback" },
        { stateMutability: "payable", type: "receive" },
        {
          inputs: [],
          name: "approveReturn",
          outputs: [],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [{ internalType: "address", name: "", type: "address" }],
          name: "balances",
          outputs: [{ internalType: "uint256", name: "", type: "uint256" }],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [],
          name: "beneficiary",
          outputs: [
            { internalType: "address payable", name: "", type: "address" },
          ],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [],
          name: "consumer",
          outputs: [
            { internalType: "address payable", name: "", type: "address" },
          ],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [],
          name: "depositAmt",
          outputs: [{ internalType: "uint256", name: "", type: "uint256" }],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [{ internalType: "address", name: "payee", type: "address" }],
          name: "depositsOf",
          outputs: [{ internalType: "uint256", name: "", type: "uint256" }],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [],
          name: "energyUtility",
          outputs: [
            { internalType: "address payable", name: "", type: "address" },
          ],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [],
          name: "owner",
          outputs: [{ internalType: "address", name: "", type: "address" }],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [],
          name: "state",
          outputs: [
            {
              internalType: "enum RefundEscrow.State",
              name: "",
              type: "uint8",
            },
          ],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [{ internalType: "address", name: "", type: "address" }],
          name: "withdrawalAllowed",
          outputs: [{ internalType: "bool", name: "", type: "bool" }],
          stateMutability: "view",
          type: "function",
        },
      ],
    };
  },
  methods: {
    async refund() {
      await provider.eth.getAccounts((error, result) => {
        this.ethAdresses = result;
        console.log("Address", result);
      });
      let ownerAddress = this.ethAdresses[0];
      console.log(this.ethAdresses);
      try {
        let contractInstance = new provider.eth.Contract(
          this.abi,
          ownerAddress
        );
        await contractInstance.methods
          .returnOfDeposit(ownerAddress)
          .send({ from: ownerAddress })
          .on("receipt", () => {
            this.message = "Refund Successfull!";
            this.depositedAmount=0,
            this.snackbar = true;
            console.log("Refund Successfull");
          });
      } catch (err) {
        console.log(err);
      }
    },

    async depositSecurityAmount() {
      await provider.eth.getAccounts((error, result) => {
        this.ethAdresses = result;
        console.log("Address", result);
      });
      let ownerAddress = this.ethAdresses[0];
      console.log(this.ethAdresses);
      try {
        let contractInstance = new provider.eth.Contract(
          this.abi,
          ownerAddress
        );
        console.log("Contract instance", contractInstance);

        await contractInstance.methods
          .setConsumer(ownerAddress)
          .send({ from: ownerAddress })
          .on("receipt", () => {
            console.log("Consumer Updated to contract");
          });

        // Call the contract to get the the meter readings
        await contractInstance.methods
          .deposit(ownerAddress, this.depositAmount)
          .send({ from: ownerAddress })
          .on("receipt", () => {
            console.log("Amount Deposited");
            this.depositedAmount = this.depositAmount;
            this.message = "Deposit Successfull!";
            this.snackbar = true;
          });
      } catch (err) {
        console.log(err);
      }
    },
  },
};
</script>

<style lang="scss" scoped></style>
