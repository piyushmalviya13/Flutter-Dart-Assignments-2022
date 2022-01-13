import 'dart:convert';
import 'dart:io';
import 'package:assignment2/user.dart';
import 'package:tabular/tabular.dart';

final storageAddress = './lib/storage/storage.txt';

class UsersDetails {
  final List _usersDetails;

  UsersDetails(this._usersDetails);

  static Future<List> loadUsers() async {
    List usersDetails = [];

    //retriving user details as string converting it to base64 then to utf8 then to json
    var userDetails = await File(storageAddress).readAsString();

    if (userDetails.isNotEmpty) {
      var userDetailsBase64 = base64.decode(userDetails);
      var userDetailsUtf8 = utf8.decode(userDetailsBase64);
      var userDetailsJson = jsonDecode(userDetailsUtf8);

      //generating user objects from json and adding to in memory state
      userDetailsJson.forEach((userDetail) {
        User user = User.fromJson(userDetail);
        usersDetails.add(user);
      });
    }

    return usersDetails;
  }

  String addUser(String fullName, String rollNumber, String age, String address,
      String courses) {
    User user = User(fullName, age, rollNumber, address, courses);
    user.validateUser();
    if (checkExistingRollNumber(user.rollNumber)) {
      return '\n It seems the roll number you entered already exists\n';
    } else {
      _usersDetails.add(user);

      //sorting user on the basis of name after adding new user.
      _usersDetails.sort((a, b) => User.compareUsers(a, b, '1'));
      return '\n User added!!\n';
    }
  }

  List<List> displayUser(String sortBy, String sortIn) {
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
      List userList = [
        user.fullName,
        user.rollNumber,
        user.age,
        user.address,
        user.courses
      ];
      userData.add(userList);
    });
    return userData;
  }

  //function to remove a user from in memory structure
  String removeUser(String rollNumber) {
    int? userRollNumber = int.tryParse(rollNumber);
    if ((userRollNumber ?? 0) <= 0) {
      throw Exception('Please enter valid roll number\n');
    }
    if (checkExistingRollNumber(userRollNumber!)) {
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
    File(storageAddress).writeAsStringSync(encoded1);
    return '\n Details saved successfully\n';
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
