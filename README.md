# Metacrafters ATM!

# Objective
1. To make a smart contract with 2-3 functions
2. To Show the values of functions in frontend of the application.
![Screenshot (102)](https://github.com/Ishi181/Ishichal.sol/assets/139246938/5c03fe08-8833-4a67-b0e2-44a00622aa62)


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
Here, i implemented many functions in frontend along with values of state variables.
1. Showing Account Address.
2. Showing Owner Address.
3. Showing Contract Balance.
4. Increasing the balance by entering the certain amount.
![Screenshot (103)](https://github.com/Ishi181/Ishichal.sol/assets/139246938/7b70850d-f55a-4341-afc4-17da0aad1c9b)


# Executing Program
```
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//import "hardhat/console.sol";

contract Assessment {
    address payable public owner;
    uint256 public balance;

    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);
    event BalanceIncreased(uint256 amount);

    constructor(uint initBalance) payable {
        owner = payable(msg.sender);
        balance = initBalance;
    }

    function getBalance() public view returns (uint256) {
        return balance;
    }

    function deposit(uint256 _amount) public payable {
        uint _previousBalance = balance;

        // make sure this is the owner
        require(msg.sender == owner, "You are not the owner of this account");

        // perform transaction
        balance += _amount;

        // assert transaction completed successfully
        assert(balance == _previousBalance + _amount);

        // emit the event
        emit Deposit(_amount);
    }

    // custom error
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function withdraw(uint256 _withdrawAmount) public {
        require(msg.sender == owner, "You are not the owner of this account");
        uint _previousBalance = balance;
        if (balance < _withdrawAmount) {
            revert InsufficientBalance({
                balance: balance,
                withdrawAmount: _withdrawAmount
            });
        }

        // withdraw the given amount
        balance -= _withdrawAmount;

        // assert the balance is correct
        assert(balance == (_previousBalance - _withdrawAmount));

        // emit the event
        emit Withdraw(_withdrawAmount);
    }

    function getAddres() external view returns (address) {
        return (address(this));
    }

    function viewOwner() public view returns (address) {
        return owner;
    }

    function increaseBalance(uint256 _amount) public {

        balance += _amount;
    }

    function showBalance() external view returns (uint) {
        return address(this).balance;
    }
}
```
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.9" (or another compatible version), and then click on the ("Compile "the name of the file" ") for ex. comple first.sol button. Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "Assessment.sol" contract from the dropdown menu, and then click on the "Deploy" button. then u can see a the below of the option ' Deployed/Unpinned Contracts ' expand it and balances mint burn etc and now u can see our code is ready to run .

# Program Explanation
```
function getAddres() external view returns (address) {
        return (address(this));
    }
```
getAddres() external view returns (address): Returns the address of the contract itself.

```
    function viewOwner() public view returns (address) {
        return owner;
    }
```
viewOwner() public view returns (address): Returns the address of the contract owner.

```
    function increaseBalance(uint256 _amount) public {
        balance += _amount;
    }
```
    increaseBalance(uint256 _amount) public: Increases the balance by _amount

```
    function showBalance() external view returns (uint) {
        return address(this).balance;
    }
```
showBalance() external view returns (uint): Returns the contract's balance in terms of Ether. This is the balance held by the contract address, not the balance variable.

# Authors
Contributed by name : Ishi Singla Email id: ujjwala622@gmail.com

# License
This project is licensed under the UNLICENSED - see the LICENSE.md file for details



