# Ctrl Alt Foo

[![Build Status](https://drone.io/github.com/eee-c/ctrl-alt-foo/status.png)](https://drone.io/github.com/eee-c/ctrl-alt-foo/latest)

Keyboard event library to support cross-browser, _testable_ keyboard events. This is an attempt to smooth out some of the current bugs in [KeyEvent](http://api.dartlang.org/docs/releases/latest/dart_html/KeyEvent.html) as well as to add a few helper methods.

## Usage

This is an early preview release and the syntaxt is not settled. Please add issues in the tracker if you have suggestions. For the most part, this library tries to stay true to `KeyEvent` and the upcoming KeyboardEvent JavaScript interface.

The easiest way to use this is to create a `KeyboardEventStreamX` stream on an element in a page.

````dart
import 'package:ctrl_alt_foo/key_event_x.dart';

KeyboardEventStreamX.onKeyDown(document).listen((e) {
  if (e.isCtrl('N')) {
    new NewProjectDialog(this).open();
    e.preventDefault();
  }
  if (e.isCtrl('O')) {
    new OpenDialog(this).open();
    e.preventDefault();
  }
  if (e.isCtrlShift('H')) {
    toggleCode();
    e.preventDefault();
  }
});
````

There are also some helper methods for creating keyboard events:

````dart
import 'package:ctrl_alt_foo/helpers.dart';

typeIn('TEXT'); // will generate a keyup

hitEnter();
hitEscape();

arrowUp(); // optionally supply the number of time to arrow up
arrowDown();

type('A'); // type a single character
typeCtrl('A'); // type Ctrl+A
typeCtrlShift('A'); // type Ctrl+Shift+A
````

## LICENSE

This code is licensed under the MIT license. See LICENSE for more information.
