// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

// 🌎 Project imports:
import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:YouOweMe/ui/IntroFlow/loginUser.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    SizedBox _spacer(int padding, [int minus = 0]) {
      return SizedBox(height: (_size.height / padding) - minus);
    }

    LoginUser loginUser = Provider.of<LoginUser>(context, listen: false);

    void nextPage() {
      Provider.of<PageController>(context, listen: false).nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeInOutQuad);
    }

    void verifyOtp() async {
      if (otpController.text.length == 0) {
        return;
      }
      AuthCredential otpCredential = PhoneAuthProvider.getCredential(
          verificationId: loginUser.verificationCode,
          smsCode: otpController.text);

      VoidCallback callback = await showCupertinoModalPopup<VoidCallback>(
          context: context,
          builder: (BuildContext context) {
            print(loginUser.verificationCode);
            FirebaseAuth.instance
                .signInWithCredential(otpCredential)
                .then((result) {
              if (result.user != null) {
                //The logic to add update the userName on new login
                if (loginUser.userName != null &&
                    loginUser.userName.isNotEmpty) {
                  Firestore.instance
                      .collection("users")
                      .document(result.user.uid)
                      .updateData({'name': loginUser.userName});
                }
                final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics();
                firebaseAnalytics.setUserId(result.user.uid);
                firebaseAnalytics.logLogin();
                Navigator.pop(context, nextPage);
                return;
              }
              print("Wrong OTP");
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
                    "Enter the\nOTP",
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontSize: _size.width / 8),
                  ),
                  _spacer(16),
                  Center(
                    child: PinCodeTextField(
                      controller: otpController,
                      onDone: (_) => verifyOtp(),
                      pinBoxRadius: 15,
                      maxLength: 6,
                      pinBoxHeight: _size.width / 8,
                      pinBoxWidth: _size.width / 8,
                      pinTextStyle: Theme.of(context).textTheme.headline5,
                      wrapAlignment: WrapAlignment.center,
                      highlightColor: Theme.of(context).accentColor,
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: false, signed: false),
                    ),
                  ),
                  _spacer(12),
                  Image.asset("assets/scribbles/karlsson_pincode.png")
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
                  onPressed: verifyOtp),
            ),
          ),
        ],
      ),
    );
  }
}
