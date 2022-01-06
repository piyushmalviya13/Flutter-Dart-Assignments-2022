import './item.dart';

List splitStringByComma(String input) {
  return input.split(',');
}

bool checkValidInput(String input) {
  List splitInput = splitStringByComma(input);

  if (splitInput.length != 4 || splitInput[0].split(' ')[0] != '-name') {
    return false;
  }

  bool priceFound = false, quantityFound = false, typeFound = false;
  String price = '', quanity = '', type = '';
  for (String detail in splitInput) {
    if (detail.split(' ')[0] == '-price') {
      priceFound = true;
      price = detail.split(' ')[1];
    } else if (detail.split(' ')[0] == '-quantity') {
      quantityFound = true;
      quanity = detail.split(' ')[1];
    } else if (detail.split(' ')[0] == '-type') {
      typeFound = true;
      type = detail.split(' ')[1];
      if (type != 'raw' && type != 'manufactured' && type != 'imported') {
        return false;
      }
    }
  }

  if (priceFound && quantityFound && typeFound) {
    try {
      double.parse(price);
      int.parse(quanity);
    } catch (e) {
      return false;
    }
    return true;
  } else {
    return true;
  }
}

Item returnItemObject(String input) {
  List splitInput = splitStringByComma(input);

  String price = '', quanity = '', type = '';
  for (String detail in splitInput) {
    if (detail.split(' ')[0] == '-price') {
      price = detail.split(' ')[1];
    } else if (detail.split(' ')[0] == '-quantity') {
      quanity = detail.split(' ')[1];
    } else if (detail.split(' ')[0] == '-type') {
      type = detail.split(' ')[1];
    }
  }

  String itemName = splitInput[0].split(' ')[1];
  double itemPrice = double.parse(price);
  int itemQuantity = int.parse(quanity);

  return Item(itemName, itemPrice, itemQuantity, type);
}
