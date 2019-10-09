import 'package:flutter/material.dart';
import 'package:epicture/request/request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


/// AccountView class
/// StatefulWidget class
class AccountView extends StatefulWidget {
  @override
  State createState() => new _AccountView();
}

Future<Map<String, dynamic>> getAccountSetting() async {
  print("getting account settings");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = "https://api.imgur.com/3/account/" + prefs.getString("account_username");
  var request = getRequest(url, "data");
  return request.then((value) {
    print(value);
    return(value);
  });
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
      width: 3
    ),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),

  );
}
class _AccountView extends State<AccountView> {
  var accountData;
  var loaded = false;

  @override
  void initState() {
    super.initState();
    getAccountSetting().then((onValue) {
      this.setState(() {
        print("SETING STATE");
        print(onValue);
        this.accountData = onValue;
        this.loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 130,
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 60,
        ),
      );
    }
    print("HERE");
    print(this.accountData);
    return new Scaffold(
      backgroundColor: Color(0xFF1b1e44),
      body: new Padding(
          padding: EdgeInsets.all(8.0),
        child: new Container(
          margin: const EdgeInsets.only(top: 30.0),
          decoration: myBoxDecoration(),
          width: 350,
          height: 300,
          child: new Column(
            children: <Widget>[
              Text(this.accountData["data"]["url"],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 46.0,
                  fontFamily: "Calibre-Semibold",
                  letterSpacing: 1.0,
                ),
              ),
              Image.network(this.accountData["data"]["avatar"], fit: BoxFit.cover),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    Align(
                        heightFactor: 2.2,
                        widthFactor: 2.65,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: <Widget>[
                            Text("Réputation Score",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontFamily: "Calibre-Semibold",
                                letterSpacing: 1.0,
                              ),
                            ),
                            Text(this.accountData["data"]["reputation"].toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontFamily: "Calibre-Semibold",
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        )
                    ),
                    Align(
                        heightFactor: 0.0,
                        widthFactor: 0.0,
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: <Widget>[
                            Text("Réputation Name",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontFamily: "Calibre-Semibold",
                                letterSpacing: 1.0,
                              ),
                            ),
                            Text(this.accountData["data"]["reputation_name"].toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontFamily: "Calibre-Semibold",
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

