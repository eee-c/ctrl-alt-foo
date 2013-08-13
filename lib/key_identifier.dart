class KeyIdentifier {
  static final map = {
    'Backspace': 'U+0008',
    'Tab':       'U+0009',
    'Enter':	   'U+000A',
    'Esc':	     'U+001B',
    'Del':	     'U+007F',
    'Cancel':	   'U+0018',
    'Spacebar':	 'U+0020',
    'Tab':	     'U+0009',
    'Del':	     'U+007F',
    'Left':      'U+0025',
    'Up':        'U+0026',
    'Right':     'U+0027',
    'Down':      'U+0028'
  };

  static forKeyName(name)=> map[name];

  static forChar(c) {
    if (map.containsKey(c)) {
      return forKeyName(c);
    }

    if (c.codeUnits.length > 2) throw "Don't know how to type “$c”";

    // Keys are uppercase (see Event.keyCode)
    var key = c.toUpperCase();
    var codeUnits = key.codeUnits.length == 1 ?
      [0, key.codeUnits.first] :
      key.codeUnits;

    return 'U+' + codeUnits.
      map((u) {
        var hex = u.toRadixString(16).toUpperCase();
        return hex.length == 2 ? hex : '0${hex}';
      }).
      join();
  }

  static String keyFor(String keyName) =>
    new String.fromCharCode(keyCodeFor(keyName));

  static int keyCodeFor(String keyName) => keyCodeForUnicode(forKeyName(keyName));

  static int keyCodeForUnicode(String u) {
    return int.parse(u.replaceFirst('U+', '0x'));
  }
}
