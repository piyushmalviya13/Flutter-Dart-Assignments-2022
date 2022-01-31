import 'package:assignment4/routes/router.gr.dart';
import 'package:assignment4/screens/contact_list_screen/viewmodel/contact_list_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class AddEditContactScreen extends StatefulWidget {
  final Contact? contact;

  const AddEditContactScreen({Key? key, this.contact}) : super(key: key);

  @override
  State<AddEditContactScreen> createState() => _AddEditContactScreenState();
}

class _AddEditContactScreenState extends State<AddEditContactScreen> {
  final _formKey = GlobalKey<FormState>();
  late Contact _contact;

  @override
  void initState() {
    super.initState();
    _contact = widget.contact ?? Contact();
  }

  Future _pickImage() async {
    var contactImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    var contactImageBytes = await File(contactImage!.path).readAsBytes();
    setState(() {
      _contact.avatar = contactImageBytes;
    });
  }

  void _addContact(model) {
    var displayName = "${_contact.givenName}";
    if (_contact.middleName != null) {
      displayName += " ${_contact.middleName}";
    }
    if (_contact.familyName != null) {
      displayName += " ${_contact.familyName}";
    }
    var identifier = model.generateIdentifierForContact();
    setState(() {
      _contact.displayName = displayName;
      _contact.identifier = identifier;
    });
    model.addContact(_contact);
    AutoRouter.of(context).popAndPush(const ContactListRoute());
  }

  void _updateContact(model) {
    var displayName = "${_contact.givenName}";
    if (_contact.middleName != null) {
      displayName += " ${_contact.middleName}";
    }
    if (_contact.familyName != null) {
      displayName += " ${_contact.familyName}";
    }
    setState(() {
      _contact.displayName = displayName;
    });
    model.updateContact(_contact);
    AutoRouter.of(context).popAndPush(const ContactListRoute());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactListViewModel(),
      child: Consumer<ContactListViewModel>(
        builder: (_, model, __) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    AutoRouter.of(context).pop();
                  },
                );
              },
            ),
            title: widget.contact == null
                ? const Text("Create Contact")
                : const Text("Edit Contact"),
            actions: [
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.contact == null
                          ? _addContact(model)
                          : _updateContact(model);
                    }
                  },
                  child: const Text("Save"),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ))
            ],
          ),
          body: SafeArea(
            minimum: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      minRadius: 50,
                      child: _contact.avatar == null
                          ? const Icon(Icons.add_a_photo)
                          : null,
                      backgroundImage: _contact.avatar == null
                          ? null
                          : Image.memory(_contact.avatar!).image,
                    ),
                    TextButton(
                        onPressed: () {
                          _pickImage();
                        },
                        child: _contact.avatar == null
                            ? const Text('Add Photo')
                            : const Text('Change Photo')),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(height: 23,),
                              Icon(Icons.account_circle_rounded),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: "First Name"),
                                onChanged: (value) {
                                  setState(() {
                                    _contact.givenName = value;
                                  });
                                },
                                initialValue: _contact.givenName,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a first name';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: "Middle Name"),
                                  onChanged: (value) {
                                    setState(() {
                                      _contact.middleName = value;
                                    });
                                  },
                                  initialValue: _contact.middleName),
                              TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: "Last Name"),
                                  onChanged: (value) {
                                    setState(() {
                                      _contact.familyName = value;
                                    });
                                  },
                                  initialValue: _contact.familyName),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Icon(Icons.phone),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration:
                                const InputDecoration(labelText: "Phone Number"),
                                initialValue:
                                (_contact.phones == null || _contact.phones!.isEmpty)
                                    ? ""
                                    : _contact.phones?[0].value,
                                onChanged: (value) {
                                  List<Item> phones = [];
                                  phones.add(Item(label: "phone", value: value));
                                  setState(() {
                                    _contact.phones = phones;
                                  });
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a phone number';
                                  }
                                  return null;
                                }, // Only numbers can be entered
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Icon(Icons.email),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            children: [
                              TextFormField(
                                  decoration: const InputDecoration(labelText: "Email"),
                                  onChanged: (value) {
                                    List<Item> emails = [];
                                    emails.add(Item(label: "email", value: value));
                                    setState(() {
                                      _contact.emails = emails;
                                    });
                                  },
                                  initialValue: (_contact.emails == null ||
                                      _contact.emails!.isEmpty)
                                      ? ""
                                      : _contact.emails?[0].value),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
