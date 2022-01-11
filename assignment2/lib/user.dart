class User {
  final String _fullName;
  final int _age;
  final int _rollNumber;
  final String _address;
  final Set _courses;

  User(this._fullName, this._age, this._rollNumber, this._address,
      this._courses);

  String get fullName => _fullName;

  int get age => _age;

  Set get courses => _courses;

  String get address => _address;

  int get rollNumber => _rollNumber;

  static String validateName(String name) {
    if (name == '') {
      throw Exception('Please enter valid name\n');
    }
    return name;
  }

  static int validateAge(String age) {
    int? validAge = int.tryParse(age);
    if (validAge == null || validAge <= 0) {
      throw Exception('Please enter valid age\n');
    }
    return validAge;
  }

  static int validateRollNumber(String rollNumber) {
    int? validRollNumber = int.tryParse(rollNumber);
    if (validRollNumber == null || validRollNumber <= 0) {
      throw Exception('Please enter valid roll number\n');
    }
    return validRollNumber;
  }

  static String validateAddress(String address) {
    if (address == '') {
      throw Exception('Please enter valid name\n');
    }
    return address;
  }

  //function to convert courses from string to set and checking for repeated course and in valid courses
  static Set validateCourses(String courses) {
    Set validCourses = {'A', 'B', 'C', 'D', 'E', 'F'}, userCourses = {};

    courses.split(' ').forEach((course) {
      if (validCourses.contains(course)) {
        userCourses.add(course);
      } else {
        throw Exception('Enter valid course name\n');
      }
    });

    if (userCourses.length != 4) {
      throw Exception('Enter 4 courses and Don\'t repeat courses\n');
    }

    return userCourses;
  }

  static int compareUsers(User user1, User user2, String sortBy) {
    if (sortBy == '1') {
      var comparisonResult = user1._fullName.compareTo(user2._fullName);
      if (comparisonResult != 0) {
        return comparisonResult;
      }
      return user1._rollNumber.compareTo(user2._rollNumber);
    } else if (sortBy == '2') {
      return user1._rollNumber.compareTo(user2._rollNumber);
    } else if (sortBy == '3') {
      return user1._age.compareTo(user2._age);
    } else {
      return user1._address.compareTo(user2._address);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "fullName": _fullName,
      "age": _age.toString(),
      "rollNumber": _rollNumber.toString(),
      "address": _address,
      "courses": _courses.join(' ')
    };
  }
}
