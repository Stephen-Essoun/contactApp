import 'package:faker/faker.dart';
import 'package:scoped_model/scoped_model.dart';

import '../data/contact.dart';

class ContactModel extends Model {
  final List<Contact> _contact = [];
  int _counter = 0;
  int get counter => _counter;

  List<Contact> get contact => _contact;

  void isFavoriteStatus(int index) {
    contact[index].isFvorite = !contact[index].isFvorite;
    _sortContacts();
    notifyListeners();
  }

  void _sortContacts() {
    contact.sort(
      (a, b) {
        int comparisonResult;
        //primarily sorting based on whether or not the contact is favorited
        comparisonResult = _compareBaseOnFavoriteStatus(a, b);
        if (comparisonResult == 0) {
          comparisonResult = _compareAlphabetically(a, b);
        }
        return comparisonResult;
      },
    );
  }

  void increment(){
    _counter ++;
    notifyListeners();
  }

   addContact(Contact contact) {
    _contact.add(contact);
    notifyListeners();
  }

  void updateContact(Contact contact, int contactIndex) {
    _contact[contactIndex] = contact;
    notifyListeners();
  }

  int _compareBaseOnFavoriteStatus(Contact a, Contact b) {
    if (a.isFvorite) {
      //contactOne will be BEFORE contactTwo
      return -1;
    } else if (b.isFvorite) {
      //contactOne will be AFTER contactTwo
      return 1;
    } else {
      //the position does not change
      return 0;
    }
  }

  int _compareAlphabetically(Contact a, Contact b) {
    return a.name.compareTo(b.name);
  }
}
