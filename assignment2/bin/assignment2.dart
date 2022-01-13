import 'dart:io';
import 'package:assignment2/users_details.dart';
import 'package:tabular/tabular.dart';

void main() async {
  String choice = '0';
  UsersDetails usersDetails = UsersDetails(await UsersDetails.loadUsers());
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
          print('\n1. Sort based on name');
          print('2. Sort based on age');
          print('3. Sort based on roll number');
          print('4. Sort based on address \n');
          print('Enter a choice:');

          String sortBy = stdin.readLineSync()!;
          if (sortBy != '1' &&
              sortBy != '2' &&
              sortBy != '3' &&
              sortBy != '4') {
            throw Exception('Enter a valid choice');
          }
          print(
              '\nEnter A to sort in ascending order or D to sort in descending order.');
          String sortIn = stdin.readLineSync()!;
          if (sortIn != 'A' && sortIn != 'D') {
            throw Exception('Enter a valid choice');
          }
          var tabularData = tabular(usersDetails.displayUser(sortBy, sortIn));
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
          print('\nDo you want to save the changes you made? Enter Y or N.\n');
          String choice = stdin.readLineSync()!;
          if (choice == 'Y') {
            usersDetails.saveUsers();
          }
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
