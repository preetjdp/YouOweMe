import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class OtpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void nextPage() {
      Provider.of<PageController>(context, listen: false).nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeInOutQuad);
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
                  pinBoxRadius: 15,
                  maxLength: 4,
                  pinTextStyle: Theme.of(context).textTheme.headline3,
                  wrapAlignment: WrapAlignment.center,
                  highlightColor: Theme.of(context).accentColor,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false, signed: false),
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
                    onPressed: nextPage),
              ))
        ],
      ),
    );
  }
}
