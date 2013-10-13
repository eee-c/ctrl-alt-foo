import 'dart:html';

import 'key_identifier.dart';
import 'shortcut.dart';

typeIn(String text) {
  document.activeElement.value = text;

  var last_char = new String.fromCharCode(text.runes.last);
  document.activeElement.dispatchEvent(
    new KeyEvent(
      'keyup',
      keyCode: keyCodeFor(last_char)
    )
  );
}

hitEnter()=> type(KeyName.ENTER);
hitEscape()=> type(KeyName.ESC);

arrowDown([times=1]) {
  new Iterable.generate(times, (i) {
    type(KeyName.DOWN);
  }).toList();
}

arrowUp([times=1]) {
  new Iterable.generate(times, (i) {
    type(KeyName.UP);
  }).toList();
}

type(String key) {
  ShortCut.dispatchEvent(
    new KeyEvent('keydown', keyCode: keyCodeFor(key))
  );
  // new KeyEvent.keyDownEventdocument.activeElement.dispatchEvent(
  //   new KeyEvent(
  //     'keydown',
  //     keyCode: keyCodeFor(key)
  //   )
  // );
  // document.activeElement.dispatchEvent(
  //   new KeyEvent(
  //     'keyup',
  //     keyCode: keyCodeFor(key)
  //   )
  // );
}

typeCtrl(char) {
  document.activeElement.dispatchEvent(
    new KeyEvent(
      'keydown',
      keyCode: keyCodeFor(char),
      ctrlKey: true
    )
  );
}

typeCommand(char) {
  document.activeElement.dispatchEvent(
    new KeyboardEvent(
      'keydown',
      keyCode: keyCodeFor(char),
      metaKey: true
    )
  );
}

typeCtrlShift(char) {
  document.activeElement.dispatchEvent(
    new KeyboardEvent(
      'keydown',
      keyCode: keyCodeFor(char),
      ctrlKey: true,
      shiftKey: true
    )
  );
}

typeCommandShift(char) {
  document.activeElement.dispatchEvent(
    new KeyboardEvent(
      'keydown',
      keyCode: keyCodeFor(char),
      metaKey: true,
      shiftKey: true
    )
  );
}

String keyCodeFor(char)=> KeyIdentifier.keyCodeFor(char);
