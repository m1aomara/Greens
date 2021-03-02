Oracle
+++++++

.. image:: ./images/oracle-1.png

SpringBoot Mongo Rest
=====================

MongoDB collection diagram

.. image:: ./images/oracle-box-diagram-1.png

Run MongoDB container:

.. code-block:: bash

    docker run -d -p 27017:27017  --name mongodbProject   mongo  --bind_ip=0.0.0.0


Connect to MongoDB shell:


.. code-block:: bash

    docker exec -it mongodbProject bash



Then run:


.. code-block:: bash

    mongo
    use Tracker

.. code-block:: bash


    db.energyTracker.insert(
      { "customerId": "0001",
      "serialNumber": "325235234",
      "mpxn": "79898654",
      "totalUnits": "500",
      "lastMeterRead": "01-03-2021"
    })


.. code-block:: bash


    db.energyTracker.insert(
      { "customerId": "0002",
      "serialNumber": "5235232523",
      "mpxn": "798468949",
      "totalUnits": "500",
      "lastMeterRead": "03-03-2021"
       })

.. code-block:: bash


   db.energyTracker.insert(
      { "customerId": "0003",
      "serialNumber": "534532452",
      "mpxn": "798416598",
      "totalUnits": "500",
      "lastMeterRead": "02-03-2021"
       })



Go to https://start.spring.io and the following dependencies and create the project.

.. image:: images/mongo1.png


- Download the ZIP file and extract it, open the extracted directory in IntelliJ IDEA.

- Create the directory structure as shown below:

.. image:: images/mongo2.png

Add the following code in EnergyTracker.java:


.. code-block:: java

    package com.example.OracleMongo.model;

    import org.springframework.data.annotation.Id;
    import org.springframework.data.mongodb.core.mapping.Document;

    import java.util.Date;

    @Document(collection = "customers")
    public class EnergyTracker {

        @Id
        private String customerId;

        private Integer serialNumber;
        private Integer mpxn;
        private Integer totalUnits;
        private String lastMeterRead;

        public String getCustomerId() {
            return customerId;
        }

        @Override
        public String toString() {
            return "EnergyTracker{" +
                    "customerId='" + customerId + '\'' +
                    ", serialNumber=" + serialNumber +
                    ", mpxn=" + mpxn +
                    ", totalUnits=" + totalUnits +
                    ", lastMeterRead=" + lastMeterRead +
                    '}';
        }

        public void setCustomerId(String customerId) {
            this.customerId = customerId;
        }

        public Integer getSerialNumber() {
            return serialNumber;
        }

        public void setSerialNumber(Integer serialNumber) {
            this.serialNumber = serialNumber;
        }

        public Integer getMpxn() {
            return mpxn;
        }

        public void setMpxn(Integer mpxn) {
            this.mpxn = mpxn;
        }

        public Integer getTotalUnits() {
            return totalUnits;
        }

        public void setTotalUnits(Integer totalUnits) {
            this.totalUnits = totalUnits;
        }

        public String getLastMeterRead() {
            return lastMeterRead;
        }

        public void setLastMeterRead(String lastMeterRead) {
            this.lastMeterRead = lastMeterRead;
        }

    }

Add the following code in TrackerRepository.java:


.. code-block:: java


    @RepositoryRestResource(collectionResourceRel = "Tracker", path = "Tracker")
    public interface TrackerRepository extends MongoRepository<EnergyTracker, String> {

        List<EnergyTracker> findAll();

    }



Add the following code in application.properties:


.. code-block:: bash

    server.port=8089

    spring.data.mongodb.host=0.0.0.0
    spring.data.mongodb.port=27017
    spring.data.mongodb.database=Tracker





Then run the Spring app:

.. image:: images/mongo3.png



The app will run as shown:

.. image:: images/mongo4.png



Go to http://localhost:8089/Tracker to GET the request:

.. image:: images/mongo5.png


Oracle Smart Contract
=====================

.. code-block:: javascript

    // SPDX-License-Identifier: MIT
    pragma solidity >=0.4.22 <0.7.0;

    contract EnergyMeterOracle {
    	address owner;
    	constructor() public {
    		owner = msg.sender;
    	}
    	// quote structure
    	struct energyMeterReadings {
    		uint serialNumber;
    		uint totalUnits;
    		uint256 lastMeterRead;
    	}

    	mapping( uint => energyMeterReadings) meterReading;

    	// address oracleOwner;
    	modifier onlyOwner {
    		require(
    			msg.sender == owner,
    			"Only owner can call this function."
    		);
    		_;
    	}

    	// Set the meter Reading
    	function setMeterReading(uint customerId, uint serialNumber, uint totalUnits, uint256 lastMeterRead) onlyOwner public {
    		energyMeterReadings memory _MeterReading = energyMeterReadings({serialNumber: serialNumber, totalUnits:totalUnits, lastMeterRead:lastMeterRead });
    		meterReading[customerId] = _MeterReading;
    	}

    	// Get the serialNumber for customerId
    	function getSerialNumber(uint customerId) public view returns (uint) {
    		return meterReading[customerId].serialNumber;
    	}
    
    		// Get the totalUnits value for customerId
    	function getTotalUnits(uint customerId) public view returns (uint) {
    		return meterReading[customerId].totalUnits;
    	}
    
    			// Get the lastMeterRead value for customerId
    	function getLastMeterRead(uint customerId) public view returns (uint) {
    		return meterReading[customerId].lastMeterRead;
    	}
    }

Backend Express service
=======================

app.js

.. code:: javascript

    var createError = require('http-errors');
    var express = require('express');
    var path = require('path');
    var cookieParser = require('cookie-parser');
    var logger = require('morgan');
    var cors = require('cors');
    var indexRouter = require('./routes');
    var customersRouter = require('./routes/customers');

    var app = express();

    app.use(cors());

    // view engine setup
    app.set('views', path.join(__dirname, 'views'));
    app.set('view engine', 'jade');

    app.use(logger('dev'));
    app.use(express.json());
    app.use(express.urlencoded({ extended: false }));
    app.use(cookieParser());
    app.use(express.static(path.join(__dirname, 'public')));

    app.use('/', indexRouter);
    app.use('/customers', customersRouter);

    // catch 404 and forward to error handler
    app.use(function(req, res, next) {
      next(createError(404));
    });

    // error handler
    app.use(function(err, req, res, next) {
      // set locals, only providing error in development
      res.locals.message = err.message;
      res.locals.error = req.app.get('env') === 'development' ? err : {};

      // render the error page
      res.status(err.status || 500);
      res.render('error');
    });

    module.exports = app;

routes/index.js

.. code:: javascript

    var express = require('express');
    var router = express.Router();
    const fetch = require('node-fetch');

    /* GET home page. */
    router.get('/', async function(req, res, next) {
      let provenanceData = {};
      const response =  await fetch("http://192.168.0.144:8089/Tracker");
      const rawProvenanceData = await response.json();
      provenanceData.serialNumber = rawProvenanceData['_embedded']['Tracker']['0']['serialNumber']
      provenanceData.totalUnits = rawProvenanceData['_embedded']['Tracker']['0']['totalUnits'];
      provenanceData.lastMeterRead = rawProvenanceData['_embedded']['Tracker']['0']['lastMeterRead'];
      console.log(provenanceData);
      res.setHeader('Content-Type', 'application/json');
      res.end(JSON.stringify(provenanceData));
    });

    module.exports = router;


Vue.js DApp service
====================

.. code:: javascript

    <template>
      <v-app>
        <v-app-bar app color="primary" dark>
          <v-spacer></v-spacer>
        </v-app-bar>
        <v-main>
          <v-container>
            <v-btn @click="oracleUpdate">Deploy Oracle</v-btn>
          </v-container>
        </v-main>
      </v-app>
    </template>
    
    <script>
    import Web3 from "web3";
    
    export default {
      name: "App",
      data() {
        return {
          abi: [
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
                  name: "mpxn",
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
              name: "getMpxn",
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
          ],
          ganacheUrl: "http://127.0.0.1:7545",
        };
      },
      methods: {
        async oracleUpdate() {
          let provider = new Web3(new Web3.providers.HttpProvider(this.ganacheUrl));
          provider.eth.getAccounts((error, result) => {
            console.log("Address", result);
          });
          //From metamask
          let AddressOwner = "0x2afAD5799Fd9F9FB2d2b80d5319cBF951232394f";
          //From Remix
          let contractAddress = "0xBCA5A40EaE68a2E4f6b2F67854daDf8A34F0d393";
          let contractInstance = new provider.eth.Contract(this.abi, contractAddress);
          console.log("Contract instance", contractInstance);
    
          // let result = await fetch("http://localhost:8089/");
          // let json = await result.json();
          // console.log(`Price: ${json.customerId}`);
          // console.log(`Volume: ${json.serialNumber}`);
          // console.log(`Volume: ${json.mpxn}`);
          // console.log(`Volume: ${json.totalUnits}`);
          // console.log(`Volume: ${json.lastMeterRead}`);
    
          let json = {
            customerId: "1234",
            serialNumber: "1234",
            mpxn: "1234",
            totalUnits: "1234",
            lastMeterRead: "12-12-2021"
          }
    
          //Call the contract to set a meter reading data
          contractInstance.methods
            .setMeterReading(parseInt(json.customerId), parseInt(json.serialNumber), parseInt(json.mpxn), parseInt(json.totalUnits), parseInt(json.lastMeterRead))
            .send({ from: AddressOwner })
            .on("receipt", () => {
              console.log("Values Updated");
            });
    
          //Call the contract to get the the meter readings
          contractInstance.methods
            .getSerialNumber(parseInt(json.customerId))
            .send({ from: AddressOwner })
            .then((val) => {
              console.log("Serial Number: ", val);
            });
    
          //Call the contract to get the stock volume
          contractInstance.methods
            .getMpxn(parseInt(json.customerId))
            .send({ from: AddressOwner })
            .then((val) => {
              console.log("mpxn: ", val);
            });
    
          //Call the contract to get the stock volume
          contractInstance.methods
            .getTotalUnits(parseInt(json.customerId))
            .send({ from: AddressOwner })
            .then((val) => {
              console.log("Total Units: ", val);
            });
    
          //Call the contract to get the stock volume
          contractInstance.methods
            .getLastMeterRead(parseInt(json.customerId))
            .send({ from: AddressOwner })
            .then((val) => {
              console.log("Last Meter Update Time: ", val);
            });
    
        },
      },
    };
    </script>
    
    