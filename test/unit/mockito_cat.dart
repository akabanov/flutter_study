class Cat {
  // a field
  int lives = 9;

  void go(String destination) {}

  // sync method
  Future<bool> eat(String food, {bool hungry = false}) async {
    return false;
  }
}
