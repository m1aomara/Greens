const OzSecurityDeposit = artifacts.require("OzSecurityDeposit");
const EnergyMeterOracle = artifacts.require("EnergyMeterOracle");
const StandardERC20 = artifacts.require("StandardERC20");
const GreenToken = artifacts.require("GreenToken");

module.exports = function(deployer) {
  deployer.deploy(OzSecurityDeposit);
  deployer.deploy(EnergyMeterOracle);
  deployer.deploy(StandardERC20);
  deployer.deploy(GreenToken);
};
