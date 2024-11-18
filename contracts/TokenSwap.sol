// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenSwap {
    IERC20 public tokenA;
    IERC20 public tokenB;
    address public owner;

    constructor(address _tokenA, address _tokenB) {
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
        owner = msg.sender;
    }

    // Swap token A for token B
    function swapAForB(uint256 amountA) external {
        require(tokenA.allowance(msg.sender, address(this)) >= amountA, "Token A allowance too low");
        
        uint256 amountB = getEquivalentB(amountA);
        require(tokenB.balanceOf(address(this)) >= amountB, "Insufficient Token B liquidity");

        // Transfer token A from user to contract
        tokenA.transferFrom(msg.sender, address(this), amountA);
        // Transfer token B from contract to user
        tokenB.transfer(msg.sender, amountB);
    }

    // Swap token B for token A
    function swapBForA(uint256 amountB) external {
        require(tokenB.allowance(msg.sender, address(this)) >= amountB, "Token B allowance too low");
        
        uint256 amountA = getEquivalentA(amountB);
        require(tokenA.balanceOf(address(this)) >= amountA, "Insufficient Token A liquidity");

        // Transfer token B from user to contract
        tokenB.transferFrom(msg.sender, address(this), amountB);
        // Transfer token A from contract to user
        tokenA.transfer(msg.sender, amountA);
    }

    // Set exchange rate or equivalent (for simplicity)
    function getEquivalentB(uint256 amountA) public pure returns (uint256) {
        return amountA; // 1:1 swap for simplicity, replace with actual rate logic
    }

    function getEquivalentA(uint256 amountB) public pure returns (uint256) {
        return amountB; // 1:1 swap for simplicity, replace with actual rate logic
    }
}
