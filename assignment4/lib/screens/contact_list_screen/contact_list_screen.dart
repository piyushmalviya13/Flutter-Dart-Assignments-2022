import 'package:assignment4/screens/contact_list_screen/viewmodel/contact_list_view_model.dart';
import 'package:assignment4/screens/contact_list_screen/widgets/contact_list.dart';
import 'package:assignment4/screens/contact_list_screen/widgets/search_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact>? filteredContacts;
  String query = '';

  Widget buildSearch(List<Contact> contacts) => SearchWidget(
        query: query,
        onChanged: (String query) {
          List<Contact> _filteredContacts = contacts
              .where((contact) => contact.displayName!
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
          setState(() {
            filteredContacts = _filteredContacts;
          });
        },
      );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactListViewModel(),
      child: Consumer<ContactListViewModel>(
        builder: (_, model, __) => Scaffold(
          body: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              buildSearch(model.getContacts),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).scaffoldBackgroundColor),
                    foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.blue),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                        const EdgeInsets.all(20))),
                onPressed: () => {
                  AutoRouter.of(context)
                      .pushNamed('/add-edit-contact-screen')
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add),
                    Text('Create New Contact')
                  ],
                ),
              ),
              Expanded(
                child: ContactList(
                  contactList: filteredContacts ?? model.getContacts,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
