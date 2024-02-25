// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./BlockBuyToken.sol";


contract Escrow {
    BlockBuyToken public tokenContract;
    address public owner;
    mapping(bytes32 => OrderInfo) public orders;

    struct OrderInfo {
        address buyer;
        address seller;
        uint256 amount;
        bool buyerConfirmation;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor(address tokenContractAddress) {
        owner = msg.sender;
        tokenContract = BlockBuyToken(tokenContractAddress);
    }

    function createOrder(
        bytes32 id,
        address buyer,
        address seller,
        address tokenAddress,
        uint256 amount
    ) external {
        require(amount > 0, "Invalid initial deposit");
        require(
            IERC20(tokenAddress).transferFrom(buyer, address(this), amount),
            "Token transfer failed"
        );

        orders[id] = OrderInfo({
            buyer: buyer,
            seller: seller,
            amount: amount,
            buyerConfirmation: false
        });
    }

    function confirmTransaction(bytes32 id, address sender) external {
    require(
        sender == orders[id].buyer,
        "Only the buyer can confirm the transaction"
    );
    require(
        !orders[id].buyerConfirmation,
        "Transaction already confirmed by buyer"
    );
    // require(
    //     sender == orders[id].seller,
    //     "The provided sender is not authorized"
    // );
    orders[id].buyerConfirmation = true;

    releaseFunds(id);
}

function rejectTransaction(bytes32 id, address sender) external {
    require(
        msg.sender == orders[id].buyer,
        "Only the buyer can reject the transaction"
    );
    require(
        !orders[id].buyerConfirmation,
        "Transaction already confirmed by buyer"
    );
    require(
        sender == orders[id].seller,
        "The provided sender is not authorized"
    );

    require(
        tokenContract.transfer(
            orders[id].buyer,
            orders[id].amount
        ),
        "Token transfer failed"
    );

    resetOrder(id);
}


    function releaseFunds(bytes32 id) internal {
        require(
            orders[id].buyerConfirmation,
            "Buyer must confirm the transaction"
        );

        require(
            tokenContract.transfer(
                orders[id].seller,
                orders[id].amount
            ),
            "Token transfer failed"
        );

        resetOrder(id);
    }

    function resetOrder(bytes32 id) internal {
        delete orders[id];
    }

    function withdrawFunds() external onlyOwner {
        address payable ownerPayable = payable(owner);
        ownerPayable.transfer(address(this).balance);
    }
}
