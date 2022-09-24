import 'package:contact_app/model/contact.dart';
import 'package:contact_app/ui/contacts_list/widget/contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

class ContactsListPage extends StatefulWidget {
  const ContactsListPage({super.key});

  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  late List<Contact> _contact;

  @override
  void initState() {
    _contact = List.generate(
      50,
      (index) => Contact(
          name: '${faker.person.firstName()}  ${faker.person.lastName()}',
          email: faker.internet.freeEmail(),
          phoneNumber: faker.randomGenerator.integer(100000).toString(),
          isFvorite: false),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: _contact.length,
        itemBuilder: (ctx, index) {
          return ContactTile(contact: _contact[index],isFavoritePressed: () {
             setState(() {
              _contact[index].isFvorite = !_contact[index].isFvorite;
              _contact.sort(
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
