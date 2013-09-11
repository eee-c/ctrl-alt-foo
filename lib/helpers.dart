import 'dart:html';

import 'key_identifier.dart';
import 'package:js/js.dart' as js;

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

_ensureKeydownDispatcher() {
  if (js.hasProperty(js.context, '_dart_keydown_dispatch')) return;

  js.context.eval('''
function _dart_keydown_dispatch(event) {
  document.activeElement.dispatchEvent(event);
}''');
}

_jsEvent(String key, {ctrlKey: false, metaKey: false, shiftKey: false}) {
  var keyCode = KeyIdentifier.keyCodeFor(key);

  return js.context.document.createEvent('Events')
    ..initEvent("keydown", true, true)
    ..keyCode = keyCode
    ..charCode = keyCode
    ..which = keyCode
    ..ctrlKey = ctrlKey
    ..metaKey = metaKey
    ..shiftKey = shiftKey;
}

type(String key) {
  _ensureKeydownDispatcher();
  js.context._dart_keydown_dispatch(_jsEvent(key));

  /*
  document.activeElement.dispatchEvent(
    new KeyboardEvent(
      'keyup',
      keyIdentifier: keyIdentifierFor(key)
    )
  );
  */
}

typeCtrl(char) {
  _ensureKeydownDispatcher();
  js.context._dart_keydown_dispatch(
    _jsEvent(char, ctrlKey: true)
  );
}

typeCommand(char) {
  _ensureKeydownDispatcher();
  js.context._dart_keydown_dispatch(
    _jsEvent(char, metaKey: true)
  );
}

typeCtrlShift(char) {
  _ensureKeydownDispatcher();
  js.context._dart_keydown_dispatch(
    _jsEvent(char, ctrlKey: true, shiftKey: true)
  );
}

typeCommandShift(char) {
  _ensureKeydownDispatcher();
  js.context._dart_keydown_dispatch(
    _jsEvent(char, metaKey: true, shiftKey: true)
  );
}

// String keyIdentifierFor(char)=> KeyIdentifier.forChar(char);
