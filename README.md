# recaptcha_facade

Library to render and control recaptcha.

From authors of [Jaguar](https://jaguar-dart.github.io/).

# Usage

```dart
import 'package:recaptcha_facade/recaptcha_facade.dart';

main() async {
  final recaptcha = await Recaptcha.create(
      '6Lf3HCkUAAAAAJ2mRonRdQ7Ma-k9Or9uj7lxRy7a', querySelector('#output'));
  recaptcha.onSuccess.listen(print);
}
```

## Simple example

For a simple client-only example, [check out this example](https://github.com/Jaguar-dart/recaptcha_facade/tree/master/web).

## Complete example

For a complete example with client, [check out this example](https://github.com/jaguar-examples/recaptcha).
