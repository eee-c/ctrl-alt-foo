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
    return KeyboardEventStream.onKeyDown(target);
  }
}

class KeyEventX extends KeyEvent {
  KeyboardEvent _parent;

  KeyEventX(KeyboardEvent parent): super.wrap(parent) {
    _parent = parent;
  }

  bool get isEnter =>
    keyCode == KeyIdentifier.keyCodeFor('Enter') ||
    keyCode == 13;

  bool get isEscape => keyCode == KeyIdentifier.keyCodeFor('Esc');
  bool get isDown => keyCode == KeyIdentifier.keyCodeFor('Down');
  bool get isUp => keyCode == KeyIdentifier.keyCodeFor('Up');

  bool get isAlt => altKey;
  bool get isCtrl => ctrlKey;
  bool get isShift => shiftKey;
  bool get isMeta => metaKey;

  bool isAltAnd(String char) => isAlt && isKey(char);
  bool isCtrlAnd(String char) => ctrlKey && isKey(char);
  bool isCommand(String char) => metaKey && isKey(char);
  bool isKey(String char) {
    var expected = KeyIdentifier.keyCodeFor(char);
    return expected == keyCode;
  }

  bool isCtrlAlt(String char) => isAlt && isCtrlAnd(char);
  bool isAltShift(String char) => shiftKey && isAltAnd(char);
  
  bool isCtrlShift(String char) {
    if (!shiftKey) return false;
    return isCtrlAnd(char);
  }

  bool isCommandShift(String char) {
    if (!shiftKey) return false;
    return isCommand(char);
  }

  int get keyCode => _parent.keyCode;

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
