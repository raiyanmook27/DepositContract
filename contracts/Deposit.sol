// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

/**
 * @notice console.sol helps in logging messages
 */
import "hardhat/console.sol";

/**
 * @title A contract for depositing eth and using the selfdestruct() function.
 * @author @raiyan.mook27 : Raiyan Mukhtar.
 * @notice You can use this contract to learn about the sending eth to a contract
 * and using the selfdestruct() function.
 */
contract Deposit {
    /**
     * @notice making the owners address immutable
     * since we initializing it in a constructor.
     */
    address public immutable OWNER;

    /**
     * @notice Emitted when a deposit is made.
     */
    event AfterDeposit(address indexed from, uint indexed amount);
    /**
     * @notice Emitted when the contract is killed.
     */
    event AfterContractKilled(bool indexed success);

    /**
     * @dev check if current
     * caller is the owner of the contract.
     */
    modifier OnlyOwner() {
        /// @dev require that the current caller is the owner.
        require(msg.sender == OWNER, "Not an authorized owner");
        _;
    }
    /**
     * @dev check if amount is not zero
     */
    modifier checkAmount(uint amount) {
        /// @dev require that the amount is not zero
        require(amount != 0, "Ether not enough");
        _;
    }

    /**
     * @notice since contructors runs only we initialized the owner(deployer) here
     */
    constructor() {
        /// @dev initialize owner to the current caller.
        OWNER = msg.sender;
    }

    /**
     * @notice Deposits ether to the contract.
     * @dev with the payable modifier eth can be sent to contract
     */
    function deposit() external payable checkAmount(msg.value) {
        ///@dev initialize the msg.value to the amount
        /// @dev emit the sender and amount sent
        emit AfterDeposit(msg.sender, msg.value);

        console.log("Eth Deposited", msg.sender, msg.value);
    }

    /**
     * @notice queries the current balance in the contract.
     * @return amount -> current balance in uint.
     */
    function getBalance() external view returns (uint) {
        console.log("Current Balance:", address(this).balance);
        /// @dev return the current balance of contract.
        return address(this).balance;
    }

    /**
     * @notice owner sends eth to the contract and the
     * function calls the selfdestruct()
     * @dev selfdestruct() kills the contract with no access
     * to the eth. Owner can only call this function.
     */
    function selfDestruct() external payable OnlyOwner {
        /// @dev calling the selfdestruct() to kill contract
        selfdestruct(payable(OWNER));
        console.log("Contract Killed");
        /// @dev emit if successful
        emit AfterContractKilled(true);
    }

    function getOwner() external view returns (address) {
        return OWNER;
    }
}
