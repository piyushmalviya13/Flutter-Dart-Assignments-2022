import 'dart:collection';
import 'dart:math';

import 'package:assignment4/services/db_service.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactListViewModel extends ChangeNotifier {
  List<Contact> _contacts = [];
  List<Contact>? _filteredContacts;

  PermissionStatus? _contactPermission;
  int _identifier = 1;

  ContactListViewModel() {
    if (ContactBox.instance.checkDataInHive()) {
      _getContactsFromHiveStorage();
    } else {
      _getContactsFromStorage();
    }
  }

  PermissionStatus? get getPermissionStatus => _contactPermission;

  UnmodifiableListView<Contact> get getContacts =>
      UnmodifiableListView(_filteredContacts ?? _contacts);

  void _getContactsFromHiveStorage() async {
    _contactPermission = await Permission.contacts.request();
    _contacts.clear();
    _contacts.addAll(ContactBox.instance.getContactsFromHiveStorage());
    _sortContactList();
    _setIdentifier();
    notifyListeners();
  }

  void _getContactsFromStorage() async {
    _contactPermission = await Permission.contacts.request();
    if (_contactPermission == PermissionStatus.granted) {
      _contacts = await ContactsService.getContacts();
      ContactBox.instance.saveToHiveStorage(_contacts);
    }
    _sortContactList();
    _setIdentifier();
    notifyListeners();
  }

  //function to set identifier for the application based on the contacts imported from phone storage
  void _setIdentifier() {
    int maxValue = 0;
    for (Contact contact in _contacts) {
      maxValue = max(int.parse(contact.identifier!), maxValue);
    }
    _identifier = maxValue + 1;
  }

  void _incrementIdentifier() {
    _identifier += 1;
  }

  void _sortContactList() {
    _contacts.sort((a, b) =>
        a.displayName!.toLowerCase().compareTo(b.displayName!.toLowerCase()));
  }

  String generateIdentifierForContact() {
    return "$_identifier";
  }

  void addContact(Contact contact) {
    _contacts.add(contact);
    _incrementIdentifier();
    ContactBox.instance.saveToHiveStorage(_contacts);
    _sortContactList();
    filterContacts('');
    notifyListeners();
  }

  void removeContact(String identifier) {
    _contacts.removeWhere((contact) => contact.identifier == identifier);
    ContactBox.instance.saveToHiveStorage(_contacts);
    filterContacts('');
    notifyListeners();
  }

  void updateContact(Contact updatedContact) {
    removeContact(updatedContact.identifier!);
    addContact(updatedContact);
    ContactBox.instance.saveToHiveStorage(_contacts);
    _sortContactList();
    filterContacts('');
    notifyListeners();
  }

  void filterContacts(String query) {
    List<Contact> filtered = _contacts
        .where((contact) =>
            contact.displayName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (_filteredContacts == null) {
      _filteredContacts = filtered;
    } else {
      _filteredContacts!.clear();
      _filteredContacts!.addAll(filtered);
    }
    notifyListeners();
  }
}
