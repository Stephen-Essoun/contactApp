import 'package:contact_app/ui/contact/contact_create_page.dart';
import 'package:contact_app/ui/contacts_list/widget/contact_form.dart';
import 'package:contact_app/ui/contacts_list/widget/contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../model/contact_model.dart';

class ContactsListPage extends StatefulWidget {
  const ContactsListPage({super.key});

  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  final ContactModel _contactModel = ContactModel();
  @override
  //runs when notifyListeners() is called from model
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: ScopedModelDescendant<ContactModel>(builder: (
        context,
        child,
        model,
      ) {
        return ListView.builder(
          itemCount: model.contact.length,
          itemBuilder: (ctx, index) {
            return ContactTile(
              contactIndex: index,
            );
            // return Text('counter = ${model.counter}');
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (ctx) => const Dialog(
                    child: AspectRatio(
                      aspectRatio: 20 / 20,
                      child: ContactForm(),
                    ),
                  ));
        },
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
