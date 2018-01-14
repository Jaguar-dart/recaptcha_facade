@JS()
library recaptcha.facade;

import 'dart:html';
import 'package:js/js.dart';

/// Renders a new recaptcha on [container] with parameters [parameters]
@JS('grecaptcha.render')
external num render(HtmlElement container, RecaptchaParameters parameters);

/// Resets the recaptcha with id [id]
@JS('grecaptcha.reset')
external void reset(num id);

/// Gets response of the recaptcha with id [id]
@JS('grecaptcha.getResponse')
external getResponse(num id);

/// Parameters for recaptcha
@JS()
@anonymous
class RecaptchaParameters {
  /// Your sitekey.
  external String get sitekey;

  /// Theme
  ///
  /// Values: light, dark
  /// Default: light
  external String get theme;

  /// Required. The name of your callback function to be executed when the user
  /// submits a successful CAPTCHA response. The user's response, g-recaptcha-response,
  /// will be the input for your callback function.
  external Function get callback;

  /// Optional. The type of CAPTCHA to serve.
  ///
  /// Values: audio, image
  /// Default: image
  external String get type;

  /// Optional. Used to create an invisible widget bound to a div and
  /// programatically executed.
  external String get size;

  /// Optional. The tabindex of the challenge. If other elements in your page
  /// use tabindex, it should be set to make user navigation easier.
  external String get tabindex;

  @JS("expired-callback")
  external Function get expiredCallback;

  external factory RecaptchaParameters(
      {String sitekey,
      String theme,
      Function callback,
      String type,
      Function expiredCallback,
      String size,
      String tabindex});
}
