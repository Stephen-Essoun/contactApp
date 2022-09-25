import 'package:faker/faker.dart';
import 'package:scoped_model/scoped_model.dart';

import '../data/contact.dart';

class ContactModel extends Model {
final List<Contact> _contact =  List.generate(
      50,
      (index) => Contact(
          name: '${faker.person.firstName()}  ${faker.person.lastName()}',
          email: faker.internet.freeEmail(),
          phoneNumber: faker.randomGenerator.integer(100000).toString(),
          isFvorite: false),
    );

    List<Contact> get contact => _contact;
}