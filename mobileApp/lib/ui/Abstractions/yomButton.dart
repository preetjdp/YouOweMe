// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:rxdart/rxdart.dart';
import 'package:basics/basics.dart';

// 🌎 Project imports:
import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';

const _defaultYomButtonIconSize = 20.0;

/// YomButton is a abtracted Button to be used along with
/// `YomButtonController` to easily show and manage microanimations.
/// If a `YomButtonController` is not passed acts like any other Button in the tree.
class YomButton extends StatelessWidget {
  final YomButtonController controller;

  final Widget child;

  final Widget loading;

  final Widget error;

  final Widget success;

  final VoidCallback onPressed;

  final Color backgroundColor;

  YomButton({
    this.controller,
    @required this.child,
    @required this.onPressed,
    this.loading,
    this.error,
    this.success,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget _buttonChild;
    Color _buttonBackgroundColor =
        this.backgroundColor ?? Theme.of(context).accentColor;
    Brightness _buttonBrightness =
        ThemeData.estimateBrightnessForColor(_buttonBackgroundColor);

    Color _iconsColor;
    if (_buttonBrightness == Brightness.dark) {
      _iconsColor = Theme.of(context).scaffoldBackgroundColor;
    } else {
      _iconsColor = Theme.of(context).accentColor;
    }
    return StreamBuilder<YomButtonState>(
        stream: controller?.state ?? YomButtonController().state,
        builder: (BuildContext context, snapshot) {
          YomButtonState buttonState = snapshot?.data ?? YomButtonState.ACTIVE;
          if (buttonState == YomButtonState.ACTIVE) {
            _buttonChild = child;
          } else if (buttonState == YomButtonState.LOADING) {
            _buttonChild = this.loading ??
                SizedBox(
                  height: _defaultYomButtonIconSize,
                  width: _defaultYomButtonIconSize,
                  child: YOMSpinner(
                    brightness: _buttonBrightness,
                  ),
                );
          } else if (buttonState == YomButtonState.ERROR) {
            _buttonChild = this.error ??
                Icon(
                  Icons.error_outline,
                  size: _defaultYomButtonIconSize,
                  color: _iconsColor,
                );
          } else if (buttonState == YomButtonState.SUCCESS) {
            _buttonChild = this.success ??
                Icon(
                  Icons.check_circle_outline,
                  size: _defaultYomButtonIconSize,
                  color: _iconsColor,
                );
          }

          return CupertinoButton(
            color: _buttonBackgroundColor,
            child: AnimatedSwitcher(
                switchInCurve: Curves.easeInSine,
                duration: Duration(milliseconds: 200),
                child: _buttonChild),
            onPressed: onPressed,
          );
        });
  }
}

enum YomButtonState { ACTIVE, LOADING, ERROR, SUCCESS }

/// Controller To be used in conjunction with
/// `YomButton`
class YomButtonController {
  BehaviorSubject<YomButtonState> _yomButtonSubject =
      BehaviorSubject.seeded(YomButtonState.ACTIVE);

  Stream<YomButtonState> get state => _yomButtonSubject.stream;

  void showActive() {
    setButtonState(YomButtonState.ACTIVE);
  }

  void showLoading({Future future}) {
    setButtonState(YomButtonState.LOADING);
    print(future.isNotNull);
    if (future.isNotNull)
      future.then((value) => this.showActive(),
          onError: (a) => this.showError());
  }

  void showError() {
    setButtonState(YomButtonState.ERROR);
    Future.delayed(Duration(seconds: 2), () => this.showActive());
  }

  void showSuccess() {
    setButtonState(YomButtonState.SUCCESS);
    Future.delayed(Duration(seconds: 2), () => this.showActive());
  }

  void setButtonState(YomButtonState state) {
    _yomButtonSubject.add(state);
  }
}
