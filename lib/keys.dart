library keys;

import 'package:ctrl_alt_foo/shortcut.dart';

class Keys {
  static void map(Map shortcuts) {
    shortcuts.forEach(split);
  }

  static split(key, callback) {
    var keys = key.split(new RegExp(r'\s*,\s*'));
    keys.forEach((k) { toShortCut(k, callback); });
  }

  static toShortCut(String k, callback) {
    var parts = k.
      replaceAll('⌘', 'Meta').
      replaceAll('Command', 'Meta').
      split('+');

    var key = parts.removeLast();

    parts.sort();
    switch (parts.join('+')) {
      case '':
        new ShortCut(key, callback);
        break;
      case 'Ctrl':
        new ShortCut(key, callback, isCtrl: true);
        break;
      case 'Meta':
        new ShortCut(key, callback, isMeta: true);
        break;
      case 'Shift':
        new ShortCut(key, callback, isShift: true);
        break;
      case 'Ctrl+Shift':
        new ShortCut(key, callback, isCtrl: true, isShift: true);
        break;
      case 'Meta+Shift':
        new ShortCut(key, callback, isCtrl: true, isShift: true);
        break;
      default:
        throw 'Unsupported key combo';
    }
  }

  static cancel() {
    while (ShortCut.subscriptions.length > 0) {
      ShortCut.subscriptions.removeLast().cancel();
    }
  }
}
