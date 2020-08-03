import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_app/pages/contact_page.dart';
import 'package:flutter_app/providers/database_provider.dart';
import 'package:flutter_app/providers/contact.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseProvider database = DatabaseProvider();
  List<Contact> contacts = List();

  void _getAllContacts() {
    database.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllContacts();
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 80, 
                height: 80, 
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage('assets/images/person'), fit: BoxFit.cover)
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contacts[index].name ?? "",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
                    ),
                    Text(
                      contacts[index].email ?? "",
                      style: TextStyle(fontSize: 18)
                    ),
                    Text(
                      contacts[index].phone ?? "",
                      style: TextStyle(fontSize: 18)
                    ),
                  ],
                )
              )
            ],
          ),
        ),
      ),
      onTap: (){
        _showOptions(context, index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatinhos'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(onPressed: () {
        _showContactPage();
      },
      child: Icon(Icons.add)
      backgroundColor: Colors.black,),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
            return _contactCard(context, index);
        },
      ),
    );
  }
}
