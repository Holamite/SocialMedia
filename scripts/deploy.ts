import { ethers } from "hardhat";

async function main() {
  const tokenName = "HolamiteToken";
  const tokenSymbol = "HoT";

  const nftFactory = await ethers.deployContract("NFTFactory", [
    tokenName,
    tokenSymbol,
  ]);

  await nftFactory.waitForDeployment();

  const nftFactoryContract = nftFactory.target;

  const social = await ethers.deployContract("Social", [nftFactoryContract]);

  console.log(`Contract deployed to ${nftFactory.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
