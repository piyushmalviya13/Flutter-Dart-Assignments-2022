import 'package:assignment1/item.dart';

class RawItem extends Item {
  RawItem(String name, double price, int quantity)
      : super(name, price, quantity);

  final rawTaxCharge = 0.125;

  @override
  double calculateTax() {
    double taxAmount = rawTaxCharge * price;
    return taxAmount;
  }
}
