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

  await social.waitForDeployment();

  console.log(
    `NFTContract deployed to ${nftFactory.target} and social contract deployed to ${social.target}`
  );

  // const nftFactoryAddr = "0xf8A729F76f15Ee87b7da8bD723d6Ba03Ee41386F";

  // const socialFactoryAddr = "0x5670146a55A591Aa162Cea011667467e360D7Aa4";
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
