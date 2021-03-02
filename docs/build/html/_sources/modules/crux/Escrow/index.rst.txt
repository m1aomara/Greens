Escrow
+++++++

Use case diagram
=================

.. image:: ./images/FinalSecurityDeposit.png
   :align: center


Escrow without OpenZeppelin (just for practice)
===============================================

.. image:: ./images/sd.png
   :align: center

.. code-block::

    // SPDX-License-Identifier: MIT

    pragma solidity ^0.7.1;


    interface StandardSecurityDeposit {


        function deposit() external payable;

        function approveReturn() external;

        function returnOfDeposit(address payable consumer) external;

    }



.. code-block::

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

Escrow using OpenZeppelin
=========================

.. image:: ./images/sd-oz.png
   :align: center


.. code-block::

    // SPDX-License-Identifier: MIT

    pragma solidity ^0.8.0;


    import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/24a0bc23cfe3fbc76f8f2510b78af1e948ae6651/contracts/utils/escrow/RefundEscrow.sol";


    abstract contract OzStandardSecurityDeposit is RefundEscrow {

        function deposit(address refundee) override public virtual payable{
            super.deposit(refundee);
        }

        function approveReturn() external virtual;

        function returnOfDeposit(address payable consumer) virtual external;

    }


.. code-block::

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


        constructor(address payable _consumer,address payable _energyUtility, uint _depositAmt) RefundEscrow (_consumer){
            consumer = _consumer;
            energyUtility = _energyUtility;
            depositAmt = _depositAmt;
        }

        fallback() external payable {

        }

        receive() external payable {


        }

        function deposit(address _consumer) override public payable{
            require(msg.sender == _consumer);
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