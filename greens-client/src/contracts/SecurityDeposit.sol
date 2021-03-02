// SPDX-License-Identifier: MIT
pragma solidity ^0.7.1;

import "./StandardSecurityDeposit.sol";

contract SecurityDeposit is StandardSecurityDeposit {


    address payable public consumer;
    address  payable public energyUtility;
    uint public depositAmt;
    bool noDues;

    mapping (address => uint) public balances;

    event ConsumerDepositAmount(address energyUtility, string msg, uint depositAmt);
    event RefundsEnabled();
    event RefundAction(address energyUtility, address consumer, uint depositAmt);



    modifier onlyEnergyUtility {
        require(
            msg.sender == energyUtility,"Only energyUtility can call this function."
        );
        _;
    }

    constructor(address payable _consumer,address payable _energyUtility, uint _depositAmt){
        consumer = _consumer;
        energyUtility = _energyUtility;
        depositAmt = _depositAmt;
    }

    fallback() external payable {

    }

    receive() external payable {


    }

    function deposit() override public payable{
        require(msg.sender == consumer);
        balances[energyUtility] += depositAmt;
        // energyUtility.transfer(depositAmt);
        emit ConsumerDepositAmount(msg.sender, "security amount deposited",depositAmt);
    }


    function approveReturn() override  public onlyEnergyUtility {
        if (noDues == true){
            emit RefundsEnabled();
        }
    }


    function returnOfDeposit(address payable _consumer) override public onlyEnergyUtility {
        balances[msg.sender] -= depositAmt;
        balances[_consumer] += depositAmt;
        emit RefundAction(msg.sender, _consumer, depositAmt);

    }



}
