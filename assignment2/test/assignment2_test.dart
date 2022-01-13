import 'dart:io';

import 'package:assignment2/user.dart';
import 'package:assignment2/users_details.dart';
import 'package:mockito/mockito.dart';
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

    test('add user function works correctly for negative age', () {
      UsersDetails users = UsersDetails([]);
      expect(() => {users.addUser('test', '-1', '1', 'test', 'A B C D')},
          throwsException);
    });

    test('add user function works correctly for invalid roll number', () {
      UsersDetails users = UsersDetails([]);
      expect(() => {users.addUser('test', '1', '1lwkaf', 'test', 'A B C D')},
          throwsException);
    });

    test('add user function works correctly for negative roll number', () {
      UsersDetails users = UsersDetails([]);
      expect(() => {users.addUser('test', '1', '-1', 'test', 'A B C D')},
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

    test('remove user function works correctly for invalid roll number', () {
      UsersDetails users = UsersDetails([]);
      users.addUser('test', '1', '1', 'test', 'A B C D');
      expect(() => {users.removeUser('1affgf')}, throwsException);
    });

    test('remove user function works correctly for non existing roll number',
        () {
      UsersDetails users = UsersDetails([]);
      expect(users.removeUser('1'), '\n Enter a valid roll number. \n');
    });
  });

  group('testing compare users function', () {
    test('comapare function works correctly when compared by name', () {
      User testUser1 = User('testUser1', '20', '1', 'a', 'A B C D');
      User testUser2 = User('testUser2', '21', '2', 'z', 'A B C D');
      expect(User.compareUsers(testUser1, testUser2, '1'), -1);
    });

    test(
        'comapare function works correctly when compared by name but names are same',
        () {
      User testUser1 = User('test', '21', '2', 'a', 'A B C D');
      User testUser2 = User('test', '20', '1', 'a', 'A B C D');
      expect(User.compareUsers(testUser1, testUser2, '1'), 1);
    });

    test('comapare function works correctly when compared by age', () {
      User testUser1 = User('testUser1', '21', '1', 'a', 'A B C D');
      User testUser2 = User('testUser2', '20', '2', 'z', 'A B C D');
      expect(User.compareUsers(testUser1, testUser2, '2'), 1);
    });

    test('comapare function works correctly when compared by roll number', () {
      User testUser1 = User('testUser1', '20', '1', 'a', 'A B C D');
      User testUser2 = User('testUser2', '21', '2', 'z', 'A B C D');
      expect(User.compareUsers(testUser1, testUser2, '3'), -1);
    });

    test('comapare function works correctly when compared by address', () {
      User testUser1 = User('testUser1', '20', '1', 'a', 'A B C D');
      User testUser2 = User('testUser2', '21', '2', 'z', 'A B C D');
      expect(User.compareUsers(testUser1, testUser2, '4'), -1);
    });
  });

  group('testing load stored data function', () {
    test('load stored data function works correctly', () async {
      UsersDetails users = UsersDetails(await UsersDetails.loadUsers());
      expect(users.checkExistingRollNumber(3), false);
    });
  });

  group('testing save user function', () {
    test('save user function works correctly', () async {
      UsersDetails users = UsersDetails(await UsersDetails.loadUsers());
      expect(users.saveUsers(), '\n Details saved successfully\n');
    });
  });

  group('testing display users function', () {
    test(
        'display user function works correctly when sorted by name in ascending order',
        () {
      UsersDetails users = UsersDetails([]);
      users.addUser('test1', '1', '1', 'test1', 'A B C D');
      users.addUser('test2', '2', '2', 'test2', 'A B C D');
      expect(users.displayUser('1', 'A'), [
        ['Name', 'Roll Number', 'Age', 'Address', 'Courses'],
        ['test1', 1, 1, 'test1', 'A B C D'],
        ['test2', 2, 2, 'test2', 'A B C D']
      ]);
    });

    test(
        'display user function works correctly when sorted by name in descending order',
        () {
      UsersDetails users = UsersDetails([]);
      users.addUser('test1', '1', '1', 'test1', 'A B C D');
      users.addUser('test2', '2', '2', 'test2', 'A B C D');
      expect(users.displayUser('1', 'D'), [
        ['Name', 'Roll Number', 'Age', 'Address', 'Courses'],
        ['test2', 2, 2, 'test2', 'A B C D'],
        ['test1', 1, 1, 'test1', 'A B C D']
      ]);
    });

    test(
        'display user function works correctly when sorted by roll number in ascending order',
        () {
      UsersDetails users = UsersDetails([]);
      users.addUser('test1', '11', '1', 'test1', 'A B C D');
      users.addUser('test2', '2', '2', 'test2', 'A B C D');
      expect(users.displayUser('3', 'A'), [
        ['Name', 'Roll Number', 'Age', 'Address', 'Courses'],
        ['test2', 2, 2, 'test2', 'A B C D'],
        ['test1', 11, 1, 'test1', 'A B C D']
      ]);
    });

    test(
        'display user function works correctly when sorted by age in ascending order',
        () {
      UsersDetails users = UsersDetails([]);
      users.addUser('test1', '1', '22', 'test1', 'A B C D');
      users.addUser('test2', '2', '2', 'test2', 'A B C D');
      expect(users.displayUser('2', 'A'), [
        ['Name', 'Roll Number', 'Age', 'Address', 'Courses'],
        ['test2', 2, 2, 'test2', 'A B C D'],
        ['test1', 1, 22, 'test1', 'A B C D']
      ]);
    });

    test(
        'display user function works correctly when sorted by address in descending order',
        () {
      UsersDetails users = UsersDetails([]);
      users.addUser('test1', '1', '1', 'test1', 'A B C D');
      users.addUser('test2', '2', '2', 'test2', 'A B C D');
      expect(users.displayUser('4', 'D'), [
        ['Name', 'Roll Number', 'Age', 'Address', 'Courses'],
        ['test2', 2, 2, 'test2', 'A B C D'],
        ['test1', 1, 1, 'test1', 'A B C D']
      ]);
    });
  });
}
