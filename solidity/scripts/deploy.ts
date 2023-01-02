import { ethers, network } from "hardhat";
import { writeFile } from "fs";

// deploy to local:
// hh run --network localhost scripts/deploy.ts 

async function main() {
  console.log("Deploying to network", network.name);
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
  const unlockTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;

  const lockedAmount = ethers.utils.parseEther("1");

  const Lock = await ethers.getContractFactory("Lock");
  const lock = await Lock.deploy(unlockTime, { value: lockedAmount });

  await lock.deployed();

  console.log(`Lock with 1 ETH and unlock timestamp ${unlockTime} deployed to ${lock.address}`);

  const NFTRepo = await ethers.getContractFactory("NFTRepo");
  const nftRepo = await NFTRepo.deploy();
  console.log(`Deployed NFTRepo ${nftRepo.address}`);

  const NFTOwner = await ethers.getContractFactory("NFTOwner");
  const nftOwner = await NFTOwner.deploy();
  console.log(`Deployed NFTOwner ${nftOwner.address}`);

  const NFTPiece = await ethers.getContractFactory("NFTPiece");
  const nftPiece = await NFTPiece.deploy(1001);
  console.log(`Deployed NFTPiece ${nftPiece.address}`);

  const addresses = {
    nftRepo: nftRepo.address,
    nftOwner: nftOwner.address,
    nftPiece: nftPiece.address,
  }
  writeFile('./bin/deployedContracts.json', JSON.stringify(addresses, null, 2), err => {
    if (err) {
      console.error(err);
      console.log("Cannot write deployed contract address");
    }
  });

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
