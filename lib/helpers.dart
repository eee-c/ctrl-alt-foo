import 'dart:html';

typeIn(String text) {
  document.activeElement.value = text;

  document.activeElement.dispatchEvent(
    new KeyboardEvent('keyup')
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

String keyIdentifierFor(char) {
  if (char.codeUnits.length != 1) fail("Don't know how to type “$char”");

  // Keys are uppercase (see Event.keyCode)
  var key = char.toUpperCase();

  return 'U+00' + key.codeUnits.first.toRadixString(16).toUpperCase();
}
