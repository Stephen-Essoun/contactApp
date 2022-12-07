import 'package:contact_app/model/contact_model.dart';
import 'package:contact_app/ui/contact/contact_edit_age.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    Key? key,
    required this.contactIndex,
  }) : super(key: key);
  final int contactIndex;
  // final void Function() isFavoritePressed;

  @override
  Widget build(BuildContext context) {
    // ContactModel
    // final model = ScopedModel.of<ContactModel>(context);
    return ScopedModelDescendant<ContactModel>(builder: (ctx, child, model) {
      var displayedContact = model.contact[contactIndex];
      return ListTile(
        title: Text(
          model.contact[contactIndex].name,
        ),
        subtitle: Text(model.contact[contactIndex].phoneNumber),
        trailing: IconButton(
          onPressed: () {
            model.isFavoriteStatus(contactIndex);
          },
          icon: Icon(
            displayedContact.isFvorite == true ? Icons.star : Icons.star_border,
            color:
                displayedContact.isFvorite == true ? Colors.amber : Colors.grey,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ContactEditPage(
                editedContact: displayedContact,
                editedContactIndex: contactIndex,
              ),
            ),
          );
        },
      );
    });
  }
}
