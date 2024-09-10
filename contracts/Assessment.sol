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
