import 'package:contact_app/data/contact.dart';
import 'package:contact_app/ui/contacts_list/widget/contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

import '../../model/contact_mode.dart';

class ContactsListPage extends StatefulWidget {
  const ContactsListPage({super.key});

  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
 
   final ContactModel _contactModel = ContactModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: _contactModel.contact.length,
        itemBuilder: (ctx, index) {
          return ContactTile(contact: _contactModel.contact[index],isFavoritePressed: () {
             setState(() {
              _contactModel.contact[index].isFvorite = !_contactModel.contact[index].isFvorite;
              _contactModel.contact.sort(
                (a, b) {
                  if (a.isFvorite) {
                    return -1;
                  } else if (b.isFvorite) {
                    return 1;
                  } else {
                    return 0;
                  }
                },
              );
            });
          },);
        },
      ),
    );
  }
}
