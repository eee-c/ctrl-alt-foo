library key_event_x;

import 'dart:html';
import 'dart:async';
import 'dart:math';

import 'key_identifier.dart';
import 'package:js/js.dart' as js;

class KeyboardEventStreamX extends KeyboardEventStream {
  static Stream<KeyEventX> onKeyPress(target) { throw UnimplementedError; }

  // The onKeyUp is intentionally unimplemented because there does not seem to
  // be a way to normalize onKeyUp events for Enter keys (in IE).
  //static Stream<KeyEventX> onKeyUp(EventTarget target)

  static void createJsListener() {
    if (js.hasProperty(js.context, '_dart_key_event_x')) return;

    // TODO: removeListener?
    js.context.eval('''
function _dart_key_event_x(target_classname, cb) {
  var target = (target_classname == '') ?
     document : document.getElementsByClassName(target_classname)[0];
  target = document;

  target.addEventListener("keydown", function(event) {
    cb(event);
  });
}''');
  }

  static Stream<KeyEventX> onKeyDown(EventTarget target) {
    var _controller = new StreamController.broadcast();

    var temp_classname = "dart_id-${new Random().nextInt(1000)}";
    // target.classes.add(temp_classname);

    createJsListener();
    var dartCallback = new js.Callback.many((event) {
      _controller.add(new KeyEventX(event));
    });

    js.context._dart_key_event_x(temp_classname, dartCallback);

    //target.classes.remove(temp_classname);

    return _controller.stream;
  }
}

class KeyEventX implements KeyEvent {
  int keyCode;
  bool ctrlKey, metaKey, shiftKey;
  var _parent;

  KeyEventX(KeyboardEvent parent) {
    keyCode = parent.keyCode;
    ctrlKey = parent.ctrlKey;
    metaKey = parent.metaKey;
    shiftKey = parent.shiftKey;
  }

  bool get isEnter => keyCode == 10 || keyCode == 13;

  bool get isEscape => isKey('Esc');
  bool get isDown => isKey('Down');
  bool get isUp => isKey('Up');

  bool isCtrl(String char) => ctrlKey && isKey(char);
  bool isCommand(String char) => metaKey && isKey(char);

  bool isKey(String char)=> KeyIdentifier.keyCodeFor(char) == keyCode;

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

  set cancelBubble(bool v) {_parent.cancelBubble = v;}

  // TODO: this should really have an effect
  void preventDefault() {}

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
