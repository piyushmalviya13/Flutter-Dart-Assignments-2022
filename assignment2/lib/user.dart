class User {
  late String _fullName;
  late int _age;
  late int _rollNumber;
  late String _address;
  late Set _courses;
  final validCourses = {'A', 'B', 'C', 'D', 'E', 'F'};

  User(String fullName, String age, String rollNumber, String address,
      String courses) {
    _fullName = validateName(fullName);
    _age = validateAge(age);
    _rollNumber = validateRollNumber(rollNumber);
    _address = validateAddress(address);
    _courses = validateCourses(courses);
  }

  //constructor for creating object using json
  User.fromJson(dynamic json) {
    _fullName = validateName(json['fullName']);
    _age = validateAge(json['age']);
    _rollNumber = validateRollNumber(json['rollNumber']);
    _address = validateAddress(json['address']);
    _courses = validateCourses(json['courses']);
  }

  String get fullName => _fullName;

  int get age => _age;

  Set get courses => _courses;

  String get address => _address;

  int get rollNumber => _rollNumber;

  String validateName(String name) {
    if (name.isEmpty) {
      throw Exception('Please enter valid name\n');
    }
    return name;
  }

  int validateAge(String age) {
    int? validAge = int.tryParse(age);
    if ((validAge ?? 0) <= 0) {
      throw Exception('Please enter valid age\n');
    }
    return validAge!;
  }

  static int validateRollNumber(String rollNumber) {
    int? validRollNumber = int.tryParse(rollNumber);
    if ((validRollNumber ?? 0) <= 0) {
      throw Exception('Please enter valid roll number\n');
    }
    return validRollNumber!;
  }

  String validateAddress(String address) {
    if (address.isEmpty) {
      throw Exception('Please enter valid name\n');
    }
    return address;
  }

  //function to convert courses from string to set and checking for repeated course and in valid courses
  Set validateCourses(String courses) {
    Set userCourses = {};

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
