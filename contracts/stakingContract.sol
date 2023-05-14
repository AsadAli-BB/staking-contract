// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract stakingContract is Ownable {

    // Try to do this in Mapping

    // function to  Add whiteList addresses
    // function to transfer tokens to white list address
    // function to add tokens into treasury

    address[] public nftHolders;

    uint256 stakingReward; 

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
    function addSingleNftHolder(address _singleNftHolder) public onlyOwner {
        nftHolders.push(_singleNftHolder);
    }

    // Function will return total number of NFT Holders 
    function sizeOfNftHolder() public view returns (uint256) {
        return nftHolders.length;
    }

    // Remove NFT Holdere from the array by index
    function removeNftHolder(uint256 _index) public onlyOwner {
        require(_index < nftHolders.length, "Index out of bounds");
        for (uint256 i = _index; i < nftHolders.length - 1; i++) {
            nftHolders[i] = nftHolders[i + 1];
        }
        nftHolders.pop();
    }

    // Function to show All NFT Holders
    function showAllNftHolders () view public  returns ( address[] memory) {
        return nftHolders;
    }
    
    function addNftHoldersInBulk (address[] memory _nftHolders ) public onlyOwner {
        
        for (uint i = 0; i < _nftHolders.length; i++) {
            nftHolders.push(_nftHolders[i]);
        }

    }

    function  changestakingReward (uint256 _stakingReward) public onlyOwner {
        
        require(_stakingReward != 0, "Invalid Amount");
        stakingReward = _stakingReward;

    }

    function transferStakingReward() public onlyOwner {
        
    }

    event TransferReward(address indexed receiver, uint256 amount);
}
