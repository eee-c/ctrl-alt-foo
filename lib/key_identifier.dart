library key_identifier;

import 'dart:html';

class KeyIdentifier {
  static final map = {
    'Backspace': KeyCode.BACKSPACE,
    'Tab':       KeyCode.TAB,
    'Enter':     KeyCode.ENTER,
    'Esc':       KeyCode.ESC,
    'Del':       KeyCode.DELETE,
    'Spacebar':  KeyCode.SPACE,
    'Left':      KeyCode.LEFT,
    'Up':        KeyCode.UP,
    'Right':     KeyCode.RIGHT,
    'Down':      KeyCode.DOWN
  };

  static forKeyName(name)=> map[name];

  static containsKey(name) => map.containsKey(name);

  static keyCodeFor(String c) {
    if (containsKey(c)) return map[c];

    var key = c.toUpperCase();
    return _codeFor(key);
  }

  static charCodeFor(String c) {
    if (containsKey(c)) return 0;

    return _codeFor(key);
  }

  static _codeFor(String c) {
    if (c.codeUnits.length > 2) throw "Don't know how to type “$c”";
    return c.codeUnits.first;
  }
}
