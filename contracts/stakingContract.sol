// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";


contract stakingContract is Ownable  {
    // function to  Add whiteList addresses
    // function to transfer tokens to white list address 
    // function to add tokens into treasury

    uint treasury; 
    function addIntoTreasury() public payable  onlyOwner {
        treasury += msg.value; 
    }

    // callable by owner
    function checkTreasuryBalance() public view onlyOwner returns (uint){
        return treasury; 
    }

    // transfer rewards to treasury 
    function transferReward(address payable  add) public payable  onlyOwner {
        
        require(treasury >= msg.value, "Insufficient Balance");
        add.transfer(msg.value);
        treasury -= msg.value; 
        emit TransferReward(add, msg.value);
    
    }

    

    event TransferReward(address indexed receiver, uint amount);
}