// 🐦 Flutter imports:
import 'package:YouOweMe/ui/Abstractions/yomButton.dart';
import 'package:YouOweMe/ui/Abstractions/yomSpacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// 🌎 Project imports:
import 'package:YouOweMe/ui/IntroFlow/providers.dart';
import 'package:YouOweMe/ui/IntroFlow/loginUser.dart';

class MobilePage extends StatefulHookWidget {
  @override
  _MobilePageState createState() => _MobilePageState();
}

class _MobilePageState extends State<MobilePage> {
  final TextEditingController mobileNoController = TextEditingController();
  final YomButtonController yomButtonController = YomButtonController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final PageController pageController =
        useProvider(introFlowPageControllerProvider);
    final LoginUser introFlowUser = useProvider(introFlowUserProvider);

    final TargetPlatform platform = Theme.of(context).platform;
    final _size = MediaQuery.of(context).size;

    SizedBox _spacer(int padding, [int minus = 0]) {
      return SizedBox(height: (_size.height / padding) - minus);
    }

    String phoneNoValidator(String value) {
      if (value.isEmpty) {
        return "Specify the phone number";
      }
      if (value.length != 10) {
        return "Check the number again";
      }
      return null;
    }

    void nextPage() {
      pageController.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeInOutQuad);
    }

    void jumpTwoPages() {
      pageController.animateToPage((pageController.page + 2).toInt(),
          duration: Duration(milliseconds: 200), curve: Curves.easeInOutQuad);
    }

    void phoneAuth() async {
      try {
        if (!_formKey.currentState.validate()) {
          throw "Phone Number Invalid";
        }
        yomButtonController.showLoading();

        String mobileNo = "+91" + mobileNoController.text;
        FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: mobileNo,
            timeout: Duration(seconds: 0),
            verificationCompleted: (AuthCredential credentials) {
              FirebaseAuth.instance.signInWithCredential(credentials);
              Navigator.pop(context, jumpTwoPages);
            },
            verificationFailed: (FirebaseAuthException exception) {
              throw exception;
            },
            codeSent: (a, [b]) {
              if (platform == TargetPlatform.iOS) {
                introFlowUser.addVerificationCode(a);
                yomButtonController.showSuccess();
                nextPage();
              }
              print("SMS sent");
            },
            codeAutoRetrievalTimeout: (a) async {
              print("Timeout" + a);
              if (platform == TargetPlatform.iOS) {
                return;
              }
              introFlowUser.addVerificationCode(a);
              await yomButtonController.showSuccess();
              nextPage();
            });
      } catch (e) {
        print(e);
        yomButtonController.showError();
      }
    }

    return Form(
      key: _formKey,
      child: Padding(
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
                    YomSpacer(
                      height: 5,
                    ),
                    Text(
                      "Your phone number is used to authenticate you, to send and recieve owe requests.",
                      style: GoogleFonts.poppins(),
                    ),
                    _spacer(16),
                    Row(
                      // mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "+91 ",
                          style: TextStyle(
                              fontSize: _size.width / 8,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).accentColor),
                        ),
                        Expanded(
                          child: TextFormField(
                            cursorColor: Theme.of(context).accentColor,
                            validator: phoneNoValidator,
                            controller: mobileNoController,
                            decoration: InputDecoration(
                              hintText: "00",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(0),
                            ),
                            style: TextStyle(
                                fontSize: _size.width / 8,
                                color: Theme.of(context).accentColor),
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: false,
                              signed: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // _spacer(12),
                    Image.asset("assets/scribbles/karlsson_pen_scribble.png")
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 60,
                child: YomButton(
                    controller: yomButtonController,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Text('Autheticate Phone Number'),
                    onPressed: phoneAuth))
          ],
        ),
      ),
    );
  }
}
