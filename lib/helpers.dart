import 'dart:html';

import 'key_identifier.dart';

typeIn(String text) {
  document.activeElement.value = text;

  var last_char = new String.fromCharCode(text.runes.last);
  document.activeElement.dispatchEvent(
    new KeyboardEvent(
      'keyup'
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
  document.activeElement.dispatchEvent(
    new KeyboardEvent(
      'keydown',
      keyIdentifier: keyIdentifierFor(key)
    )
  );
  document.activeElement.dispatchEvent(
    new KeyboardEvent(
      'keyup',
      keyIdentifier: keyIdentifierFor(key)
    )
  );
}

typeCtrl(char) {
  document.activeElement.dispatchEvent(
    new KeyboardEvent(
      'keydown',
      keyIdentifier: keyIdentifierFor(char),
      ctrlKey: true
    )
  );
}

typeCommand(char) {
  document.activeElement.dispatchEvent(
    new KeyboardEvent(
      'keydown',
      keyIdentifier: keyIdentifierFor(char),
      metaKey: true
    )
  );
}

typeCtrlShift(char) {
  document.activeElement.dispatchEvent(
    new KeyboardEvent(
      'keydown',
      keyIdentifier: keyIdentifierFor(char),
      ctrlKey: true,
      shiftKey: true
    )
  );
}

typeCommandShift(char) {
  document.activeElement.dispatchEvent(
    new KeyboardEvent(
      'keydown',
      keyIdentifier: keyIdentifierFor(char),
      metaKey: true,
      shiftKey: true
    )
  );
}

String keyIdentifierFor(char)=> KeyIdentifier.forChar(char);
