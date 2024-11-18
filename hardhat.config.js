require("@nomiclabs/hardhat-ethers");

module.exports = {
  solidity: "0.8.20", // Adjust to your version
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545", // Local network URL
      chainId: 1337, // Local network chain ID
      accounts: { mnemonic: "test test test test test test test test test test test test test test" }, // Default Hardhat mnemonic
    },
  },
};
