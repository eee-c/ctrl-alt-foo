library keys;

import 'package:ctrl_alt_foo/shortcut.dart';
import 'package:ctrl_alt_foo/key_event_x.dart';

class Keys {
  static List subscriptions = [];

  static void shortcuts(Map shortcuts) {
    shortcuts.forEach((key, callback) {
      key.
        split(new RegExp(r'\s*,\s*')).
        forEach((k)=> new ShortCut.fromString(k, callback));
    });
  }

  static onEnter(el, callback) {
    var s = KeyboardEventStreamX.onKeyDown(el).listen((e) {
      if (!e.isEnter) return;
      e.preventDefault();
      callback();
    });
    subscriptions.add(s);
  }

  static bool isEnter(event) => new KeyEventX(event).isEnter;

  static onDown(el, callback) {
    var s = KeyboardEventStreamX.onKeyDown(el).listen((e) {
      if (!e.isDown) return;
      e.preventDefault();
      callback();
    });
    subscriptions.add(s);
  }

  static onUp(el, callback) {
    var s = KeyboardEventStreamX.onKeyDown(el).listen((e) {
      if (!e.isUp) return;
      e.preventDefault();
      callback();
    });
    subscriptions.add(s);
  }

  static cancel() {
    ShortCut.removeAll();
    Keys.removeAll();
  }

  static removeAll() {
    while (Keys.subscriptions.length > 0) {
      Keys.subscriptions.removeLast().cancel();
    }
  }
}
