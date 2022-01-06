import './item.dart';

List splitStringByComma(String input) {
  return input.split(',');
}

bool checkValidInput(String input) {
  List splitInput = splitStringByComma(input);

  //checking if all 4 details are provided or not and the first detail is item name.
  if (splitInput.length != 4 || splitInput[0].split(' ')[0] != '-name') {
    return false;
  }

  bool priceFound = false, quantityFound = false, typeFound = false;
  String price = '', quanity = '', type = '';

  //checking if all 3 details price, quantity and type are provided or not.
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
      //checking if type is from raw, manufactured and imported only.
      if (type != 'raw' && type != 'manufactured' && type != 'imported') {
        return false;
      }
    }
  }

  if (priceFound && quantityFound && typeFound) {
    //checking if integer values for price and quantity are provided.
    try {
      double.parse(price);
      int.parse(quanity);
    } catch (e) {
      return false;
    }
    return true;
  } else {
    return false;
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
