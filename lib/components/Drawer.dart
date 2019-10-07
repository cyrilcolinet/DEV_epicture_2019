import 'package:epicture/components/customIcons.dart';
import 'package:flutter/material.dart';
import 'package:epicture/request/request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlideMenu extends StatefulWidget {
  @override
  _SlideMenu createState() => new _SlideMenu();
}

Future<String> getAccountSetting() async {
  print("getting account settings");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = "https://api.imgur.com/3/account/" + prefs.getString("account_username") + "/avatar";
  var request = getRequest(url, "data");

  request.then((value) {
    print("LINK : " + value["data"]["avatar"]);
    return(value["data"]["avatar"]);
  });
}

class _SlideMenu extends State<SlideMenu> {
  String avatarURL = "";

  @override
  void initState() {
    super.initState();
    getAccountSetting().then((onValue) {
      this.setState(() {
        this.avatarURL = onValue;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new ListTile(
              title: new Text("Account"),
              trailing: new Icon(Icons.arrow_upward),
              onTap: () {}
          ),
          new ListTile(
              title: new Text("Disconnect"),
              trailing: new Icon(Icons.arrow_upward),
              onTap: () {}
          ),
        ],
      ),
    );
  }
}