// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Escrow {
    address public owner;
    mapping(bytes32 => OrderInfo) public orders;

    struct OrderInfo {
        address buyer;
        address seller;
        uint256 amount;
        bool buyerConfirmation;
        bool sellerConfirmation;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createOrder(
        bytes32 id,
        address buyer,
        address seller
    ) external payable {
        require(msg.value > 0, "Invalid initial deposit");
        orders[id] = OrderInfo({
            buyer: buyer,
            seller: seller,
            amount: msg.value,
            buyerConfirmation: false,
            sellerConfirmation: false
        });
    }

    function confirmTransaction(bytes32 id, address buyer) external {
        require(
            buyer == orders[id].buyer,
            "Only the buyer can confirm the transaction"
        );
        require(
            !orders[id].buyerConfirmation,
            "Transaction already confirmed by buyer"
        );
        orders[id].buyerConfirmation = true;

        if (orders[id].sellerConfirmation) {
            releaseFunds(id);
        }
    }

    function rejectTransaction(bytes32 id, address buyer1) external {
        require(
            buyer1 == orders[id].buyer,
            "Only the buyer can reject the transaction"
        );
        require(
            !orders[id].buyerConfirmation,
            "Transaction already confirmed by buyer"
        );

        address payable buyer = payable(orders[id].buyer);
        buyer.transfer(orders[id].amount);
        resetOrder(id);
    }

    function sellerConfirmTransaction(bytes32 id) external {
        require(
            orders[id].seller == msg.sender,
            "Only the seller can confirm the transaction"
        );
        require(
            !orders[id].sellerConfirmation,
            "Transaction already confirmed by seller"
        );
        require(
            orders[id].buyerConfirmation,
            "Buyer has not confirmed the transaction yet"
        );

        orders[id].sellerConfirmation = true;
        releaseFunds(id);
    }

    function releaseFunds(bytes32 id) internal {
        require(
            orders[id].buyerConfirmation && orders[id].sellerConfirmation,
            "Both parties must confirm"
        );

        address payable seller = payable(orders[id].seller);
        seller.transfer(orders[id].amount);
        resetOrder(id);
    }

    function resetOrder(bytes32 id) internal {
        delete orders[id];
    }

    // Add a function for the owner to withdraw funds for testing purposes
    function withdrawFunds() external onlyOwner {
        address payable ownerPayable = payable(owner);
        ownerPayable.transfer(address(this).balance);
    }
}