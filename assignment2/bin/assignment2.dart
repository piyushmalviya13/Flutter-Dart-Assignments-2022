import 'dart:io';
import 'package:assignment2/users_details.dart';
import 'package:tabular/tabular.dart';

void main() async {
  String choice = '0';
  UsersDetails usersDetails = UsersDetails(await UsersDetails.loadStoredData());
  while (choice != '5') {
    try {
      print('\n1. Add User Details');
      print('2. Display User Details');
      print('3. Delete User Details');
      print('4. Save User Details');
      print('5. Exit\n');

      print('Enter a choice:');
      choice = stdin.readLineSync()!;
      switch (choice) {
        case '1':
          print('Enter full name:');
          String fullName = stdin.readLineSync()!;
          print('Enter roll number:');
          String rollNumber = stdin.readLineSync()!;
          print('Enter age:');
          String age = stdin.readLineSync()!;
          print('Enter address:');
          String address = stdin.readLineSync()!;
          print(
              'Enter 4 distinct courses from (A, B, C, D, E, F) each separated by a space e.g. A B C D:');
          String courses = stdin.readLineSync()!;
          print(usersDetails.addUser(
              fullName, age, rollNumber, address, courses));
          break;
        case '2':
          var tabularData = tabular(usersDetails.displayUser());
          print(tabularData);
          break;
        case '3':
          print('Enter roll number:');
          String rollNumber = stdin.readLineSync()!;
          print(usersDetails.removeUser(rollNumber));
          break;
        case '4':
          print(usersDetails.saveUsers());
          break;
        case '5':
          usersDetails.exitApplication();
          break;
        default:
          print('Enter valid choice\n');
          break;
      }
    } catch (e) {
      print(e.toString().substring(11));
    }
  }
}
