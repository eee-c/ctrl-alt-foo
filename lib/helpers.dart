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

hitEnter()=> type('Enter');
hitEscape()=> type('Esc');

arrowDown([times=1]) {
  new Iterable.generate(times, (i) {
    type('Down');
  }).toList();
}

arrowUp([times=1]) {
  new Iterable.generate(times, (i) {
    type('Up');
  }).toList();
}

type(String key) {
  ShortCut.stream.add(
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
  ShortCut.stream.add(
    new KeyEvent(
      'keydown',
      keyCode: keyCodeFor(char),
      ctrlKey: true
    )
  );
}

typeCommand(char) {
  ShortCut.stream.add(
    new KeyEvent(
      'keydown',
      keyCode: keyCodeFor(char),
      metaKey: true
    )
  );
}

typeCtrlShift(char) {
  ShortCut.stream.add(
    new KeyEvent(
      'keydown',
      keyCode: keyCodeFor(char),
      ctrlKey: true,
      shiftKey: true
    )
  );
}

typeCommandShift(char) {
  ShortCut.stream.add(
    new KeyEvent(
      'keydown',
      keyCode: keyCodeFor(char),
      metaKey: true,
      shiftKey: true
    )
  );
}

int keyCodeFor(char)=> KeyIdentifier.keyCodeFor(char);
