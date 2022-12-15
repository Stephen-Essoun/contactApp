import 'package:flutter/material.dart';

import '../../data/contact.dart';
import '../contacts_list/widget/contact_form.dart';

class ContactEditPage extends StatelessWidget {
  final Contact editedContact;
  final int editedContactIndex;

  const ContactEditPage({
    super.key,
    required this.editedContact,
    required this.editedContactIndex,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contact'),
        ),
        body: ContactForm(
          editedContact: editedContact,
          editedContactIndex: editedContactIndex,
          key: key,
        ));
  }
}
