import 'package:contact_app/ui/contacts_list/widget/contact_form.dart';
import 'package:flutter/material.dart';

class ContactCreatePage extends StatelessWidget {
  const ContactCreatePage({super.key});
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    String? name;
    String? email;
    String? phoneNumber;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contact'),
        ),
        body:ContactForm(key: key,));
  }
}
