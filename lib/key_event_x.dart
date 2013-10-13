library key_event_x;

import 'dart:html';
import 'dart:async';

import 'key_identifier.dart';

class KeyboardEventStreamX extends KeyboardEventStream {
  static Stream<KeyEventX> onKeyPress(target) { throw UnimplementedError; }

  // The onKeyUp is intentionally unimplemented because there does not seem to
  // be a way to normalize onKeyUp events for Enter keys (in IE).
  //static Stream<KeyEventX> onKeyUp(EventTarget target)

  static Stream<KeyEventX> onKeyDown(EventTarget target) {
    return Element.
      keyDownEvent.
      forTarget(target).
      map((e)=> new KeyEventX(e));
  }
}

class KeyEventX extends KeyEvent {
  KeyboardEvent _parent;

  KeyEventX(KeyboardEvent parent): super(parent) {
    _parent = parent;
  }

  bool get isEnter => keyCode == 13;

  bool get isEscape => key == KeyIdentifier.forKeyName('Esc');
  bool get isDown => key == KeyIdentifier.forKeyName('Down');
  bool get isUp => key == KeyIdentifier.forKeyName('Up');

  bool get isCtrl => ctrlKey;
  bool get isShift => shiftKey;
  bool get isMeta => metaKey;

  bool isCtrlAnd(String char) => ctrlKey && keyCode == _keyCode(char);
  bool isCommand(String char) => metaKey && keyCode == _keyCode(char);

  _keyCode(char) => KeyIdentifier.forKeyName(char);

  bool isCtrlShift(String char) {
    if (!shiftKey) return false;
    return isCtrl(char);
  }

  bool isCommandShift(String char) {
    if (!shiftKey) return false;
    return isCommand(char);
  }

  String get key {
    if (keyCode == null) return 'Unidentified';
    return new String.fromCharCode(keyCode);
  }

  int get keyCode {
    // print('[keyCode] $keyIdentifier / ${keyIdentifier.codeUnits}');
    // if (keyIdentifier.codeUnits.length == 0) throw 'hunh?';

    if (_parent.keyCode != 0) return _parent.keyCode;
    return null;
  }

  set cancelBubble(bool v) {_parent.cancelBubble = v;}

  // TODO: Delegate to _parent
  // For now, satisfy dartanalyzer that we are extending properly
  Point layer;
  int layerX;
  int layerY;
  List<Node> path;
  int $dom_layerX;
  int $dom_layerY;
  int $dom_pageX;
  int $dom_pageY;
  int pageX;
  int pageY;
}
