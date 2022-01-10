import 'package:assignment1/item.dart';

class ImportedItem extends Item {
  ImportedItem(String name, double price, int quantity)
      : super(name, price, quantity);

  final importedTaxCharge = 0.1,
      surchargeUpto100 = 5.0,
      surchargeUpto200 = 10.0,
      surchargeAbove200 = 0.05;

  @override
  double calculateTax() {
    double taxAmount = importedTaxCharge * price;
    double surcharge = 0;
    double totalAmount = price + taxAmount;
    if (totalAmount <= 100.00) {
      surcharge = surchargeUpto100;
    } else if (totalAmount <= 200.00) {
      surcharge = surchargeUpto200;
    } else {
      surcharge = surchargeAbove200 * totalAmount;
    }
    taxAmount += surcharge;
    return taxAmount;
  }
}
