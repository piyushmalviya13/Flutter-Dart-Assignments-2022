import 'package:assignment1/model/item_types_model/imported_item.dart';
import 'package:assignment1/model/item.dart';
import 'package:assignment1/model/item_types_model/manufactured_item.dart';
import 'package:assignment1/model/item_types_model/raw_item.dart';
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
