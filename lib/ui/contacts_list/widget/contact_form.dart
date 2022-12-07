import 'package:contact_app/data/contact.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../model/contact_model.dart';

class ContactForm extends StatefulWidget {
  final Contact? editedContact;
  final int? editedContactIndex;

  const ContactForm({
    super.key,
    this.editedContact,
    this.editedContactIndex,
  });

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formkey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactModel>(
        builder: (context, child, model) {
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
                onSaved: (value) => _name = value!,
                validator: (value) => _nameValidator(value.toString()),
                // initialValue: widget.editedContact!.name,
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
                onSaved: (value) => _email = value!,
                validator: (value) => _isEmailValid(value.toString()),
                // initialValue: widget.editedContact!.email,
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
                onSaved: (value) => _phoneNumber = value!,
                validator: (value) => _validateMobile(value.toString()),
                // initialValue: widget.editedContact!.phoneNumber,
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
                  onPressed: () {
                    _formkey.currentState!.save();

                    model.addContact(Contact(
                        name: _name,
                        email: _email,
                        phoneNumber: _phoneNumber,
                        isFvorite: widget.editedContact?.isFvorite ?? false));
                    Navigator.of(context).pop();
                  },
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
    });
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
      print('$_email + $_name + $_phoneNumber');
      final newContact = Contact(
          name: _name,
          email: _email,
          phoneNumber: _phoneNumber,
          isFvorite: widget.editedContact?.isFvorite ?? false);

      if (widget.editedContact != null) {
        ScopedModel.of<ContactModel>(context)
            .updateContact(newContact, widget.editedContactIndex!);
      } else {
        ScopedModel.of<ContactModel>(context).addContact(newContact);
      }
      var contact = ScopedModel.of<ContactModel>(context).contact;
      print(contact);
      Navigator.of(context).pop();
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (ctx) => const ContactsListPage()),
      //     (route) => false);
    }
  }
}
