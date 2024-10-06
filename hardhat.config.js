require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
const SEPOLIA_PRIVATE_KEY=process.env.SEPOLIA_PRIVATE_KEY;
const url=process.env.INFURA_URL;
module.exports = {
  solidity: "0.8.24",
  defaultNetwork:"hardhat",
  networks:{
    // sepolia:{
    //   url,
    //   accounts:[SEPOLIA_PRIVATE_KEY]
    // }
    sepolia:{
      url,
      accounts:[SEPOLIA_PRIVATE_KEY]
    }
  }
};
