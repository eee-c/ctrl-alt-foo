library ctrl_alt_foo_test;

import 'package:ctrl_alt_foo/keys.dart';
import 'package:ctrl_alt_foo/shortcut.dart';
import 'package:ctrl_alt_foo/key_event_x.dart';
import 'package:ctrl_alt_foo/helpers.dart';

import 'package:unittest/unittest.dart';
import 'dart:html';
import 'dart:async';


main(){
  var _s;
  tearDown((){
    if (_s != null) _s.cancel();
  });

  test("can listen for key events", (){
    _s = KeyboardEventStreamX.onKeyDown(document).listen(expectAsync1((e) {
      expect(e.isKey('A'), true);
    }));

    type('A');
  });

  skip_test("can listen for Ctrl shortcuts", (){
    _s = KeyboardEventStreamX.onKeyDown(document).listen(expectAsync1((e) {
      expect(e.isCtrl('A'), true);
    }));

    typeCtrl('A');
  });

  test("can listen for Command shortcuts (OSX)", (){
    _s = KeyboardEventStreamX.onKeyDown(document).listen(expectAsync1((e) {
      expect(e.isCommand('A'), true);
    }));

    typeCommand('A');
  });

  skip_test("can listen for Ctrl-Shift shortcuts", (){
    _s = KeyboardEventStreamX.onKeyDown(document).listen(expectAsync1((e) {
      expect(e.isCtrlShift('A'), true);
    }));

    typeCtrlShift('A');
  });

  test("can listen for Command-Shift shortcuts (OSX)", (){
    _s = KeyboardEventStreamX.onKeyDown(document).listen(expectAsync1((e) {
      expect(e.isCommandShift('A'), true);
    }));

    typeCommandShift('A');
  });

  test("can listen for Enter keys", (){
    _s = KeyboardEventStreamX.onKeyDown(document).listen(expectAsync1((e) {
      expect(e.isEnter, true);
    }));

    hitEnter();
  });

  test("can listen for Escape keys", (){
    _s = KeyboardEventStreamX.onKeyDown(document).listen(expectAsync1((e) {
      expect(e.isEscape, true);
    }));

    hitEscape();
  });

  test("can listen for down key", (){
    _s = KeyboardEventStreamX.onKeyDown(document).listen(expectAsync1((e) {
      expect(e.isDown, true);
    }));

    arrowDown();
  });

  test("can listen for up key", (){
    _s = KeyboardEventStreamX.onKeyDown(document).listen(expectAsync1((e) {
      expect(e.isUp, true);
    }));

    arrowUp();
  });

  shortCut();
  keys();

  pollForDone(testCases);
}

shortCut(){
  group("ShortCut", (){
    var s;
    tearDown(()=> s.cancel());

    test("can establish a keyboard shortcut", (){
      s = new ShortCut('A', expectAsync0((){}), isCtrl: true);
      typeCtrl('A');
    });

    test("can establish a keyboard shortcut by key name (e.g. Esc)", (){
      s = new ShortCut('Esc', expectAsync0((){}));
      hitEscape();
    });

    test("throws an error for invalid key name (e.g. Esca)", (){
      expect(()=> new ShortCut('Esca', (){}), throwsInvalidKeyName);
    });

    test("throws an error for incorrect modifier placement (Ctrl+O+Shift)", (){
      expect(
        ()=> new ShortCut.fromString('Ctrl+O+Shift', (){}),
        throwsInvalidShortCutString
      );
    });

    test("throws an error for invalid modifiers (Ctl+O)", (){
      expect(
        ()=> new ShortCut.fromString('Ctl+O', (){}),
        throwsInvalidShortCutString
      );
    });

    test("throws an error for bad attempts at multiples (Ctl+O ⌘+O)", (){
      expect(
        ()=> new ShortCut.fromString('Ctl+O ⌘+O', (){}),
        throwsInvalidShortCutString
      );
    });
  });
}

/** A matcher for InvalidKeyNames. */
const isInvalidKeyName = const _InvalidKeyName();

/** A matcher for functions that throw InvalidKeyName. */
const Matcher throwsInvalidKeyName =
    const Throws(isInvalidKeyName);

class _InvalidKeyName extends TypeMatcher {
  const _InvalidKeyName() : super("InvalidKeyName");
  bool matches(item, Map matchState) => item is InvalidKeyName;
}

/** A matcher for InvalidShortCutStrings. */
const isInvalidShortCutString = const _InvalidShortCutString();

/** A matcher for functions that throw InvalidShortCutString. */
const Matcher throwsInvalidShortCutString =
    const Throws(isInvalidShortCutString);

class _InvalidShortCutString extends TypeMatcher {
  const _InvalidShortCutString() : super("InvalidShortCutString");
  bool matches(item, Map matchState) => item is InvalidShortCutString;
}

keys(){
  group("Keys", (){
    test("can establish shortcut listerner with a simple map", (){
      Keys.shortcuts({
        'Esc':          (){ /* ... */ },
        'Ctrl+N':       (){ /* ... */ },
        'Ctrl+O, ⌘+O':  expectAsync0((){}),
        'Ctrl+Shift+H': (){ /* ... */ }
      });

      typeCommand('O');
    });
  });

}


pollForDone(List tests) {
  if (tests.every((t)=> t.isComplete)) {
    window.postMessage('done', window.location.href);
    return;
  }

  var wait = new Duration(milliseconds: 100);
  new Timer(wait, ()=> pollForDone(tests));
}
