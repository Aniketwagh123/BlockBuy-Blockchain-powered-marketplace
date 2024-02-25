// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Escrow.sol";

contract Store {
    enum ProductStatus {
        Available,
        Processing,
        Shipping,
        Sold
    }

    struct Product {
        string name;
        string category;
        string imageLink;
        string descLink;
        uint256 price;
        uint256 index;
        ProductStatus status;
        address seller;
    }

    struct Order {
        bytes32 productId;
        address seller;
        address buyer;
        address escrow;
    }

    address public owner;
    address public escrowContract;
    mapping(bytes32 => Product) public products;
    mapping(bytes32 => Order) public orders;
    mapping(address => bool) public sellersExist;
    bytes32[] public productIds;

    event ProductCreated(
        bytes32 indexed id,
        uint256 index,
        string name,
        string category,
        string imageLink,
        string descLink,
        uint256 price,
        ProductStatus status
    );

    event ProductUpdated(
        bytes32 indexed id,
        uint256 index,
        string name,
        string category,
        string imageLink,
        string descLink,
        uint256 price,
        ProductStatus status
    );

    event OrderCreated(
        bytes32 indexed productId,
        address indexed seller,
        address indexed buyer,
        address escrow
    );
    event OrderConfirmed(
        bytes32 indexed productId,
        address indexed buyer,
        uint256 amount
    );
    event OrderRejected(
        bytes32 indexed productId,
        address indexed buyer,
        uint256 amount
    );

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier onlySeller(bytes32 id) {
        require(
            msg.sender == products[id].seller,
            "Only the seller can perform this action"
        );
        _;
    }

    constructor(address _escrowContract) {
        owner = msg.sender;
        escrowContract = _escrowContract;
    }

    function setEscrowContract(address _escrowContract) public onlyOwner {
        escrowContract = _escrowContract;
    }

    function addProduct(
        string memory name,
        string memory category,
        string memory imageLink,
        string memory descLink,
        uint256 price
    ) public returns (uint256) {
        bytes32 id = keccak256(
            abi.encodePacked(name, category, imageLink, descLink, price)
        );

        if (!sellersExist[msg.sender]) {
            addSeller(msg.sender);
        }

        require(!isProduct(id), "Product already exists");

        products[id] = Product({
            name: name,
            category: category,
            imageLink: imageLink,
            descLink: descLink,
            price: price,
            index: productIds.length,
            status: ProductStatus.Available,
            seller: msg.sender
        });

        productIds.push(id);
        emit ProductCreated(
            id,
            products[id].index,
            name,
            category,
            imageLink,
            descLink,
            price,
            ProductStatus.Available
        );

        return products[id].index;
    }

    function addSeller(address newSeller) internal {
        sellersExist[newSeller] = true;
    }

    function updateProduct(
        bytes32 id,
        string memory name,
        string memory category,
        string memory imageLink,
        string memory descLink,
        uint256 price
    ) public onlySeller(id) {
        require(isProduct(id), "Product does not exist");

        Product storage product = products[id];

        product.name = name;
        product.category = category;
        product.imageLink = imageLink;
        product.descLink = descLink;
        product.price = price;

        emit ProductUpdated(
            id,
            product.index,
            name,
            category,
            imageLink,
            descLink,
            price,
            product.status
        );
    }

    function placeOrder(bytes32 id) public payable {
        require(isProduct(id), "Product does not exist");
        require(msg.value >= products[id].price, "Insufficient funds");
        require(
            products[id].status == ProductStatus.Available,
            "Product not available"
        );

        if (escrowContract == address(0)) {
            escrowContract = address(new Escrow());
            setEscrowContract(escrowContract);
        }

        Escrow(escrowContract).createOrder{value: msg.value}(
            id,
            msg.sender,
            products[id].seller
        );

        orders[id] = Order({
            productId: id,
            seller: products[id].seller,
            buyer: msg.sender,
            escrow: escrowContract
        });

        updateProductStatus(id, ProductStatus.Processing);
        emit OrderCreated(id, products[id].seller, msg.sender, escrowContract);
    }

    function confirmTransaction(bytes32 id) public {
        require(
            msg.sender == orders[id].buyer,
            "Only the buyer can confirm the transaction"
        );
        Escrow(orders[id].escrow).confirmTransaction(id, msg.sender);
        updateProductStatus(id, ProductStatus.Shipping);
        emit OrderConfirmed(id, msg.sender, products[id].price);
    }

    function rejectTransaction(bytes32 id) public {
        require(
            msg.sender == orders[id].buyer,
            "Only the buyer can reject the transaction"
        );
        Escrow(orders[id].escrow).rejectTransaction(id, msg.sender);
        updateProductStatus(id, ProductStatus.Available);
        emit OrderRejected(id, msg.sender, products[id].price);
    }

    function isProduct(bytes32 id) public view returns (bool) {
        return
            products[id].index < productIds.length &&
            productIds[products[id].index] == id &&
            products[id].status == ProductStatus.Available;
    }

    function getProduct(bytes32 id)
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            string memory,
            uint256,
            uint256,
            ProductStatus
        )
    {
        require(isProduct(id), "Product does not exist");
        return (
            products[id].name,
            products[id].category,
            products[id].imageLink,
            products[id].descLink,
            products[id].price,
            products[id].index,
            products[id].status
        );
    }

    function getProductCount() public view returns (uint256) {
        return productIds.length;
    }

    function getProductIdAt(uint256 index) public view returns (bytes32) {
        require(index < productIds.length, "Index out of bounds");
        return productIds[index];
    }

    function updateProductStatus(bytes32 id, ProductStatus status) internal {
        require(isProduct(id), "Product does not exist");
        products[id].status = status;
        emit ProductUpdated(
            id,
            products[id].index,
            products[id].name,
            products[id].category,
            products[id].imageLink,
            products[id].descLink,
            products[id].price,
            status
        );
    }
}