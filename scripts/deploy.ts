import { ethers } from "hardhat";

async function main() {
  const totalSupply = ethers.utils.parseEther("21000000");
  const KeepKeyToken = await ethers.getContractFactory("KeepKeyToken");
  const keepKeyToken = await KeepKeyToken.deploy(totalSupply);

  await keepKeyToken.deployed();

  console.log(`KeepKey Token Deployed with total supply of ${totalSupply} at address ${keepKeyToken.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
