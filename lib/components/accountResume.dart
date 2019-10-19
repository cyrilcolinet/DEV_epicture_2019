import 'package:Epicture/objects/user.dart';
import 'package:flutter/material.dart';

class AccountResume extends StatelessWidget {

    final User userData;
    final int imageLength;

    AccountResume({@required this.userData, @required this.imageLength});

    @override
    Widget build(BuildContext context) {
        return Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.only(top: 16.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0)
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 96.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                Text(userData.url, style: Theme.of(context).textTheme.title),
                                SizedBox(height: 30)
                            ],
                        ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                        children: <Widget>[
                            Expanded(
                                child: Column(
                                    children: <Widget>[
                                        Text("Reputation", style: TextStyle(color: Colors.black)),
                                        Text(userData.reputation.toString(), style: TextStyle(color: Colors.black))
                                    ],
                                ),
                            ),
                            Expanded(
                                child: Column(
                                    children: <Widget>[
                                        Text("Grade", style: TextStyle(color: Colors.black)),
                                        Text(userData.reputationName, style: TextStyle(color: Colors.black))
                                    ],
                                ),
                            ),
                            Expanded(
                                child: Column(
                                    children: <Widget>[
                                        Text("Uploads", style: TextStyle(color: Colors.black)),
                                        Text(imageLength.toString(), style: TextStyle(color: Colors.black))
                                    ],
                                ),
                            ),
                        ],
                    ),
                ],
            ),
        );
    }
}