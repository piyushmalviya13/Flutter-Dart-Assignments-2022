enum ItemTypes { raw, manufactured, imported }

class UtilityFunctions {
  static Map validateInput(String input) {
    List splitedInput = input.split(' ');

    //checking if all 4 parameter and their values are provided and first parameter is name.
    if (splitedInput.length != 8) {
      throw Exception('Enter all four parameters');
    }
    if (splitedInput[0] != '-name') {
      throw Exception('Make sure first parameter is name');
    }

    Map formattedInput = Map();
    bool priceFound = false, quantityFound = false, typeFound = false;

    //assigning values to the parameters in the map and checking if wrong parameters are provided.
    for (int index = 0; index < 8; index += 2) {
      if (splitedInput[index] == '-name') {
        formattedInput[splitedInput[index]] = splitedInput[index + 1];
      } else if (splitedInput[index] == '-price') {
        formattedInput[splitedInput[index]] =
            double.parse(splitedInput[index + 1]);
        priceFound = true;
      } else if (splitedInput[index] == '-quantity') {
        formattedInput[splitedInput[index]] =
            int.parse(splitedInput[index + 1]);
        quantityFound = true;
      } else if (splitedInput[index] == '-type') {
        formattedInput[splitedInput[index]] = splitedInput[index + 1];
        typeFound = true;
      } else {
        throw Exception('Please enter valid parameters');
      }
    }
    //checking if all the parameters are provided and none are repeated.
    if (!priceFound || !quantityFound || !typeFound) {
      throw Exception('Please enter all four parameters');
    }
    return formattedInput;
  }

  //function to convert string item types to enum item types.
  static ItemTypes returnItemType(String type) {
    if (type == 'raw') {
      return ItemTypes.raw;
    } else if (type == 'manufactured') {
      return ItemTypes.manufactured;
    } else if (type == 'imported') {
      return ItemTypes.imported;
    } else {
      throw Exception('Non valid item type');
    }
  }
}
