import 'package:assignment4/screens/contact_list_screen/viewmodel/contact_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();
  final String query = '';

  @override
  Widget build(BuildContext context) {
    const styleActive = TextStyle(color: Colors.black);
    const styleHint = TextStyle(color: Colors.black54);
    final style = query.isEmpty ? styleHint : styleActive;

    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: controller.text.isEmpty
              ? Icon(Icons.search, color: style.color)
              : GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    controller.clear();
                    Provider.of<ContactListViewModel>(context, listen: false)
                        .filterContacts('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
          hintText: "Enter Contact Name...",
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: (_) {
          setState(() {});
          Provider.of<ContactListViewModel>(context, listen: false)
              .filterContacts(controller.text);
        },
      ),
    );
  }
}
