import 'dart:io';
import 'package:assignment1/item.dart';
import 'package:assignment1/item_factory.dart';
import 'package:assignment1/utility.dart';

void main(List<String> args) {
  try {
    String inputItem = args.join(' ');
    String choice = '';
    while (choice != 'n') {
      print(
          '---------------------------------------------------------------------------------------------------------------------------------------------');
      print(
          '\nPlease enter the items in the format below separating each property with a space\n');
      print(
          '-name <item name> -price <item price> -quantity <item quantity> -type <item type>\n');
      print(
          'The item type can be any of the following 1.raw 2.manufactured 3.imported\n');

      if (choice == 'y') {
        inputItem = stdin.readLineSync()!;
      }

      Map formattedInput = UtilityFunctions.validateInput(inputItem);

      //extracting paramters from the formatted input map.
      String name = formattedInput['-name'];
      double price = formattedInput['-price'];
      int quantity = formattedInput['-quantity'];
      ItemTypes type = UtilityFunctions.returnItemType(formattedInput['-type']);

      Item item = ItemFactory.itemFactory(name, price, quantity, type);

      print(
          "\nThe item ${item.name} is priced at ${item.price} and for quantity ${item.quantity} will cost ${(item.price + item.calculateTax()) * item.quantity} after tax\n");
      print(
          '---------------------------------------------------------------------------------------------------------------------------------------------');
      print("Do you want to enter details of any other item (y/n): ");
      choice = stdin.readLineSync()!;
    }
  } catch (e) {
    print(e.toString());
  } finally {
    print("\nThanks For Visiting\n");
  }
}
