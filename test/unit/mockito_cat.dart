class Cat {
  // a field
  int lives = 9;

  bool go(String destination) => false;

  // sync method
  Future<bool> eat(String food, {bool hungry = false}) async {
    return false;
  }

  Stream<String> talk() {
    return Stream.fromIterable(['meow', 'more', 'mom']);
  }
}
