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
