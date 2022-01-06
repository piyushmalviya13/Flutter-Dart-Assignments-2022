import 'dart:io';
import 'package:assignment1/item.dart';
import 'package:assignment1/checkValidInput.dart';

void main() {
  String choice = 'y';
  while (choice == 'y') {
    print(
        '---------------------------------------------------------------------------------------------------------------------------------------------');
    print(
        '\nPlease enter the items in the format below separating each property with a comma\n');
    print(
        '-name <item name>,-price <item price>,-quantity <item quantity>,-type <item type>\n');
    print(
        'The item type can be any of the following 1.raw 2.manufactured 3.imported\n');
    String inputItem = stdin.readLineSync()!;
    if (checkValidInput(inputItem)) {
      Item item = returnItemObject(inputItem);
      item.calculateTax();
      print(
          "\nThe ${item.getType()} item ${item.getName()} is priced at ${item.getPrice()} and for quantity ${item.getQuantity()} will be taxed amount ${item.getTaxAmount()} per  => Total Amount: ${item.getTotalAmount()}\n");
      print(
          '---------------------------------------------------------------------------------------------------------------------------------------------');
      print("Do you want to enter details of any other item (y/n): ");
      choice = stdin.readLineSync()!;
    } else {
      print('\nPlease enter the details in a valid format\n');
      print(
          '---------------------------------------------------------------------------------------------------------------------------------------------');
    }
  }
  print("\nThanks For Visiting\n");
}
