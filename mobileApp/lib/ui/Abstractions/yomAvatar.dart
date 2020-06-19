// 🐦 Flutter imports:
import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/ui/Abstractions/yomTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:basics/basics.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:YouOweMe/resources/extensions.dart';

class YomAvatar extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;
  YomAvatar.fromUser(
      {@required Seva$Query$User user,
      this.onPressed,
      this.size = 45,
      this.borderRadius})
      : child = _childFromUser(user);

  YomAvatar.fromOweUser(
      {@required Seva$Query$User$Owe$User user,
      this.onPressed,
      this.size = 45,
      this.borderRadius})
      : child = _childFromOweUser(user);

  YomAvatar(
      {@required this.child,
      this.onPressed,
      this.size = 45,
      this.borderRadius});

  YomAvatar.fromText(
      {@required String text,
      this.onPressed,
      this.size = 45,
      this.borderRadius})
      : child = _childFromText(text);

  static Widget _childFromUser(Seva$Query$User user) {
    if (user.isNull) {
      return _childEmpty();
    }
    if (user.image.isNull) {
      return _childFromText(user.shortName);
    }
    return BlurHash(
        hash: user.imageHash, image: user.image, color: Colors.transparent);
  }

  static Widget _childFromOweUser(Seva$Query$User$Owe$User user) {
    if (user.isNull) {
      return _childEmpty();
    }
    if (user.image.isNull) {
      return _childFromText(user.shortName);
    }
    return BlurHash(
        hash: user.imageHash, image: user.image, color: Colors.transparent);
  }

  static Widget _childFromText(String text) {
    return Center(
      child: Text(
        text ?? "",
        style: const TextStyle(
          color: CupertinoColors.white,
          fontSize: 13.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static Widget _childEmpty() {
    return Container();
  }

  final VoidCallback onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).accentColor;
    return CupertinoButton(
      minSize: 0,
      onPressed: onPressed,
      padding: EdgeInsets.all(0),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [context.yomDesign.yomBoxShadow],
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: <Color>[
              color,
              Color.fromARGB(
                color.alpha,
                (color.red + 50).clamp(0, 255) as int,
                (color.green + 50).clamp(0, 255) as int,
                (color.blue + 50).clamp(0, 255) as int,
              ),
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(size),
          child: child,
        ),
      ),
    );
    // return CupertinoButton(
    //   minSize: 0,
    //   onPressed: onPressed,
    //   padding: EdgeInsets.all(0),
    //   child: Container(
    //     height: size,
    //     width: size,
    //     decoration: BoxDecoration(
    //       shape: BoxShape.circle,
    //       gradient: LinearGradient(
    //         begin: FractionalOffset.topCenter,
    //         end: FractionalOffset.bottomCenter,
    //         colors: <Color>[
    //           color,
    //           Color.fromARGB(
    //             color.alpha,
    //             (color.red + 50).clamp(0, 255) as int,
    //             (color.green + 50).clamp(0, 255) as int,
    //             (color.blue + 50).clamp(0, 255) as int,
    //           ),
    //         ],
    //       ),
    //     ),
    //     padding: const EdgeInsets.all(12.0),
    //     child: Center(
    //       child: Text(
    //         text,
    //         style: const TextStyle(
    //           color: CupertinoColors.white,
    //           fontSize: 13.0,
    //           fontWeight: FontWeight.w500,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
