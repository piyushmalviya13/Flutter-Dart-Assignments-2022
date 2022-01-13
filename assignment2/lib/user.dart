class User {
  final String _fullName;
  final String _age;
  final String _rollNumber;
  final String _address;
  final String _courses;
  final validCourses = {'A', 'B', 'C', 'D', 'E', 'F'};

  User(this._fullName, this._age, this._rollNumber, this._address,
      this._courses);

  //constructor for creating object using json
  factory User.fromJson(dynamic json) {
    return User(json['fullName'], json['age'], json['rollNumber'],
        json['address'], json['courses']);
  }

  String get fullName => _fullName;

  int get age => int.parse(_age);

  String get courses => _courses;

  String get address => _address;

  int get rollNumber => int.parse(_rollNumber);

  void validateUser() {
    if (_fullName.isEmpty) {
      throw Exception('Please enter valid name\n');
    }
    if ((int.tryParse(_age) ?? 0) <= 0) {
      throw Exception('Please enter valid age\n');
    }
    if ((int.tryParse(_rollNumber) ?? 0) <= 0) {
      throw Exception('Please enter valid roll number\n');
    }
    if (_address.isEmpty) {
      throw Exception('Please enter valid address\n');
    }
    if (!validateCourses(_courses)) {
      throw Exception('Enter valid courses\n');
    }
  }

  //function to convert courses from string to set and checking for repeated course and in valid courses
  bool validateCourses(String courses) {
    Set userCourses = {};

    var coursesList = courses.split(' ');

    for (String course in coursesList) {
      if (validCourses.contains(course)) {
        userCourses.add(course);
      } else {
        print('Enter valid course name\n');
        return false;
      }
    }

    if (userCourses.length != 4) {
      print('Enter 4 courses and Don\'t repeat courses\n');
      return false;
    }

    return true;
  }

  static int compareUsers(User user1, User user2, String sortBy) {
    if (sortBy == '1') {
      int comparisonResult = user1._fullName
          .toLowerCase()
          .compareTo(user2._fullName.toLowerCase());
      if (comparisonResult == 0) {
        return user1.rollNumber.compareTo(user2.rollNumber);
      } else {
        return comparisonResult;
      }
    } else if (sortBy == '2') {
      return user1.age.compareTo(user2.age);
    } else if (sortBy == '3') {
      return user1.rollNumber.compareTo(user2.rollNumber);
    } else {
      return user1._address
          .toLowerCase()
          .compareTo(user2._address.toLowerCase());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "fullName": _fullName,
      "age": _age,
      "rollNumber": _rollNumber,
      "address": _address,
      "courses": _courses
    };
  }
}
