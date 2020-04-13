import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:YouOweMe/ui/IntroFlow/loginUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                if (loginUser.userName != null) {
                  Firestore.instance
                      .collection("users")
                      .document(result.user.uid)
                      .updateData({'name': loginUser.userName});
                }
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
                      style: Theme.of(context).textTheme.headline1,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Enter \nthe\nOTP",
                    style: Theme.of(context).textTheme.headline1),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: PinCodeTextField(
                  controller: otpController,
                  pinBoxRadius: 15,
                  maxLength: 6,
                  pinBoxHeight: 50,
                  pinBoxWidth: 50,
                  pinTextStyle: Theme.of(context).textTheme.headline3,
                  wrapAlignment: WrapAlignment.center,
                  highlightColor: Theme.of(context).accentColor,
                  // keyboardType: TextInputType.numberWithOptions(
                  //     decimal: false, signed: false),
                )),
                Image.network(
                    "https://assets-ouch.icons8.com/preview/70/cb7862aa-443d-48e1-8c1b-f8ca903c548e.png")
              ],
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
              ))
        ],
      ),
    );
  }
}
