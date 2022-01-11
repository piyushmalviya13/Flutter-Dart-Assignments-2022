abstract class Item {
  final String _name;
  final double _price;
  final int _quantity;

  Item(this._name, this._price, this._quantity);

  String get name => _name;

  double get price => _price;

  int get quantity => _quantity;

  double calculateTax();
}
