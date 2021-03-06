import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_app/providers/contact.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider.internal();

  factory DatabaseProvider() => _instance;

  DatabaseProvider.internal();

  Database _db;

  Future<Database> get db async {
    Future<Database> initDb() async {
      final databasesPath = await getDatabasesPath();
      final path = join(databasesPath, 'contactsnew.db');

      return await openDatabase(path, version: 1,
          onCreate: (Database db, int newerVersion) async {
        await db.execute(
            "create table contactTable($idColumn integer primary key, $nameColumn text, $emailColumn text, $phoneColumn text)");
      });
    }

    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(contactTable,
        columns: [idColumn, nameColumn, emailColumn, phoneColumn],
        where: '$idColumn = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact
        .delete(contactTable, where: '$idColumn = ?', whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    Database dbContact = await db;
    return await dbContact.update(contactTable, contact.toMap(),
        where: "$idColumn = ?", whereArgs: [contact.id]);
  }

  Future<List> getAllContacts() async {
    Database dbContact = await db;

    List listMap = await dbContact.rawQuery("select * from $contactTable");
    List<Contact> listContact = List();
    for (Map m in listMap) {
      listContact.add(Contact.fromMap(m));
    }
  }
}
