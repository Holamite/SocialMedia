// import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config();

module.exports = {
  solidity: "0.8.24",
  etherscan: {
    apiKey: {
      sepolia: "bc1v0w6TRKOeco-Bw3FaV2zLj-h6BxY1",
    },
    networks: {
      sepolia: {
        url: process.env.API_URL,
        accounts: [process.env.PRIVATE_KEY],
      },
    },
    sourcify: {
      enabled: true,
    },
  },
};
