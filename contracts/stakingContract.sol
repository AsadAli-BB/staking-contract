// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract stakingContract is Ownable {
    // function to  Add whiteList addresses
    // function to transfer tokens to white list address
    // function to add tokens into treasury

    uint256[] public nftHolders;

    uint256 treasury;

    function addIntoTreasury() public payable onlyOwner {
        treasury += msg.value;
    }

    // callable by owner
    function checkTreasuryBalance() public view onlyOwner returns (uint256) {
        return treasury;
    }

    // Function callable by owner to transfer Tokens into treasury
    function transferReward(address payable add) public payable onlyOwner {
        require(treasury >= msg.value, "Insufficient Balance");
        add.transfer(msg.value);
        treasury -= msg.value;
        emit TransferReward(add, msg.value);
    }

    // function addNftHolders(address []) onlyOwner public {}


    // Function to Add Single NFT Holder Adddress
    function addSingleNftHolder(uint256 _number) public onlyOwner {
        nftHolders.push(_number);
    }

    // Function will return total number of NFT Holders 
    function sizeOfNftHolder() public view returns (uint256) {
        return nftHolders.length;
    }

    // Remove NFT Holdere from the array by index
    function removeNumber(uint256 _index) public onlyOwner {
        require(_index < nftHolders.length, "Index out of bounds");
        for (uint256 i = _index; i < nftHolders.length - 1; i++) {
            nftHolders[i] = nftHolders[i + 1];
        }
        nftHolders.pop();
    }

    // Function to show All NFT Holders
    function showAllNftHolders () view public  returns ( uint256[] memory) {
        return nftHolders;
    }


    event TransferReward(address indexed receiver, uint256 amount);
}
