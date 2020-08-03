final String contactTable = 'contactTable';
final String idColumn = 'idColumn';
final String nameColumn = 'nameColumn';
final String phoneColumn = 'phoneColumn';
final String emailColumn = 'emailColumn';

class Contact {
  int id;
  String name, email, phone;

  Contact();

  Contact.fromMap(Map map) {
    id = map['idColumn'];
    email = map['emailColumn'];
    name = map['nameColumn'];
    phone = map['phoneColumn'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'nameColumn': name,
      'emailColumn': email,
      'phoneColumn': phone,
    };

    if (id != null) {
      map['idColumn'] = id;
    }

    return map;
  }
}
