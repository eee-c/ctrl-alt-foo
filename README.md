# Ctrl Alt Foo

[![Build Status](https://drone.io/github.com/eee-c/ctrl-alt-foo/status.png)](https://drone.io/github.com/eee-c/ctrl-alt-foo/latest)

Make it easy to listen for keyboard shortcuts / accelator keys.

## Usage

This is an early preview release and the syntax is not settled. Please add issues in the tracker if you have suggestions.

````dart
import 'package:ctrl_alt_foo/keys.dart';

Keys.shortcuts({
  'Esc':          (){ _hideMenu(); _hideDialog(); },
  'Ctrl+N':       ()=> new NewProjectDialog(this).open(),
  'Ctrl+O, ⌘+O':  ()=> new OpenDialog(this).open(),
  'Ctrl+Shift+H': ()=> toggleCode()
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
