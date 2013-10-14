library shortcut;

import 'package:ctrl_alt_foo/key_event_x.dart';
import 'key_identifier.dart';
import 'dart:html';
import 'dart:async';

class ShortCut {
  String char;
  bool isCtrl, isShift, isMeta;
  StreamSubscription subscription;
  var cb;

  static CustomStream _stream;
  static get stream {
    if (_stream == null) _stream = new ShortCutStream('keydown');
    return _stream;
  }

  static List subscriptions = [];
  static void removeAll() {
    while (ShortCut.subscriptions.length > 0) {
      ShortCut.subscriptions.removeLast().cancel();
    }
  }

  ShortCut(
    this.char,
    this.cb,
    {
      this.isCtrl: false,
      this.isShift: false,
      this.isMeta: false
    })
  { this._createStream(); }

  factory ShortCut.fromString(String k, callback) {
    var parts = k.
      replaceAll(new RegExp(r'\s+'), '').
      replaceAll('⌘', 'Meta').
      replaceAll('Command', 'Meta').
      split('+');

    var key = parts.removeLast();

    parts.sort();
    switch (parts.join('+')) {
      case '':
        new ShortCut(key, callback);
        break;
      case 'Ctrl':
        new ShortCut(key, callback, isCtrl: true);
        break;
      case 'Meta':
        new ShortCut(key, callback, isMeta: true);
        break;
      case 'Shift':
        new ShortCut(key, callback, isShift: true);
        break;
      case 'Ctrl+Shift':
        new ShortCut(key, callback, isCtrl: true, isShift: true);
        break;
      case 'Meta+Shift':
        new ShortCut(key, callback, isCtrl: true, isShift: true);
        break;
      default:
        throw new InvalidShortCutString(k);
    }
  }

  void cancel()=> subscription.cancel();

  void _createStream() {
    if (char.length > 1) {
      if (!KeyIdentifier.containsKey(char)) {
        throw new InvalidKeyName("$char is not recognized");
      }
    }

    subscription = ShortCut.stream.listen((e) {
      if (!e.isKey(char)) return;

      if (e.isCtrl  != isCtrl) return;
      if (e.isShift != isShift) return;
      if (e.isMeta  != isMeta) return;

      e.preventDefault();
      cb();
    });

    subscriptions.add(subscription);
  }
}

class ShortCutStream<T extends Event> extends Stream<T>
    implements CustomStream<T> {
  StreamController<T> _streamController;
  String _type;

  ShortCutStream(String type) {
    _type = type;
    _streamController = new StreamController.broadcast(sync: true);

    document.body.onKeyDown.listen((e) {
      KeyEvent wrapped_event = new KeyEvent.wrap(e);
      add(wrapped_event);
    });
  }

  StreamSubscription<T> listen(void onData(T event),
      { Function onError,
        void onDone(),
        bool cancelOnError}) {
    return _streamController.stream.listen(onData, onError: onError,
        onDone: onDone, cancelOnError: cancelOnError);
  }

  Stream<T> asBroadcastStream({void onListen(StreamSubscription subscription),
                               void onCancel(StreamSubscription subscription)})
      => _streamController.stream;

  bool get isBroadcast => true;

  void add(T event) {
    if (event.type == _type) _streamController.add(new KeyEventX(event));
  }
}

class InvalidKeyName extends Error {
  final message;
  InvalidKeyName(this.message): super();
}

class InvalidShortCutString extends Error {
  final message;
  InvalidShortCutString(this.message): super();
}
