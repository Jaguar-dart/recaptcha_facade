import 'dart:async';
import 'dart:html';
import 'package:js/js.dart';
import "package:dart_browser_loader/dart_browser_loader.dart"
    show loadScript, waitLoad;
import 'package:recaptcha_facade/facade/facade.dart' as facade;

/// Instantiates a recaptcha widget
///
/// On successful identification, [onSuccess] event is fired.
/// On expiry, [onExpire] event is fired.
class Recaptcha {
  int _id;

  /// Container on which the recaptcha widget is instantiated.
  final HtmlElement container;

  /// Recaptcha parameters
  facade.RecaptchaParameters _params;

  /// Internal constructor
  Recaptcha._(this.container) {}

  /// id of the recaptcha instance
  int get id => _id;

  /// Recaptcha parameters
  facade.RecaptchaParameters get params => _params;

  final _fireExpire = new StreamController<DateTime>();

  /// Event fired when the recaptcha expires.
  Stream<DateTime> get onExpire => _fireExpire.stream;

  final _fireSuccess = new StreamController<String>();

  /// Event fired when the recaptcha is successfully identified.
  Stream<String> get onSuccess => _fireSuccess.stream;

  /// Handles expiry callback from the google server
  void _expired() {
    _fireExpire.add(new DateTime.now());
  }

  /// Handles response callback from server
  void _handleResponse(String response) {
    _fireSuccess.add(response);
  }

  /// Resets the recaptcha
  void reset() {
    facade.reset(_id);
  }

  /// Returns the current recaptcha response.
  String get response => facade.getResponse(_id);

  /// Factory method that creates a new instance of [Recaptcha] with given
  /// [sitekey] on given [container].
  static Future<Recaptcha> create(String sitekey, HtmlElement container,
      {String theme, String type, String size, String tabindex}) async {
    if (!await loadScripts()) return null;

    final ret = new Recaptcha._(container);

    final params = new facade.RecaptchaParameters(
        sitekey: sitekey,
        theme: theme,
        type: type,
        size: size,
        tabindex: tabindex,
        expiredCallback: allowInteropCaptureThis(ret._expired),
        callback: allowInterop(ret._handleResponse));

    final int id = facade.render(container, params);

    ret._id = id;
    ret._params = params;

    return ret;
  }

  /// Loads recaptcha scripts
  static Future<bool> loadScripts() async {
    if (_script != null) return true;

    await loadScript(
        "https://www.google.com/recaptcha/api.js?onload=render=explicit",
        isAsync: true,
        isDefer: true,
        id: "grecaptcha-jssdk");

    if (_script != null) return true;

    final scripts = document.querySelectorAll("script");
    _script = scripts.where((s) => s is ScriptElement).firstWhere(
        (s) => (s as ScriptElement)
            .src
            .startsWith("https://www.gstatic.com/recaptcha/api2/"),
        orElse: () => null);
    if (_script == null) return false;
    await waitLoad(_script);

    return true;
  }

  static Element _script;
}
