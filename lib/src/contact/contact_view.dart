import 'package:flutter/material.dart';
import 'package:flutter_study_skeleton_app/src/contact/contact.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key, required this.contact});

  static const routeName = '/contact';

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.toString()),
      ),
      body: Center(
        child: Text(
          '#${contact.id}',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
