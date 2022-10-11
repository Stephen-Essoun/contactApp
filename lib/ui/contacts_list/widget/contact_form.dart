import 'package:contact_app/data/contact.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../model/contact_model.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formkey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? phoneNumber;

  late TextEditingController username;
  late TextEditingController useremail;
  late TextEditingController userphoneNumber;

  @override
  void initState() {
    username = TextEditingController();
    useremail = TextEditingController();
    userphoneNumber = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: SafeArea(
        minimum: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (value) => name = value,
              validator: (value) => _nameValidator(value.toString()),
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (value) => email = value,
              validator: (value) => _isEmailValid(value.toString()),
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (value) => phoneNumber = value,
              validator: (value) => _validateMobile(value.toString()),
              decoration: InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton.icon(
                onPressed: _onSaveButtonPressed,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                label: const Text('Save Contact'),
                icon: const Icon(Icons.person_add))
          ],
        ),
      ),
    );
  }

  String? _nameValidator(String name) {
    if (name.isEmpty) {
      return "Enter a name";
    }
    return null;
  }

  String? _isEmailValid(String email) {
    var emailRegEx = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );
    if (email.isEmpty) {
      return 'Enter an email';
    } else if (!emailRegEx.hasMatch(email)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return ' Eenter a phone number';
    } else if (!regExp.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  void _onSaveButtonPressed() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      final newContact = Contact(
          name: username.text,
          email: useremail.text,
          phoneNumber: userphoneNumber.text,
          isFvorite: false);
      ScopedModel.of<ContactModel>(context).addContact(newContact);
    }
  }
}
