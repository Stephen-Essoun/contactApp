import 'package:contact_app/model/contact_model.dart';
import 'package:contact_app/ui/contact/contact_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
      void deleteFxn(Bui) => model.removeContact(contactIndex);
      return Slidable(
        key: const ValueKey(1),
        endActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children:  [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (context) => model.removeContact(contactIndex),
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            model.contact[contactIndex].name,
          ),
          subtitle: Text(model.contact[contactIndex].phoneNumber),
          trailing: IconButton(
            onPressed: () {
              model.isFavoriteStatus(contactIndex);
            },
            icon: Icon(
              displayedContact.isFvorite == true
                  ? Icons.star
                  : Icons.star_border,
              color: displayedContact.isFvorite == true
                  ? Colors.amber
                  : Colors.grey,
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
        ),
      );
    });
  }
}

void doNothing(BuildContext context) {}
