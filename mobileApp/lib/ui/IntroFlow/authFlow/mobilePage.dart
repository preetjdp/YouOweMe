// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:YouOweMe/ui/IntroFlow/loginUser.dart';

class MobilePage extends StatefulWidget {
  @override
  _MobilePageState createState() => _MobilePageState();
}

class _MobilePageState extends State<MobilePage> {
  final TextEditingController mobileNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;
    final _size = MediaQuery.of(context).size;

    SizedBox _spacer(int padding, [int minus = 0]) {
      return SizedBox(height: (_size.height / padding) - minus);
    }

    PageController pageController =
        Provider.of<PageController>(context, listen: false);
    LoginUser loginUser = Provider.of<LoginUser>(context, listen: false);

    void nextPage() {
      pageController.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeInOutQuad);
    }

    void jumpTwoPages() {
      pageController.animateToPage((pageController.page + 2).toInt(),
          duration: Duration(milliseconds: 200), curve: Curves.easeInOutQuad);
    }

    void phoneAuth() async {
      if (mobileNoController.text.length == 0) {
        return;
      }
      VoidCallback callback = await showCupertinoModalPopup<VoidCallback>(
          context: context,
          builder: (BuildContext context) {
            String mobileNo = "+91" + mobileNoController.text;
            FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: mobileNo,
                timeout: Duration(seconds: 0),
                verificationCompleted: (AuthCredential credentials) {
                  FirebaseAuth.instance.signInWithCredential(credentials);
                  Navigator.pop(context, jumpTwoPages);
                },
                verificationFailed: (AuthException exception) {
                  // Navigator.pop(context, nextPage);
                  print(exception.message);
                },
               codeSent: (a, [b]) {
                 if(platform == TargetPlatform.iOS) {
                    loginUser.addVerificationCode(a);
                    Navigator.pop(context, nextPage);
                 }   
                  print("SMS sent");
                },
                codeAutoRetrievalTimeout: (a) {
                  print("Timeout" + a);
                  if(platform == TargetPlatform.iOS) {
                    return;
                  }
                  loginUser.addVerificationCode(a);
                  Navigator.pop(context, nextPage);
                });
            return CupertinoPopupSurface(
                child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      "We're Processing the Information.",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Expanded(child: Container()),
                    Center(
                      child: YOMSpinner(),
                    ),
                    Expanded(child: Container())
                  ],
                ),
              ),
            ));
          });
      callback();
    }

    return Padding(
      padding: EdgeInsets.all(15),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            bottom: 65,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _spacer(18, 20),
                  Text(
                    "What's Your Phone Number?",
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontSize: _size.width / 8),
                  ),
                  _spacer(16),
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "+91 ",
                        style: TextStyle(
                            fontSize: _size.width / 8,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).accentColor),
                      ),
                      Expanded(
                        child: TextField(
                          cursorColor: Theme.of(context).accentColor,
                          onSubmitted: (_) => phoneAuth(),
                          controller: mobileNoController,
                          decoration: InputDecoration(
                            hintText: "00",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(0),
                          ),
                          style: TextStyle(
                              fontSize: _size.width / 9,
                              color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: false,
                            signed: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  _spacer(12),
                  Image.asset("assets/scribbles/karlsson_pen_scribble.png")
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                height: 60,
                width: 400,
                child: CupertinoButton(
                    color: Theme.of(context).accentColor,
                    child: Text('Next'),
                    onPressed: phoneAuth),
              ))
        ],
      ),
    );
  }
}
