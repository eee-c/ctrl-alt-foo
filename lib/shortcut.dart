library shortcut;

import 'package:ctrl_alt_foo/key_event_x.dart';
import 'key_identifier.dart';
import 'dart:html';

class ShortCut {
  String char;
  bool isCtrl, isShift, isMeta;
  StreamSubscription subscription;
  var cb;

  static List subscriptions = [];

  ShortCut(
    this.char,
    this.cb,
    {
      this.isCtrl: false,
      this.isShift: false,
      this.isMeta: false
    })
  { this._createStream(); }

  void cancel()=> subscription.cancel();

  void _createStream() {
    var key = char.length == 1 ? char : KeyIdentifier.keyFor(char);
    subscription = KeyboardEventStreamX.onKeyDown(document).listen((e) {
      if (!e.isKey(key)) return;

      if (e.isCtrl  != isCtrl) return;
      if (e.isShift != isShift) return;
      if (e.isMeta  != isMeta) return;

      e.preventDefault();
      cb();
    });

    subscriptions.add(subscription);
  }
}
