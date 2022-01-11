import 'dart:convert';
import 'dart:io';
import 'package:assignment2/user.dart';
import 'package:tabular/tabular.dart';

class UsersDetails {
  final List _usersDetails;

  UsersDetails(this._usersDetails);

  static Future<List> loadStoredData() async {
    List usersDetails = [];

    //retriving user details as string converting it to base64 then to utf8 then to json
    var userDetails = await File("./lib/storage/storage.txt").readAsString();
    var userDetailsBase64 = base64.decode(userDetails);
    var userDetailsUtf8 = utf8.decode(userDetailsBase64);
    var userDetailsJson = jsonDecode(userDetailsUtf8);

    //generating user objects from json and adding to in memory state
    userDetailsJson.forEach((userDetail) {
      User user = createUser(
          userDetail['fullName'],
          userDetail['age'],
          userDetail['rollNumber'],
          userDetail['address'],
          userDetail['courses']);
      usersDetails.add(user);
    });

    return usersDetails;
  }

  //function to create a User object from the user input in string format
  static User createUser(String fullName, String age, String rollNumber,
      String address, String courses) {
    String userFullName = User.validateName(fullName);
    int userAge = User.validateAge(age);
    int userRollNumber = User.validateRollNumber(rollNumber);
    String userAddress = User.validateAddress(address);
    Set userCourses = User.validateCourses(courses);

    return User(
        userFullName, userAge, userRollNumber, userAddress, userCourses);
  }

  String addUser(String fullName, String age, String rollNumber, String address,
      String courses) {
    User user = createUser(fullName, age, rollNumber, address, courses);
    if (checkExistingRollNumber(user.rollNumber)) {
      return '\n It seems the roll number you entered already exists\n';
    } else {
      _usersDetails.add(user);

      //sorting user on the basis of name after adding new user.
      _usersDetails.sort((a, b) => User.compareUsers(a, b, '1'));
      return '\n User added!!\n';
    }
  }

  void displayUser() {
    print('\n1. Sort based on name');
    print('2. Sort based on age');
    print('3. Sort based on roll number');
    print('4. Sort based on address \n');
    print('Enter a choice:');
    String sortBy = stdin.readLineSync()!;

    print(
        '\nEnter A to sort in ascending order or D to sort in descending order.');
    String sortIn = stdin.readLineSync()!;

    //sorting data based on user input.
    if (sortIn == 'A') {
      _usersDetails.sort((a, b) => User.compareUsers(a, b, sortBy));
    } else {
      _usersDetails.sort((a, b) => User.compareUsers(b, a, sortBy));
    }

    List<List> userData = [
      ['Name', 'Roll Number', 'Age', 'Address', 'Courses']
    ];

    _usersDetails.forEach((user) {
      String userCourses = user.courses.join(', ');
      List userList = [
        user.fullName,
        user.rollNumber,
        user.age,
        user.address,
        userCourses
      ];
      userData.add(userList);
    });
    var tabularData = tabular(userData);

    print(tabularData);
  }

  //function to remove a user from in memory structure
  String removeUser(String rollNumber) {
    int userRollNumber = User.validateRollNumber(rollNumber);
    if (checkExistingRollNumber(userRollNumber)) {
      _usersDetails.removeWhere((user) => user.rollNumber == userRollNumber);
      return '\n User deleted!! \n';
    } else {
      return '\n Enter a valid roll number. \n';
    }
  }

  String saveUsers() {
    //converting list of object to base 64
    String jsonUserDetails = jsonEncode(_usersDetails);
    var utfUserDetails = utf8.encode(jsonUserDetails);
    var encoded1 = base64.encode(utfUserDetails);
    File("./lib/storage/storage.txt").writeAsStringSync(encoded1);
    return '\n Details saved successfully\n';
  }

  //function to check if user wants to save info.
  void exitApplication() {
    print('\nDo you want to save the changes you made? Enter Y or N.\n');
    String choice = stdin.readLineSync()!;
    if (choice == 'Y') {
      saveUsers();
    }
  }

  //checking if a roll number already exists in memory
  bool checkExistingRollNumber(int rollNumber) {
    if ((_usersDetails.where((user) => user.rollNumber == rollNumber)).length ==
        1) {
      return true;
    }
    return false;
  }
}
