import 'package:flutter/material.dart';
import 'package:flutter_study_skeleton_app/src/person/person.dart';

class MainApp extends StatefulWidget {
  MainApp({super.key, required this.friends});

  final TextEditingController controller = TextEditingController();
  final List<Person> friends;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Friend list")),
        body: ListView.builder(
          key: const Key('people_list'),
          itemCount: widget.friends.length,
          itemBuilder: (context, index) {
            var friend = widget.friends[index];

            return Dismissible(
              key: Key(friend.id),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                  friend.name,
                ),
              ),
            );
          },
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Add friend:'),
              TextField(
                controller: widget.controller,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            var controller = widget.controller;
            var input = controller.text;
            if (input.isNotEmpty) {
              setState(() {
                widget.friends.add(Person(input));
                controller.clear();
              });
            }
          },
        ),
      ),
    );
  }
}
