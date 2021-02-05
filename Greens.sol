// SPDX-License-Identifier: MIT

pragma solidity ^0.7.1;

contract Greens {
    // Defining a Struct for Users (Consumer or Prosumer)

    struct UserStruct {
        bytes32 userName;
        uint256 userAge;
        uint256 index;
    }

    mapping(address => UserStruct) private userStructs;
    address[] private userIndex;

    event LogNewUser(
        address indexed userAddress,
        uint256 index,
        bytes32 userName,
        uint256 userAge
    );

    // Check if the usrs already exists

    function isUser(address userAddress) public view returns (bool isIndeed) {
        if (userIndex.length == 0) return false;
        return (userIndex[userStructs[userAddress].index] == userAddress);
    }

    // Add new user (PublishInfo)

    function insertUser(
        address userAddress,
        bytes32 userName,
        uint256 userAge
    ) public returns (uint256 index) {
        if (isUser(userAddress)) revert();
        userStructs[userAddress].userName = userName;
        userStructs[userAddress].userAge = userAge;
        userStructs[userAddress].index = userIndex.length;
        emit LogNewUser(
            userAddress,
            userStructs[userAddress].index,
            userName,
            userAge
        );
        return userIndex.length - 1;
    }

    // Get user by Address (GetInfo)

    function getUser(address userAddress)
        public
        view
        returns (
            bytes32 userName,
            uint256 userAge,
            uint256 index
        )
    {
        if (!isUser(userAddress)) revert();
        return (
            userStructs[userAddress].userName,
            userStructs[userAddress].userAge,
            userStructs[userAddress].index
        );
    }

    // Defining Ownership
    // MakeOffer
}
