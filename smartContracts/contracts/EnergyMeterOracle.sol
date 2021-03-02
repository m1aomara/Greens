// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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
