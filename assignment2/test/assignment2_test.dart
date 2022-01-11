import 'package:assignment2/users_details.dart';
import 'package:test/test.dart';

void main() {
  group('testing add user function', () {
    test('add user function works correctly', () {
      UsersDetails users = UsersDetails([]);
      expect(users.addUser('test', '1', '1', 'test', 'A B C D'),
          '\n User added!!\n');
    });

    test('add user function works correctly for repeated roll number', () {
      UsersDetails users = UsersDetails([]);
      users.addUser('test', '1', '1', 'test', 'A B C D');
      expect(users.addUser('test1', '1', '1', 'test', 'A B C D'),
          '\n It seems the roll number you entered already exists\n');
    });

    test('add user function works correctly for blank name', () {
      UsersDetails users = UsersDetails([]);
      expect(() => {users.addUser('', '1', '1', 'test', 'A B C D')},
          throwsException);
    });

    test('add user function works correctly for invalid age', () {
      UsersDetails users = UsersDetails([]);
      expect(() => {users.addUser('test', '1faef', '1', 'test', 'A B C D')},
          throwsException);
    });

    test('add user function works correctly for invalid roll number', () {
      UsersDetails users = UsersDetails([]);
      expect(() => {users.addUser('test', '1', '1lwkaf', 'test', 'A B C D')},
          throwsException);
    });

    test('add user function works correctly for invalid address', () {
      UsersDetails users = UsersDetails([]);
      expect(() => {users.addUser('test', '1', '1', '', 'A B C D')},
          throwsException);
    });

    test('add user function works correctly for invalid courses', () {
      UsersDetails users = UsersDetails([]);
      expect(() => {users.addUser('test', '1', '1', 'test', 'A B C Z')},
          throwsException);
    });

    test('add user function works correctly for invalid courses', () {
      UsersDetails users = UsersDetails([]);
      expect(() => {users.addUser('test', '1', '1', 'test', 'A B C A')},
          throwsException);
    });
  });

  group('testing remove user function', () {
    test('remove user function works correctly', () {
      UsersDetails users = UsersDetails([]);
      users.addUser('test', '1', '1', 'test', 'A B C D');
      expect(users.removeUser('1'), '\n User deleted!! \n');
    });

    test('add user function works correctly for non existing roll number', () {
      UsersDetails users = UsersDetails([]);
      expect(users.removeUser('1'), '\n Enter a valid roll number. \n');
    });
  });

  group('testing load stored data function', () {
    test('load stored data function works correctly', () async {
      UsersDetails users = UsersDetails(await UsersDetails.loadStoredData());
      expect(users.checkExistingRollNumber(1), true);
    });

    test('load stored data function works correctly', () async {
      UsersDetails users = UsersDetails(await UsersDetails.loadStoredData());
      expect(users.checkExistingRollNumber(2), false);
    });
  });

  group('testing load stored data function', () {
    test('load stored data function works correctly', () async {
      UsersDetails users = UsersDetails(await UsersDetails.loadStoredData());
      expect(users.saveUsers(), '\n Details saved successfully\n');
    });
  });
}
