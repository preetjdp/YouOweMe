import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:YouOweMe/ui/IntroFlow/loginUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MobilePage extends StatefulWidget {
  @override
  _MobilePageState createState() => _MobilePageState();
}

class _MobilePageState extends State<MobilePage> {
  final TextEditingController mobileNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                  Navigator.pop(context, nextPage);
                  print(exception.message);
                },
                codeSent: (a, [b]) {
                  print("SMS sent");
                },
                codeAutoRetrievalTimeout: (a) {
                  print("Timeout" + a);
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
                Text("What's Your Mobile Number?",
                    style: Theme.of(context).textTheme.headline1),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "+91",
                      style: TextStyle(
                          fontSize: 60,
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
                              fontSize: 60,
                              color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: false, signed: false)),
                    ),
                  ],
                ),
                Image.network(
                    "https://assets-ouch.icons8.com/preview/399/2b2eae62-1f9d-4e5a-a6ed-4bbac2160121.png")
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
                    onPressed: phoneAuth),
              ))
        ],
      ),
    );
  }
}
