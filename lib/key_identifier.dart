library key_identifier;

class KeyIdentifier {
  static final map = {
    'Backspace': 0x08,
    'Tab':       0x09,
    'Enter':     0x0A,
    'Esc':       0x1B,
    'Del':       0x7F,
    'Cancel':    0x18,
    'Spacebar':  0x20,
    'Tab':       0x09,
    'Del':       0x7F,
    'Left':      0x25,
    'Up':        0x26,
    'Right':     0x27,
    'Down':      0x28
  };

  static bool containsKey(name)=> map.containsKey(name);

  static int forKeyName(name)=> map[name];

  static int keyCodeFor(String char) {
    if (char.codeUnits.length == 1) return char.codeUnits.first;
    if (containsKey(char)) return forKeyName(char);

    throw new ArgumentError('Unable to determine keyCode for ${char}');
  }
}
