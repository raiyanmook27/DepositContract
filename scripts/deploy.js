const { ethers } = require("hardhat");
//const { verify } = require("../utils/verify");
//function
async function main() {
  //const [deployer] = await ethers.Signer;

  //console.log("Deploying contract with the accounts:", deployer.address);
3:52 PM 8/8/20223:52 PM 8/8/20223:52 PM 8/8/20223:52 PM 8/8/2022
  //   console.
  //   await verify(fundMe.address, args);

  const DepositContract = await ethers.getContractFactory("Deposit");
  const deposit = await DepositContract.deploy();
  await deposit.deployed();

  console.log(`Deployed contract to ${deposit.address}`);

  console.log(`Account balance: ${await deposit.getBalance()}`);

  console.log("Depositing eth...................................");
  const options = { value: ethers.utils.parseEther("0.0001") };

  //deposit 100 wei
  const TXreponse = await deposit.deposit(options);

  console.log(await TXreponse.wait(1));

  //get balance
  console.log(`New account balance: ${await deposit.getBalance()}`);
}
//call function
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
