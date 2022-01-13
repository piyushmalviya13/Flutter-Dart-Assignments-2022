import 'dart:io';

import 'package:assignment3/assignment3.dart' as assignment3;

void main() {
  String choice = stdin.readLineSync()!;
  while (choice != '9') {
    try {
      print('\n1. Get parents of a node');
      print('2. Get children of a node');
      print('3. Get ancestors of a node');
      print('4. Get descendants of a node');
      print('5. Delete a dependency from tree');
      print('6. Delete node from tree');
      print('7. Add new dependency to the tree');
      print('8. Add new node to the tree');
      print('9. Exit\n');

      print('Enter a choice:');
      choice = stdin.readLineSync()!;
      switch (choice) {
        case '1':
          break;
        case '2':
          break;
        case '3':
          break;
        case '4':
          break;
        case '5':
          break;
        default:
          break;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
