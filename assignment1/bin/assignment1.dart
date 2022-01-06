import 'dart:io';
import 'package:assignment1/item.dart';
import 'package:assignment1/checkValidInput.dart';

void main() {
  String choice = 'y';
  while (choice == 'y') {
    print(
        'Please enter the items in the format below separating each property with a comma');
    print(
        'name <item name>,price <item price>,quantity <item quantity>,type <item type>');
    print(
        'The item type can be any of the following 1.raw 2.manufactured 3.imported');
    String inputItem = stdin.readLineSync()!;
    if (checkValidInput(inputItem)) {
      // Item item = getInputItem();
    } else {
      print('Please enter the details in a valid format');
    }
  }
}
