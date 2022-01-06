import 'package:assignment1/item.dart';
import 'package:test/test.dart';

void main() {
  test('program works correctly for raw type', () {
    Item testItem = Item('Apple', 25.00, 10, 'raw');
    testItem.calculateTax();
    expect(testItem.getTotalAmount(), 281.25);
  });
  test('program works correctly for manufactured type', () {
    Item testItem = Item('Shoe', 300, 10, 'manufactured');
    testItem.calculateTax();
    expect(testItem.getTotalAmount(), 3442.5);
  });
  test('program works correctly for imported type', () {
    Item testItem = Item('Purse', 1000, 10, 'imported');
    testItem.calculateTax();
    expect(testItem.getTotalAmount(), 11550.0);
  });
  // test('program works correctly when input is given in different order', () {
  //   // expect(calculate(), 42);
  // });
  // test('program shows correct behavior when an input field is missing', () {
  //   // expect(calculate(), 42);
  // });
  // test('program works correctly for raw type', () {
  //   // expect(calculate(), 42);
  // });
}
