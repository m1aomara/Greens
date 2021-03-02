const path = require("path");
const fs = require("fs");
const solc = require("solc");

// Compile contract
const contractPath = path.resolve(__dirname, "OzSecurityDeposit.sol");
// const contractPath = "./OzSecurityDeposit.sol";
const source = fs.readAsText(contractPath, "utf8");
const input = {
  language: "Solidity",
  sources: {
    "OzSecurityDeposit.sol": {
      content: source,
    },
  },
  settings: {
    outputSelection: {
      "*": {
        "*": ["*"],
      },
    },
  },
};
const tempFile = JSON.parse(solc.compile(JSON.stringify(input)));
const contractFile =
  tempFile.contracts["OzSecurityDeposit.sol"]["OzSecurityDeposit"];

module.exports = {
  contractFile,
};
