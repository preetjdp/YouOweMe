import 'package:YouOweMe/ui/IntroFlow/loginUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NamePage extends StatefulWidget {
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
    String userName = nameController.text;
    Provider.of<LoginUser>(context, listen: false).addName(userName);
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController =
        Provider.of<PageController>(context, listen: false);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Let's Start With a name?",
                    style: Theme.of(context).textTheme.headline1),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: nameController,
                  cursorColor: Theme.of(context).accentColor,
                  onSubmitted: (String name) => nextPage(),
                  decoration: InputDecoration(
                    hintText: "Don Joe",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(0),
                  ),
                  style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).accentColor),
                ),
                Image.network(
                    "https://assets-ouch.icons8.com/preview/795/f06ec0b1-e3ee-4605-aab1-fb12f9336442.png")
              ],
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
                    child: Text("Psst. I already have a account")),
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
