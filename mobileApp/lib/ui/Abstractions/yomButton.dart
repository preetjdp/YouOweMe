import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:basics/basics.dart';

/// YomButton is a abtracted Button to be used along with
/// `YomButtonController` to easily show microanimated
/// 
class YomButton extends StatelessWidget {
  final YomButtonController controller;

  final Widget child;

  final Widget loading;

  final Widget error;

  final Widget success;

  final VoidCallback onPressed;

  final Color backgroundColor;

  YomButton({
    @required this.controller,
    @required this.child,
    @required this.onPressed,
    this.loading,
    this.error,
    this.success,
    this.backgroundColor,
  }) : assert(controller != null);

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
        stream: controller.state,
        builder: (BuildContext context, snapshot) {
          YomButtonState buttonState = snapshot?.data ?? YomButtonState.ACTIVE;
          if (buttonState == YomButtonState.ACTIVE) {
            _buttonChild = child;
          } else if (buttonState == YomButtonState.LOADING) {
            _buttonChild = this.loading ??
                YOMSpinner(
                  brightness: _buttonBrightness,
                );
          } else if (buttonState == YomButtonState.ERROR) {
            _buttonChild = this.error ??
                Icon(
                  Icons.error_outline,
                  color: _iconsColor,
                );
          } else if (buttonState == YomButtonState.SUCCESS) {
            _buttonChild = this.success ??
                Icon(
                  Icons.check_circle_outline,
                  color: _iconsColor,
                );
          }

          return CupertinoButton(
            color: _buttonBackgroundColor,
            child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200), child: _buttonChild),
            onPressed: onPressed,
          );
        });
  }
}

enum YomButtonState {
  ACTIVE,
//  INACTIVE,
  LOADING,
  ERROR,
  SUCCESS
}

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
  }

  void showSuccess() {
    setButtonState(YomButtonState.SUCCESS);
  }

  void setButtonState(YomButtonState state) {
    _yomButtonSubject.add(state);
  }
}
