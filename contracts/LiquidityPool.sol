// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract LiquidityPool {
    IERC20 public token;
    mapping(address => uint256) public deposits;
    address public owner;

    constructor(address _token) {
        token = IERC20(_token);
        owner = msg.sender;
    }

    // Deposit ERC-20 tokens to the pool
    function deposit(uint256 amount) external {
        require(token.allowance(msg.sender, address(this)) >= amount, "Token allowance too low");

        // Transfer tokens from user to contract
        token.transferFrom(msg.sender, address(this), amount);
        deposits[msg.sender] += amount;
    }

    // Deposit ETH to the pool
    function depositETH() external payable {
        require(msg.value > 0, "Must send ETH to deposit");

        deposits[msg.sender] += msg.value;
    }

    // Withdraw tokens from the pool
    function withdraw(uint256 amount) external {
        require(deposits[msg.sender] >= amount, "Insufficient balance");

        deposits[msg.sender] -= amount;
        // Transfer tokens from contract to user
        payable(msg.sender).transfer(amount);
    }

    // Check the total pool balance
    function getPoolBalance() external view returns (uint256) {
        return address(this).balance; // ETH balance in the contract
    }
}
