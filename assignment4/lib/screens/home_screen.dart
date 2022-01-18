import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Contact> contactList = [];
  @override
  void initState() {
    super.initState();
    getContacts();
  }

  void getContacts() async {
    var contacts = await ContactsService.getContacts();
    setState(() {
      contactList = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
      itemCount: contactList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(contactList[index].displayName!),
          );
        },
      ),
    );
  }
}

