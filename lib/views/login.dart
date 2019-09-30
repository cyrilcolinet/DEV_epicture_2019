import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../views/browser.dart';
import '../main.dart' as main;

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
    final flutterWebViewPlugin = FlutterWebviewPlugin();
    String url = "https://api.imgur.com/oauth2/authorize?client_id=9f0153451f88a91&response_type=token";

  Widget build(BuildContext context) {
    flutterWebViewPlugin.onUrlChanged.listen((url) {
      if (mounted) {
        print("Current URL: $url");
        List<String> l = url.split("#");
        List<String> tmp;
        int i = -1;
        l = l[1].split("&");
        while(++i < l.length) {
          tmp = l[i].split("=");
          if (i == 0)
            main.acces_token = tmp[1];
          if (i == 3)
            main.refresh_token = tmp[1];
          if (i == 5)
            main.account_id = tmp[1];
          if (i == 4)
            main.account_username = tmp[1];
        }
        main.header = {"Authorization": "Bearer " + main.acces_token};
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BrowserView()),
        );
      }
    });
    return WebviewScaffold(
      appBar: AppBar(
      ),
      url: url,
    );

  }
}