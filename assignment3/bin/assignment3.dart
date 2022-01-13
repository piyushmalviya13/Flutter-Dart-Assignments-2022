import 'dart:io';

import 'package:assignment3/Tree.dart';

void main() {
  Tree tree = Tree();
  String choice = '';
  while (choice != '10') {
    try {
      print('\n1. Get all nodes in tree');
      print('2. Get parents of a node');
      print('3. Get children of a node');
      print('4. Get ancestors of a node');
      print('5. Get descendants of a node');
      print('6. Delete a dependency from tree');
      print('7. Delete node from tree');
      print('8. Add new dependency to the tree');
      print('9. Add new node to the tree');
      print('10. Exit\n');

      print('Enter a choice:');
      choice = stdin.readLineSync()!;
      switch (choice) {
        case '1':
          tree.getNodeIds().forEach((id) {
            print(id);
          });
          break;
        case '2':
          print('Enter node id: ');
          String input = stdin.readLineSync()!;
          tree.getParents(input).forEach((node) {
            print(node);
          });
          break;
        case '3':
          print('Enter node id: ');
          String input = stdin.readLineSync()!;
          tree.getChildren(input).forEach((node) {
            print(node);
          });
          break;
        case '4':
          print('Enter node id: ');
          String input = stdin.readLineSync()!;
          tree.getAncestors(input).forEach((node) {
            print(node);
          });
          break;
        case '5':
          print('Enter node id: ');
          String input = stdin.readLineSync()!;
          tree.getDescendants(input).forEach((node) {
            print(node);
          });
          break;
        case '6':
          print('Enter node id in format `<Parent id> <Child id>` :');
          String input = stdin.readLineSync()!;
          print(
              tree.removeDependency(input.split(' ')[0], input.split(' ')[1]));
          break;
        case '7':
          print('Enter node id: ');
          String input = stdin.readLineSync()!;
          print(tree.removeNode(input));
          break;
        case '8':
          print('Enter node id in format `<Parent id> <Child id>` :');
          String input = stdin.readLineSync()!;
          print(tree.addDependency(input.split(' ')[0], input.split(' ')[1]));
          break;
        case '9':
          print('Enter new node in format `<id> <name>` :');
          String input = stdin.readLineSync()!;
          print(tree.addNode(input.split(' ')[0], input.split(' ')[1]));
          break;
        case '10':
          print('Exiting');
          break;
        default:
          print('Enter valid choice');
          break;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
