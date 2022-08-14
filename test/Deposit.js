const { expect, assert } = require("chai");
const { ethers } = require("hardhat");

describe("Deposit", async function () {
  let deposit;
  let owner;

  beforeEach(async function () {
    //get address to deploy contract
    [owner] = await ethers.getSigners();

    // get the contract factory
    const depositContract = await ethers.getContractFactory("Deposit");

    //deploy contract
    deposit = await depositContract.deploy();
  });
  describe("constructor", async function () {
    it("Should initialize the deployer as the owner of the contract", async function () {
      assert.equal(owner.address, await deposit.getOwner());
    });
  });
  describe("deposit", async function () {
    it.only("should deposit ether greater than 0", async function () {
      //deposit 0 eth to test modifier
      const options = ethers.utils.parseEther("0");
      await expect(deposit.deposit({ value: options })).to.be.revertedWith(
        "Ether not enough"
      );
    });
  });
});
