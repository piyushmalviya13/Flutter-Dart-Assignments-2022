class Item {
  String _name;
  double _price;
  int _quantity;
  String _type;
  double _taxAmount = 0.0;

  Item(this._name, this._price, this._quantity, this._type);

  String getName() {
    return _name;
  }

  double getPrice() {
    return _price;
  }

  int getQuantity() {
    return _quantity;
  }

  String getType() {
    return _type;
  }

  double getTaxAmount() {
    return _taxAmount;
  }

  double getTotalAmount() {
    return (_price + _taxAmount) * _quantity;
  }

  void calculateTax() {
    if (_type == 'raw') {
      _taxAmount = 0.125 * _price;
    } else if (_type == 'manufactured') {
      _taxAmount = 0.125 * _price + (0.02 * (_price + 0.125 * _price));
    } else if (_type == 'imported') {
      _taxAmount = 0.1 * _price;
      double surcharge = 0;
      double totalAmount = _price + _taxAmount;
      if (totalAmount <= 100) {
        surcharge = 5;
      } else if (totalAmount <= 200) {
        surcharge = 10;
      } else {
        surcharge = 0.05 * totalAmount;
      }
      _taxAmount += surcharge;
    }
  }
}
