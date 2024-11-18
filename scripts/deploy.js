const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners(); // No need for a private key
  console.log("Deploying contracts with the account:", deployer.address);

  // Token address for TokenSwap (ensure this is valid)
  const tokenSwapAddress = "0xe7f1725e7734ce288f8367e1bb143e90bb3f0512";

  // Define initial amount
  const initialAmount = "100";  // Adjust amount as necessary

  // Deploy TokenSwap with address and initial amount
  const TokenSwap = await hre.ethers.getContractFactory("TokenSwap");
  const tokenSwap = await TokenSwap.deploy(tokenSwapAddress, initialAmount);
  await tokenSwap.deployed();
  console.log("TokenSwap deployed to:", tokenSwap.address);

  // Address for LiquidityPool deployment
  const liquidityTokenAddress = "0x5fbdb2315678afecb367f032d93f642f64180aa3";  // Update as necessary
  const LiquidityPool = await hre.ethers.getContractFactory("LiquidityPool");
  const liquidityPool = await LiquidityPool.deploy(liquidityTokenAddress);
  await liquidityPool.deployed();
  console.log("LiquidityPool deployed to:", liquidityPool.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
