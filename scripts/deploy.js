const { ethers } = require("hardhat");

async function deployContract() {
  const votingContract = await ethers.getContractFactory("IoTVotingSystem");
  const deployement = await votingContract.deploy();
  console.log("Deplotying");
  await deployement.waitForDeployment();
  console.log("Deployed contract:", await deployement.getAddress());
}

deployContract()
  .then(() => process.exit(0))
  .catch((err) => {
    console.log(err);
    process.exit(1);
  });
