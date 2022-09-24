import 'package:flutter/material.dart';

import '../../../model/contact.dart';

class ContactTile extends StatelessWidget {
  const ContactTile(
      {Key? key, required this.contact, required this.isFavoritePressed})
      : super(key: key);
  final Contact contact;
  final void Function() isFavoritePressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        contact.name,
      ),
      subtitle: Text(contact.email),
      trailing: IconButton(
          onPressed: isFavoritePressed,
          icon: Icon(
            contact.isFvorite == true ? Icons.star : Icons.star_border,
            color:
                contact.isFvorite == true ? Colors.amber : Colors.grey,
          )),
    );
    
  }
}
