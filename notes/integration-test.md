# Notes on integration testing

## Prepare project

Add dependency and create a directory for integration tests:

```shell
flutter pub add --sdk flutter integration_test
mkdir integration_test
```

## Implement tests

Create regular widget tests (maybe only pump the app?), but init this first:

```dart
// integration_test/app_test.dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  // testWidgets( ...
}
```

TODO: complete learning https://github.com/flutter/flutter/tree/main/packages/integration_test#android-device-testing

## Running the tests on local device

```shell
flutter test -d 'moto g24' integration_test
```

## Preparing .apk for Firebase Test Lab

```shell
# go to directory
pushd android

# generate files for building the app
flutter build apk

# assemble apk
./gradlew app:assembleAndroidTest
./gradlew app:assembleDebug "-Ptarget=integration_test/<name>_test.dart"
```