<template>
  <v-card flat>
    <v-snackbar v-model="snackbar" absolute top right color="success">
      <span>Kyc Uploaded Successfully!!</span>
      <v-icon dark>
        mdi-checkbox-marked-circle
      </v-icon>
    </v-snackbar>
    <v-stepper v-model="e1" v-if="!isKycCompleted">
      <v-stepper-header>
        <v-stepper-step :complete="e1 > 1" step="1" editable>
          Personal Details
        </v-stepper-step>

        <v-divider></v-divider>

        <v-stepper-step :complete="e1 > 2" step="2" editable>
          Documents Upload
        </v-stepper-step>

        <v-divider></v-divider>

        <v-stepper-step step="3" editable>
          Review & Submit
        </v-stepper-step>
      </v-stepper-header>

      <v-stepper-items>
        <v-stepper-content step="1">
          <v-card class="mb-12" height="300px">
            <v-form lazy-validation>
              <v-text-field
                v-model="kycForm.name"
                :counter="10"
                :rules="nameRules"
                label="Name"
              ></v-text-field>

              <v-text-field
                v-model="kycForm.email"
                :rules="emailRules"
                label="E-mail"
              ></v-text-field>

              <v-select
                v-model="kycForm.gender"
                :items="['Male', 'Female', 'Transgender']"
                :rules="[(v) => !!v || 'Item is required']"
                label="Gender"
              ></v-select>

              <v-checkbox
                v-model="kycForm.agree"
                :rules="[(v) => !!v || 'You must agree to continue!']"
                label="Do you agree?"
                required
              ></v-checkbox>
            </v-form>
          </v-card>

          <v-btn color="success" class="mr-4" @click="e1 = 2">
            Continue
          </v-btn>

          <v-btn text>
            Reset
          </v-btn>
        </v-stepper-content>

        <v-stepper-content step="2">
          <v-card class="mb-12" height="300px" flat>
            <div class="text-center">
              <v-file-input
                v-model="chosenFile"
                dense
                outlined
                label="File input"
              ></v-file-input>
              <v-btn color="primary" @click="fileUpload"
                >Upload & Preview</v-btn
              >
              <v-img max-height="150" max-width="500" :src="url"></v-img>
            </div>

            <v-dialog
              v-model="loaderDialog"
              hide-overlay
              persistent
              width="300"
            >
              <v-card color="primary" dark>
                <v-card-text>
                  Please stand by
                  <v-progress-linear
                    :value="progress"
                    indeterminate
                    color="white"
                    class="mb-0"
                  ></v-progress-linear>
                </v-card-text>
              </v-card>
            </v-dialog>
            <v-dialog
              v-model="resultDialog"
              hide-overlay
              persistent
              width="500"
            >
              <v-card color="primary" class="text-center" dark>
                {{ this.message }}
                <br />
                <v-btn @click="resultDialog = !resultDialog">Ok</v-btn>
              </v-card>
            </v-dialog>
          </v-card>
          <v-btn color="success" @click="e1 = 3">
            Continue
          </v-btn>
          <v-btn text>
            Cancel
          </v-btn>
        </v-stepper-content>

        <v-stepper-content step="3">
          <v-card class="mb-12" height="300px" flat>
            <div class="text-justify">
              <b>Name: </b>{{ kycForm.name }}<br />
              <b>Email: </b>{{ kycForm.email }}<br />
              <b>Gender: </b>{{ kycForm.gender }}<br />
              <b>Agree to terms: </b>{{ kycForm.agree }}<br />
            </div>
          </v-card>

          <v-btn color="primary" @click="submitKyc">
            Submit
          </v-btn>
        </v-stepper-content>
      </v-stepper-items>
    </v-stepper>
  </v-card>
</template>

<script>
const ipfsClient = require("ipfs-http-client");
const ipfs = ipfsClient(process.env.IPFS_NODE_URL || "http://localhost:5001");

export default {
  name: "UserKyc",
  data() {
    return {
      snackbar: false,
      chosenFile: "",
      progress: 0,
      loaderDialog: false,
      resultDialog: false,
      message: "",
      e1: 1,
      isKycCompleted: false,
      kycForm: {
        name: "",
        email: "",
        address: "",
        phNo: "",
        gender: "",
        agree: "",
      },
      name: "",
      valid: true,
      nameRules: [
        (v) => !!v || "Name is required",
        (v) => (v && v.length <= 10) || "Name must be less than 10 characters",
      ],
      email: "",
      emailRules: [
        (v) => !!v || "E-mail is required",
        (v) => /.+@.+\..+/.test(v) || "E-mail must be valid",
      ],
      checkbox: false,
      url: "",
    };
  },
  methods: {
    async fileUpload() {
      this.progress = 0;
      let file = this.chosenFile;
      let fileSize = file.size;
      try {
        this.loaderDialog = true;
        const result = await ipfs.add(file, {
          progress: (prog) => {
            this.progress = (prog * 100) / fileSize;
            console.log(`received: ${prog}`);
          },
        });
        this.url = `https://ipfs.io/ipfs/${result.path}`;
        this.kycDocumentHash = result.path;
        console.log(this.url);
        this.message = `File Uploaded Successfully \n URL: ${this.url}`;
        this.loaderDialog = false;
        this.resultDialog = true;
      } catch (err) {
        this.message = "Please Upload File";
        console.error(err);
      }
    },
    submitKyc() {
      this.isKycCompleted = true;
      this.snackbar = true;
    },
  },
};
</script>

<style lang="scss" scoped></style>
