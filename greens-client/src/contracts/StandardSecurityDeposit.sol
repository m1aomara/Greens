// SPDX-License-Identifier: MIT

pragma solidity ^0.7.1;


interface StandardSecurityDeposit {


    function deposit() external payable;

    function approveReturn() external;

    function returnOfDeposit(address payable consumer) external;

}