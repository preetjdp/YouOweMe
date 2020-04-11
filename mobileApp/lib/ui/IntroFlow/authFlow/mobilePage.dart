import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MobilePage extends StatelessWidget {
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
                          // onSubmitted: (a) => onMobileNumberTextFieldSubmit,
                          // controller: mobileNoController,
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
                    "https://assets-ouch.icons8.com/preview/795/f06ec0b1-e3ee-4605-aab1-fb12f9336442.png")
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
