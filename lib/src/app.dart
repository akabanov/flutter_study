import 'package:flutter/material.dart';
import 'package:flutter_study_skeleton_app/src/person/person.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.friends});

  final List<Person> friends;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Friend list")),
        body: ListView.builder(
          key: const Key('people_list'),
          itemCount: friends.length,
          itemBuilder: (context, index) {
            var friend = friends[index];

            return ListTile(
              leading: const Icon(Icons.person),
              title: Text(
                key: Key(friend.id),
                friend.name,
              ),
            );
          },
        ),
      ),
    );
  }
}
