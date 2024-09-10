# SocialMedia Smart Contract

# Objective
1. To make a smart contract with 2-3 functions
2. To Show the values of functions in frontend of the application.
![image](https://github.com/user-attachments/assets/8eaef8db-07f1-4ce2-9da9-d76a45e6d399)

# Description 
After cloning the github, you will want to do the following to get the code running on your computer.
1. Inside the project directory, in the terminal type: npm i
2. Open two additional terminals in your VS code
3. In the second terminal type: npx hardhat node
4. In the third terminal, type: npx hardhat run --network localhost scripts/deploy.js
5. Back in the first terminal, type npm run dev to launch the front-end.
Typically at http://localhost:3000/

# Getting Started
this code we are running on the online Solidity IDE that is https://remix.ethereum.org/ here we'll perform the code. as we are on the remix website just by clicking on th start coding we'll able to do coding in Solidity.

## Implementation
### Features
* Owner-controlled friend management: Only the contract owner can add or remove friends.
* Social score: The social score is a count of how many friends the owner currently has.
* Friends list management: Functions to add and remove friends, with automatic list cleanup after a removal.
* Event emission: Events are emitted whenever friends are added or removed, enabling off-chain applications to track changes.
* Frontend support: The contract includes getter functions to retrieve key state variables, which can be displayed on a frontend interface.
![image](https://github.com/user-attachments/assets/d1961533-0a1b-4e3a-9223-284824a2e7a4)

# Executing Program
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

//contract to show 4 state variables value on frontend.

error AlreadyInFriendList();

contract SocialMedia {
    uint32 private socialScore;
    uint256 private totalFriendsEver;
    address private immutable owner;
    uint32 private removeFriends;
    mapping(address => bool) private isInFriendList;

    address[] private friendList;

    event AddFriend(address indexed newFriend, uint indexed friendNumber);
    event RemoveFriend(address indexed frindAddress, uint indexed noOfFriend);

    // For Better Gas Optimization
    modifier onlyOwner() {
        _onlyOwner();
        _;
    }

    function _onlyOwner() internal view {
        require(msg.sender == owner, "You are not the Owner");
    }

    constructor() {
        owner = msg.sender;
    }

    function showFriendList() external view returns (address[] memory) {
        uint l = friendList.length;
        uint TotalFriendsRemaining = totalFriendsEver - removeFriends;
        uint index = 0;

        address[] memory friends = new address[](
            TotalFriendsRemaining < 1 ? 0 : TotalFriendsRemaining
        );

        for (uint i = 0; i < l; i++) {
            address val = friendList[i];
            if (val != address(0)) {
                friends[index] = val;
                index++;
            }
        }
        return friends;
    }

    function _correctFriendList() internal returns (address[] memory) {
        uint l = friendList.length;
        uint index = 0;

        for (uint i = 0; i < l; i++) {
            address val = friendList[i];
            if (val != address(0)) {
                friendList[index] = val;
                index++;
            }
        }

        while (l > index) {
            friendList.pop();
            index++;
        }
        return friendList;
    }

    function totalFriendsEverrr() external view returns (uint) {
        return totalFriendsEver;
    }

    function addFriends(address _address) external onlyOwner {
        if (isInFriendList[_address]) {
            revert AlreadyInFriendList();
        }
        friendList.push(_address);
        isInFriendList[_address] = true;
        socialScore++;
        totalFriendsEver++;

        emit AddFriend(_address, socialScore);
    }

    function removeFriendsFromList(uint index) external onlyOwner {
        address val = friendList[index];
        isInFriendList[val] = false;
        delete friendList[index];
        removeFriends++;
        socialScore--;
        emit RemoveFriend(val, removeFriends);
        _correctFriendList();
    }

    function showAddress() external view returns (address) {
        return address(this);
    }

    function showBalance() external view returns (uint) {
        return address(this).balance;
    }

    function showSocialScore() external view returns (uint) {
        return socialScore;
    }

    function noOfRemovedFriend() external view returns (uint) {
        return removeFriends;
    }

    function getOwner() external view returns (address) {
        return owner;
    }
}
```
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.9" (or another compatible version), and then click on the ("Compile "the name of the file" ") for ex. comple first.sol button. Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "Assessment.sol" contract from the dropdown menu, and then click on the "Deploy" button. then u can see a the below of the option ' Deployed/Unpinned Contracts ' expand it and balances mint burn etc and now u can see our code is ready to run .

# Program Explanation

```showFriendList():``` Returns an array of the current friends. This list excludes removed friends.

```totalFriendsEverrr(): ```Returns the total number of friends ever added, including those who have been removed.

```addFriends(address _address): ```Adds a friend to the list. Only the owner can call this function. If the address is already in the friend list, the transaction will be reverted with the custom error AlreadyInFriendList.

```removeFriendsFromList(uint index):``` Removes a friend from the list based on their position in the friendList array. Only the owner can call this function. After removing a friend, the list is corrected to remove gaps.

```showAddress():``` Returns the contract’s address.

```showBalance(): ```Returns the contract's balance (useful for interacting with the contract financially).

```showSocialScore():``` Returns the current social score of the owner, which increases or decreases as friends are added or removed.

```noOfRemovedFriend():``` Returns the number of friends who have been removed from the list.

```getOwner(): ```Returns the address of the contract owner.


# Authors
Contributed by name : Ujjwala Email id: ujjwala622@gmail.com

# License
This project is licensed under the UNLICENSED - see the LICENSE.md file for details



