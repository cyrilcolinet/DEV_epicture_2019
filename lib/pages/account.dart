import 'package:epicture/components/layout.dart';
import 'package:epicture/objects/user.dart';
import 'package:epicture/request/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Account class
/// Stateful widget extend
class Account extends StatefulWidget {
    @override
    _Account createState() => _Account();
}

/// Account state configuration
class _Account extends State<Account> {
    bool loaded = false;
    User userData;

    void getAccountSettings() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String url = "https://api.imgur.com/3/account/" + prefs.getString("account_username");
        Future<Map<String, dynamic>> request = getRequest(url, "data");

        // Parse value and add it to object
        request.then((data) => this.setState(() {
            userData = User.fromJson(data['data']);
            loaded = true;
        }));
    }

    /// On state init
    @override
    void initState() {
        super.initState();
        this.getAccountSettings();
    }

    /// Build account content
    @override
    Widget build(BuildContext context) {
        return Layout(body: this.displayContent());
    }

    /// Display content of widget
    Widget displayContent() {
        if (!loaded) {
            return SizedBox(
                height: MediaQuery.of(context).size.height - 130,
                child: SpinKitFadingCube(
                    color: Colors.white,
                    size: 60,
                ),
            );
        }

        return SingleChildScrollView(
            child: Column(
                children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Text("Account",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40.0,
                                        fontFamily: "Calibre-Semibold",
                                        letterSpacing: 1.0,
                                    )
                                )
                            ],
                        ),
                    ),

                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Stack(
                            children: <Widget>[
                                Container(
                                    child: Column(
                                        children: <Widget>[
                                            Stack(
                                                children: <Widget>[
                                                    Container(
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
                                                                            Text(userData.url, style: Theme.of(context).textTheme.title,),
                                                                            SizedBox(height: 30)
                                                                        ],
                                                                    ),
                                                                ),
                                                                SizedBox(height: 10.0),
                                                                Row(
                                                                    children: <Widget>[
                                                                        Expanded(child: Column(
                                                                            children: <Widget>[
                                                                                Text("Reputation"),
                                                                                Text(userData.reputation.toString())
                                                                            ],
                                                                        ),),
                                                                        Expanded(child: Column(
                                                                            children: <Widget>[
                                                                                Text("Grade"),
                                                                                Text(userData.reputationName)
                                                                            ],
                                                                        ),),
                                                                        Expanded(child: Column(
                                                                            children: <Widget>[
                                                                                Text("Created"),
                                                                                Text(userData.created.toString())
                                                                            ],
                                                                        ),),
                                                                    ],
                                                                ),
                                                            ],
                                                        ),
                                                    ),
                                                    Container(
                                                        height: 80,
                                                        width: 80,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10.0),
                                                            image: DecorationImage(
                                                                image: NetworkImage(userData.avatar),
                                                                fit: BoxFit.cover
                                                            )
                                                        ),
                                                        margin: EdgeInsets.only(left: 16.0),
                                                    ),
                                                ],
                                            )
                                        ],
                                    ),
                                )
                            ],
                        ),
                    )
                ],
            ),
        );
    }

}