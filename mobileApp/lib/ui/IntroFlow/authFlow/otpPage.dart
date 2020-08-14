// 🐦 Flutter imports:
import 'package:YouOweMe/ui/Abstractions/yomButton.dart';
import 'package:YouOweMe/ui/Abstractions/yomSpacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:basics/basics.dart';

// 🌎 Project imports:
import 'package:YouOweMe/ui/IntroFlow/providers.dart';
import 'package:YouOweMe/ui/IntroFlow/loginUser.dart';

class OtpPage extends StatefulHookWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController otpController = TextEditingController();
  final YomButtonController yomButtonController = YomButtonController();

  @override
  Widget build(BuildContext context) {
    final PageController pageController =
        useProvider(introFlowPageControllerProvider);
    final LoginUser introFlowUser = useProvider(introFlowUserProvider);
    final _size = MediaQuery.of(context).size;

    SizedBox _spacer(int padding, [int minus = 0]) {
      return SizedBox(height: (_size.height / padding) - minus);
    }

    void nextPage() {
      pageController.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeInOutQuad);
    }

    void verifyOtp() async {
      try {
        if (otpController.text.length == 0) {
          throw "OTP not mentioned";
        }
        yomButtonController.showLoading();
        AuthCredential otpCredential = PhoneAuthProvider.credential(
            verificationId: introFlowUser.verificationCode,
            smsCode: otpController.text);

        UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(otpCredential);

        if (authResult.isNotNull) {
          if (introFlowUser.userName.isNotNull &&
              introFlowUser.userName.isNotEmpty) {
            await FirebaseFirestore.instance
                .collection("users")
                .doc(authResult.user.uid)
                .update({'name': introFlowUser.userName});
          }
          final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics();
          firebaseAnalytics.setUserId(authResult.user.uid);
          firebaseAnalytics.logLogin();
          await yomButtonController.showSuccess();
          nextPage();
        }
      } catch (e) {
        print(e);
        yomButtonController.showError();
      }
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
                  YomSpacer(
                    height: 5,
                  ),
                  Text(
                    "You should have received the OTP on your messages app, if not you'll get it in the next minute.",
                    style: GoogleFonts.poppins(),
                  ),
                  _spacer(16),
                  Center(
                    child: PinCodeTextField(
                      controller: otpController,
                      onDone: (_) => verifyOtp(),
                      pinBoxRadius: 15,
                      maxLength: 6,
                      autofocus: true,
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
              left: 0,
              right: 0,
              height: 60,
              child: YomButton(
                  controller: yomButtonController,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Text('Verify One Time Password'),
                  onPressed: verifyOtp))
        ],
      ),
    );
  }
}
