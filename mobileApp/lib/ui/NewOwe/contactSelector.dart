import 'package:flutter/material.dart';

class ContactSelector extends StatelessWidget {
  final ScrollController scrollController;
  ContactSelector({@required this.scrollController});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Text(
            "Enter a mobile number",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(78, 80, 88, 1)),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "+91",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).accentColor),
              ),
              Expanded(
                child: TextField(
                    cursorColor: Theme.of(context).accentColor,
                    decoration: InputDecoration(
                      hintText: "00",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(0),
                    ),
                    style: TextStyle(
                        fontSize: 50, color: Theme.of(context).accentColor),
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: false, signed: false)),
              ),
            ],
          ),
          Center(
            child: Text(
              "or".toUpperCase(),
              style: TextStyle(
                  fontSize: 28,
                  color: Theme.of(context).accentColor.withOpacity(0.4),
                  // letterSpacing: 10,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Select Contact From Device",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(78, 80, 88, 1)),
          ),
        ],
      ),
    );
  }
}
