// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


import "./StandardERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/9425a7e0ab1d45c48845d47afc33856ad9d98b0c/contracts/access/Ownable.sol"; 


contract GreenToken is StandardERC20, Ownable {


    mapping(address=>address) public meterToOwner; // Map address of meter to the meter owner wallet
    mapping(address=>address[]) public ownerToMeter; // Map address of owner wallet to the meter

    address[] public meters;

    constructor () StandardERC20("Green","JOY",10000){

    }


    event Burn(address indexed burner, uint256 value); // Burn tokens based on power consumption from the meters wallet
    event Mint(address indexed to, uint256 amount); // Mint tokens based on power production to the meters wallet


    modifier hasMintPermission() { // Requires that only the meter address can call the mint function based on production
        require(meterToOwner[msg.sender] != address(0) || msg.sender == owner());
        _;
    }

    modifier onlyMeterOwner(address _meterAddress){
        require(meterToOwner[_meterAddress] == msg.sender);
        _;
    }

    function enrollMeter(address _meterAddress, address _ownerAddress) onlyOwner public {
        meterToOwner[_meterAddress] = _ownerAddress; // Bind meter to owner
        ownerToMeter[_ownerAddress].push(_meterAddress); // Bind owner to meter
        meters.push(_meterAddress);
    }

    function transferMeterOwnership(address _meterAddress, address _newOwnerAddress) onlyMeterOwner(_meterAddress) public {
        meterToOwner[_meterAddress] = _newOwnerAddress;
        ownerToMeter[_newOwnerAddress].push(_meterAddress);
    }

    function burn(uint256 _value) public  { // Burn tokens from the meter's own wallet [msg.sender]
        super.burn(msg.sender, _value);
        emit Burn(msg.sender,_value);
    }

    function mint(uint256 _amount) public  hasMintPermission returns (bool) {
        super.mint(msg.sender,_amount);
        increaseAllowance(meterToOwner[msg.sender], _amount);
        emit Mint(msg.sender, _amount);
        return true;
    }

    function mintTo(uint256 _amount, address _recipient)public onlyOwner returns (bool){
        increaseAllowance(meterToOwner[_recipient], _amount);
        emit Mint(_recipient, _amount);
        return true;
    } 

    function getAllMeters() public view returns(address[] memory){
        return meters;
    }

    function getAllMetersForOwner(address _owner)public view returns (address[] memory){
        return ownerToMeter[_owner];
    }


}
