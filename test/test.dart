library ctrl_alt_foo_test;

import 'package:ctrl_alt_foo/key_event_x.dart';

import 'package:unittest/unittest.dart';
import 'dart:html';
import 'dart:async';

import 'package:ctrl_alt_foo/helpers.dart';

main(){
  var _s;
  tearDown((){
    _s.cancel();
  });

  test("can listen for key events", (){
    _s = KeyboardEventStreamX.onKeyDown(document).listen(expectAsync1((e) {
      expect(e.isKey('A'), true);
    }));

    type('A');
  });

  test("can listen for Ctrl shortcuts", (){
    _s = KeyboardEventStreamX.onKeyDown(document).listen(expectAsync1((e) {
      expect(e.isCtrl('A'), true);
    }));

    typeCtrl('A');
  });

  test("can listen for Ctrl-Shift shortcuts", (){
    _s = KeyboardEventStreamX.onKeyDown(document).listen(expectAsync1((e) {
      expect(e.isCtrlShift('A'), true);
    }));

    typeCtrlShift('A');
  });

  pollForDone(testCases);
}

pollForDone(List tests) {
  if (tests.every((t)=> t.isComplete)) {
    window.postMessage('done', window.location.href);
    return;
  }

  var wait = new Duration(milliseconds: 100);
  new Timer(wait, ()=> pollForDone(tests));
}
