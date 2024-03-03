class ProductData {
  final String _name;
  final String _category;
  final String _imageLink;
  final String _descLink;
  final BigInt _price;

  ProductData(this._name, this._category, this._imageLink, this._descLink, this._price);

  @override
  String toString() {
    return 'ProductData: {_name: $_name, _category: $_category, _imageLink: $_imageLink, _descLink: $_descLink, _price: $_price}';
  }
}

class OrderData {
  String _productId;
  BigInt _amount;

  OrderData(this._productId, this._amount);

  @override
  String toString() {
    return 'OrderData: {_productId: $_productId, _amount: $_amount}';
  }
}