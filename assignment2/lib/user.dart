class User {
  String _fullname;
  int _age;
  int _rollNumber;
  String _address;
  Set<String> _courses;

  User(this._fullname, this._age, this._rollNumber, this._address,
      this._courses);

  String get fullName => _fullname;

  int get age => _age;

  int get rollNumber => _rollNumber;

  String get address => _address;

  Set<String> get courses => _courses;

  static bool validateName() {
    return true;
  }

  static bool validateAge() {
    return true;
  }

  static bool validateRollNumber() {
    return true;
  }

  static bool validateAddress() {
    return true;
  }

  static bool validateCourses() {
    return true;
  }
}
