import 'package:contacts_service/contacts_service.dart';
import 'package:hive/hive.dart';

class ContactBox {
  List<Contact> contactList = [];
  static ContactBox? _instance;

  final Box<dynamic> _db = Hive.box('contacts');
  final String _key = 'contacts';

  static ContactBox get instance {
    _instance ??= ContactBox();
    return _instance!;
  }

  bool checkDataInHive() {
    return _db.containsKey(_key);
  }

  List<Contact> getContactsFromHiveStorage() {
    var contacts = _db.get(_key);
    List<Contact> contactList = [];
    contacts.forEach((contact) {
      contactList.add(Contact.fromMap(contact));
    });
    return contactList;
  }

  void saveToHiveStorage(List<Contact> contacts) {
    var contactsListJson = [];
    for (var contact in contacts) {
      contactsListJson.add(contact.toMap());
    }
    _db.put(_key, contactsListJson);
  }
}
