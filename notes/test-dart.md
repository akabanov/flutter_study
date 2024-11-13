# Notes on Dart test package

Resources:

* Dart `test` package: [home](https://pub.dev/packages/test), [API](https://pub.dev/documentation/test/latest/)
* Dart `matcher` package: [home](https://pub.dev/packages/matcher), [API](https://pub.dev/documentation/matcher/latest/)
* Dart `mockito` package: [home](https://pub.dev/packages/mockito), [API](https://pub.dev/documentation/mockito/latest/)

Notable methods:

* `group`
* `test`
* `setUp` (use `late` modifier for the variables within the test scope)
* `tearDown`

## Mockito package

### Best practices

Use first applicable approach:

- use real implementation
- use real data model
- use stub implementation
- use `class FakeBar extends Fake implements Bar`
- use Mock as last resort

### Setting up

Add dev dependencies:

```shell
flutter pub add dev:build_runner
flutter pub add dev:mockito
```

Create stab test library:

```dart
import 'package:mockito/annotations.dart';

import 'mockito_cat.dart';
@GenerateNiceMocks([MockSpec<Cat>()])
import 'mockito_test.mocks.dart';
// ^^^ code gen adds 'mocks' to this library name ('mockito_test')

void main() {}
```

Run code generator:

```shell
# Using Dart:
dart run build_runner build

# Using Flutter:
flutter pub run build_runner build
```

### Testing

Lifecycle:

- create mock object
- stub behaviour
- call methods
- verify
- clean

#### Stubbing

_todo_

Argument matching:
_todo_

#### Verification

The amount of calls:

- `verifyZeroInteractions(mock)`
- `verifyNever(call)`
- `verify(call)`
- `verify(call).called(value | matcher)`
- `verifyInOrder(\[calls])`

Arguments capturing

#### Cleaning up

