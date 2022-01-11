import 'package:assignment1/model/item.dart';

class ManufacturedItem extends Item {
  ManufacturedItem(String name, double price, int quantity)
      : super(name, price, quantity);

  final rawTaxCharge = 0.125, manufacuredTaxCharge = 0.02;

  @override
  double calculateTax() {
    double taxAmount = rawTaxCharge * price +
        (manufacuredTaxCharge * (price + rawTaxCharge * price));
    return taxAmount;
  }
}
