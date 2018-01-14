import 'dart:html';
import 'package:recaptcha_facade/recaptcha_facade.dart';

main() async {
  final recaptcha = await Recaptcha.create(
      '6Lf3HCkUAAAAAJ2mRonRdQ7Ma-k9Or9uj7lxRy7a', querySelector('#output'));
  recaptcha.onSuccess.listen(print);
}
