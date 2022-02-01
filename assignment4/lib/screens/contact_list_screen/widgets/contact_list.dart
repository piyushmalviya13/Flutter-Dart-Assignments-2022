import 'dart:math';

import 'package:assignment4/routes/router.gr.dart';
import 'package:assignment4/screens/contact_list_screen/viewmodel/contact_list_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactList extends StatelessWidget {
  final List<Contact> contactList;
  final addContact;
  final updateContact;

  const ContactList(
      {Key? key,
      required this.contactList,
      required this.addContact,
      required this.updateContact})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return contactList.isEmpty
        ? noContactFound()
        : ListView.builder(
            shrinkWrap: true,
            key: UniqueKey(),
            padding: EdgeInsets.zero,
            itemCount: contactList.length,
            itemBuilder: (_, index) {
              return ListTile(
                key: UniqueKey(),
                onTap: () {
                  AutoRouter.of(context).push(AddEditContactRoute(
                      contact: contactList[index],
                      addContact: addContact,
                      updateContact: updateContact));
                },
                leading: CircleAvatar(
                  backgroundColor: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  foregroundColor: Colors.white,
                  backgroundImage: contactList[index].avatar == null
                      ? null
                      : Image.memory(contactList[index].avatar!).image,
                  child: contactList[index].avatar == null
                      ? Text(contactList[index].initial())
                      : null,
                ),
                title: Text(contactList[index].displayName!),
                subtitle: contactList[index].phones!.isEmpty
                    ? null
                    : Text(contactList[index].phones![0].value!),
                trailing: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (cxt) => AlertDialog(
                            title: const Text("Delete contact"),
                            content: const Text(
                                "Do you want to delete this contact?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Provider.of<ContactListViewModel>(context,
                                          listen: false)
                                      .removeContact(
                                          contactList[index].identifier!);
                                  Navigator.of(cxt).pop();
                                },
                                child: const Text("Delete"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(cxt).pop();
                                },
                                child: const Text("Cancel"),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
  }
}

Widget noContactFound() => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Image.asset('assets/not_found.png')),
        const Text(
          'Oops!!',
          style: TextStyle(fontSize: 30),
        ),
        const Text(
          'We\'ve no contacts...',
          style: TextStyle(color: Colors.grey, fontSize: 20),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );

extension ContactExtension on Contact {
  String initial() {
    return displayName?[0] ?? "";
  }
}
