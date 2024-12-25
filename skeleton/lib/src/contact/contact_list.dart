import 'package:flutter/material.dart';
import 'package:flutter_study_skeleton_app/src/contact/contact.dart';
import 'package:flutter_study_skeleton_app/src/contact/contact_view.dart';
import 'package:flutter_study_skeleton_app/src/settings/settings_view.dart';

class ContactList extends StatelessWidget {
  const ContactList(
      {super.key, this.contacts = const [Contact(id: 1), Contact(id: 2)]});

  static const routeName = '/contacts';

  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context)
                .restorablePushNamed(SettingsView.routeName),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (_, index) {
            var contact = contacts[index];
            return ListTile(
              key: Key(contact.id.toString()),
              leading: const CircleAvatar(
                child: Image(image: AssetImage('assets/img/flutter_logo.png')),
              ),
              title: Text(contact.toString()),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ContactView(contact: contact)));
              },
            );
          },
        ),
      ),
    );
  }
}
