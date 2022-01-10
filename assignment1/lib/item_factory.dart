import 'package:assignment1/imported_item.dart';
import 'package:assignment1/item.dart';
import 'package:assignment1/manufactured_item.dart';
import 'package:assignment1/raw_item.dart';
import 'package:assignment1/utility.dart';

class ItemFactory {
  static Item itemFactory(
      String name, double price, int quantity, ItemTypes type) {
    late Item item;
    switch (type) {
      case ItemTypes.raw:
        item = RawItem(name, price, quantity);
        break;
      case ItemTypes.manufactured:
        item = ManufacturedItem(name, price, quantity);
        break;
      case ItemTypes.imported:
        item = ImportedItem(name, price, quantity);
        break;
    }
    return item;
  }
}
