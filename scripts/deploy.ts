import { ethers } from "hardhat";

async function main() {
  const totalSupply = ethers.utils.parseEther("21000000");
  const KeepKey = await ethers.getContractFactory("KeepKey");
  const keepKey = await KeepKey.deploy(totalSupply);

  await keepKey.deployed();

  console.log(`KeepKey Token Deployed with total supply of ${totalSupply}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
