// 🐦 Flutter imports:
import 'package:YouOweMe/ui/IntroFlow/loginUser.dart';
import 'package:YouOweMe/ui/IntroFlow/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NamePage extends StatefulHookWidget {
  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.addListener(() => setName());
  }

  void setName() {
    LoginUser introFlowUser = introFlowUserProvider.read(context);
    String userName = nameController.text;
    introFlowUser.addName(userName);
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController =
        useProvider(introFlowPageControllerProvider);
    final _size = MediaQuery.of(context).size;

    SizedBox _spacer(int padding, [int minus = 0]) {
      return SizedBox(height: (_size.height / padding) - minus);
    }

    void nextPage() {
      pageController.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeInOutQuad);
    }

    void next() {
      if (nameController.text.length == 0) {
        return;
      }
      setName();
      nextPage();
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
                    "Let's Start With a Name?",
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontSize: _size.width / 8),
                  ),
                  _spacer(16),
                  TextField(
                    controller: nameController,
                    cursorColor: Theme.of(context).accentColor,
                    onSubmitted: (String name) => next(),
                    decoration: InputDecoration(
                      hintText: "Don Joe",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(0),
                    ),
                    style: TextStyle(
                      fontSize: _size.width / 8,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  _spacer(12),
                  Image.asset("assets/scribbles/karlsson_holding_book.png")
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                CupertinoButton(
                  onPressed: nextPage,
                  padding: EdgeInsets.all(0),
                  minSize: 0,
                  child: Text("Psst. I already have a account"),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 60,
                  width: 400,
                  child: CupertinoButton(
                      color: Theme.of(context).accentColor,
                      child: Text('Next'),
                      onPressed: next),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
