import 'package:assignment3/Tree.dart';
import 'package:test/test.dart';

void main() {
  group('checking add node function', () {
    test('add node function works correctly', () {
      Tree tree = Tree();
      expect(tree.addNode('1', 'test'), 'Node Added');
    });

    test(
        'add node function works correctly when input with existing id is given',
        () {
      Tree tree = Tree();
      tree.addNode('1', 'test1');
      expect(tree.addNode('1', 'test2'), 'Node with id 1 already exists');
    });
  });

  group('checking remove node function', () {
    test('remove node function works correctly', () {
      Tree tree = Tree();
      tree.addNode('1', 'test');
      expect(tree.removeNode('1'), 'Node removed');
    });

    test('remove node function works correctly for invalid id', () {
      Tree tree = Tree();
      expect(tree.removeNode('1'), 'Enter valid existing node id');
    });
  });

  group('checking add dependency function', () {
    test('add dependency function works correctly', () {
      Tree tree = Tree();
      tree.addNode('1', 'test1');
      tree.addNode('2', 'test2');
      expect(tree.addDependency('1', '2'), 'Dependency Added');
    });

    test('add dependency function works correctly for non existing ids', () {
      Tree tree = Tree();
      expect(tree.addDependency('1', '2'), 'Enter valid node ids');
    });

    test(
        'add dependency function works correctly when already existing dependency is entered',
        () {
      Tree tree = Tree();
      tree.addNode('1', 'test1');
      tree.addNode('2', 'test2');
      tree.addDependency('1', '2');
      expect(tree.addDependency('1', '2'), 'Dependency already exists');
    });

    test(
        'add dependency function works correctly when input denpendency creates a cycle',
        () {
      Tree tree = Tree();
      tree.addNode('1', 'test1');
      tree.addNode('2', 'test2');
      tree.addDependency('1', '2');
      expect(tree.addDependency('2', '1'), 'This is an invalid dependency');
    });
  });

  group('checking remove dependency function', () {
    test('remove dependency function works correctly', () {
      Tree tree = Tree();
      tree.addNode('1', 'test1');
      tree.addNode('2', 'test2');
      tree.addDependency('1', '2');
      expect(tree.removeDependency('1', '2'), 'Dependency Removed');
    });

    test(
        'remove dependency function works correctly for non existing dependency',
        () {
      Tree tree = Tree();
      tree.addNode('1', 'test1');
      tree.addNode('2', 'test2');
      tree.addDependency('1', '2');
      expect(tree.removeDependency('2', '1'),
          'Seems the dependancy entered doesn\'t exist');
    });

    test('remove dependency function works correctly for invalid id', () {
      Tree tree = Tree();
      expect(tree.removeDependency('1', '2'), 'Enter valid node ids');
    });
  });

  group('checking get parent function', () {
    test('get parent function works correctly', () {
      Tree tree = Tree();
      tree.addNode('1', 'test1');
      tree.addNode('2', 'test2');
      tree.addDependency('1', '2');
      expect(tree.getParents('2'), ['1']);
    });

    test('get parent function works correctly for invalid input', () {
      Tree tree = Tree();
      expect(() => {tree.getParents('2')}, throwsException);
    });
  });

  group('checking get children function', () {
    test('get children function works correctly', () {
      Tree tree = Tree();
      tree.addNode('1', 'test1');
      tree.addNode('2', 'test2');
      tree.addDependency('1', '2');
      expect(tree.getChildren('1'), ['2']);
    });

    test('get children function works correctly for invalid input', () {
      Tree tree = Tree();
      expect(() => {tree.getChildren('2')}, throwsException);
    });
  });

  group('checking get ancestor function', () {
    test('get ancestor function works correctly', () {
      Tree tree = Tree();
      tree.addNode('1', 'test1');
      tree.addNode('2', 'test2');
      tree.addNode('3', 'test3');
      tree.addDependency('1', '2');
      tree.addDependency('2', '3');
      expect(tree.getAncestors('3'), ['1', '2']);
    });
  });

  group('checking get descendants function', () {
    test('get descendants function works correctly', () {
      Tree tree = Tree();
      tree.addNode('1', 'test1');
      tree.addNode('2', 'test2');
      tree.addNode('3', 'test3');
      tree.addDependency('1', '2');
      tree.addDependency('2', '3');
      expect(tree.getDescendants('1'), ['2', '3']);
    });
  });
}
