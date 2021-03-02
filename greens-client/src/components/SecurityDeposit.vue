<template>
  <v-container>
    <v-card flat>
      <!-- <v-snackbar v-model="snackbar" absolute top right color="success">
        <span>Deposit Successfull!</span>
        <v-icon dark>
          mdi-checkbox-marked-circle
        </v-icon>
      </v-snackbar> -->
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
        </v-card-actions>
      </v-container>
    </v-card>
  </v-container>
</template>

<script>
// import Web3 from "web3";
// import contractFile from "../contracts/compile";

export default {
  name: "SecurityDeposit",
  data() {
    return {
      depositAmount: "",
      snackbar: false,
      testNetworkUrl: process.env.TEST_NETWORK_URL || "http://localhost:7545",
      privateKey:
        process.env.ACCOUNT_PRIVATE_KEY ||
        "877ba3ef56a5cd2689e6411f2cfac562375b67168906009f796f68df6f6cfafd",
    };
  },
  methods: {
    async deployContract() {
      //   const bytecode = contractFile.evm.bytecode.object;
      //   const abi = contractFile.abi;
      //   const web3 = new Web3(web3.currentProvider);
      //   let address = web3.givenProvider.selectedAddress;
      //   console.log(`Attempting to deploy from account: ${address}`);
      //   let escrowContract = new web3.eth.Contract(abi);
      //   let escrowContractTx = escrowContract.deploy({
      //     data: bytecode,
      //     arguments: [5],
      //   });
      //   let createTransaction = await web3.eth.accounts.signTransaction(
      //     {
      //       from: address,
      //       data: escrowContractTx.encodeABI(),
      //       gas: await escrowContractTx.estimateGas(),
      //     },
      //     this.privateKey
      //   );
      //   let createReceipt = await web3.eth.sendSignedTransaction(
      //     createTransaction.rawTransaction
      //   );
      //   console.log(
      //     `Contract deployed at address ${createReceipt.contractAddress}`
      //   );
    },
    async depositSecurityAmount() {},
  },
};
</script>

<style lang="scss" scoped></style>
