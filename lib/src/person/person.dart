import 'package:random_name_generator/random_name_generator.dart';
import 'package:uuid/uuid.dart';

final randomNames = RandomNames(Zone.uk);

class Person {
  factory Person.random() {
    return Person(randomNames.fullName());
  }

  final String id = const Uuid().v4();
  final String name;

  Person(this.name);
}
