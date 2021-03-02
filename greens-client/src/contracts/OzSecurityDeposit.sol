// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./OzStandardSecurityDeposit.sol";

contract OzSecurityDeposit is OzStandardSecurityDeposit{


    address payable public consumer ;
    address  payable public energyUtility;
    uint public depositAmt;
    bool noDues;

    mapping (address => uint) public balances;

    event ConsumerDepositAmount(address energyUtility, string msg, uint depositAmt);
    event RefundAction(address energyUtility, address consumer, uint depositAmt);



    modifier onlyEnergyUtility {
        require(
            msg.sender == energyUtility,"Only energyUtility can call this function."
        );
        _;
    }


    constructor(address payable _energyUtility) RefundEscrow (_energyUtility){
        // consumer = _consumer;
        energyUtility = _energyUtility;
        // depositAmt = _depositAmt;
    }

    fallback() external payable {

    }

    receive() external payable {


    }
    
    function setConsumer(address payable _consumer) public{
        consumer = _consumer;
    }
    
    function setEnergyUtility(address payable _energyUtility) public{
        energyUtility = _energyUtility;
    }

    function deposit(address _consumer,uint _depositAmt) public payable{
        require(msg.sender == _consumer);
        depositAmt = _depositAmt;
        balances[energyUtility] = depositAmt;
        super.deposit(_consumer);
        emit ConsumerDepositAmount(msg.sender, "security amount deposited",depositAmt);
    }
    
    function closed() public{
        super.close();
    }
    

    function approveReturn() override  public view onlyEnergyUtility {
        if (noDues == true){
           super.withdrawalAllowed(consumer);
        }
    }


    function returnOfDeposit(address payable _consumer) override public onlyEnergyUtility {
        super.beneficiaryWithdraw();
        balances[msg.sender] -= depositAmt;
        balances[_consumer] += depositAmt;
        emit RefundAction(msg.sender, _consumer, depositAmt);
    }
}
