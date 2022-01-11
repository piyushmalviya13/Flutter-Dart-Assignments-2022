import 'package:assignment1/model/item.dart';
import 'package:assignment1/item_factory.dart';
import 'package:assignment1/utility.dart';
import 'package:test/test.dart';

void main() {
  test('program works correctly for raw type', () {
    Item testItem = ItemFactory.itemFactory('apple', 25.00, 10, ItemTypes.raw);
    expect(testItem.calculateTax(), 3.125);
  });
  test('program works correctly for manufactured type', () {
    Item testItem =
        ItemFactory.itemFactory('shoe', 300.00, 10, ItemTypes.manufactured);
    expect(testItem.calculateTax(), 44.25);
  });
  test('program works correctly for imported type', () {
    Item testItem =
        ItemFactory.itemFactory('purse', 1000.00, 10, ItemTypes.imported);
    expect(testItem.calculateTax(), 155.0);
  });

  test('program works correctly for imported type', () {
    Item testItem =
        ItemFactory.itemFactory('purse', 50.00, 10, ItemTypes.imported);
    expect(testItem.calculateTax(), 10.0);
  });

  test('program works correctly for imported type', () {
    Item testItem =
        ItemFactory.itemFactory('purse', 100.00, 10, ItemTypes.imported);
    expect(testItem.calculateTax(), 20.0);
  });

  test('program works correctly when input is blank', () {
    expect(() => UtilityFunctions.validateInput(''), throwsException);
  });

  test('validateInput works correctly when input is not in correct order', () {
    expect(
        () => UtilityFunctions.validateInput(
            '-type raw -name apple -price 25.00 -quantity 10'),
        throwsException);
  });

  test('validateInput works correctly when incorrect parameters are provides',
      () {
    expect(
        () => UtilityFunctions.validateInput(
            '-name apple -price 25.00 -quantity 10 -what raw'),
        throwsException);
  });

  test('validateInput works correctly for negative price', () {
    expect(
        () => UtilityFunctions.validateInput(
            '-name apple -price -25.00 -quantity 10 -type raw'),
        throwsException);
  });

  test('validateInput works correctly for negative quanity', () {
    expect(
        () => UtilityFunctions.validateInput(
            '-name apple -price 25.00 -quantity -10 -what raw'),
        throwsException);
  });

  test('validateInput works correctly for correct inputs', () {
    expect(
        UtilityFunctions.validateInput(
            '-name apple -price 25.00 -quantity 10 -type raw'),
        {'-name': 'apple', '-price': 25.0, '-quantity': 10, '-type': 'raw'});
  });

  test('validateInput works correctly when parameters are repeated', () {
    expect(
        () => UtilityFunctions.validateInput(
            '-name apple -price 25.00 -type raw 10 -type raw'),
        throwsException);
  });

  test('ItemType works correctly for raw type', () {
    expect(UtilityFunctions.returnItemType('raw'), ItemTypes.raw);
  });

  test('ItemType works correctly for manufactured type', () {
    expect(UtilityFunctions.returnItemType('manufactured'),
        ItemTypes.manufactured);
  });

  test('ItemType works correctly for imported type', () {
    expect(UtilityFunctions.returnItemType('imported'), ItemTypes.imported);
  });

  test('ItemType works correctly for unknown type', () {
    expect(() => UtilityFunctions.returnItemType('bleh'), throwsException);
  });

  test('getter works correctly', () {
    Item testItem = ItemFactory.itemFactory('apple', 25.00, 10, ItemTypes.raw);
    expect(testItem.name, 'apple');
  });

  test('getter works correctly', () {
    Item testItem = ItemFactory.itemFactory('apple', 25.00, 10, ItemTypes.raw);
    expect(testItem.price, 25.0);
  });

  test('getter works correctly', () {
    Item testItem = ItemFactory.itemFactory('apple', 25.00, 10, ItemTypes.raw);
    expect(testItem.quantity, 10);
  });
}
