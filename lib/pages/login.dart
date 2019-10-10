import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// LoginPage class
/// StatefulWidget class
class Login extends StatefulWidget {
    @override
    State createState() => new LoginState();
}

/// LoginPageState class
/// Extended class state
class LoginState extends State<Login> with SingleTickerProviderStateMixin {
    final flutterWebViewPlugin = FlutterWebviewPlugin();
    final String url = "https://api.imgur.com/oauth2/authorize?client_id=9f0153451f88a91&response_type=token";

    /// On URL in webview is changed
    void onURLChanged(url) async {
        SharedPreferences.getInstance().then((prefs) {
            if (mounted && url.toString().startsWith("https://app.getpostman.com/oauth2/callback#")) {
                Map<String, String> queries = Uri.splitQueryString(url.toString().replaceAll("https://app.getpostman.com/oauth2/callback#", ""));
                prefs.setString("access_token", queries["access_token"]);
                prefs.setString("expires_in", queries["expires_in"]);
                prefs.setString("refresh_token", queries["refresh_token"]);
                prefs.setString("account_username", queries["account_username"]);
                prefs.setString("account_id", queries["account_id"]);

                // Important to close webview, and redirect to dashboard view
                flutterWebViewPlugin.close();
                Navigator.of(context).pushReplacementNamed('/dashboard');
            }
        });
    }

    /// Configure listeners on webview creation
    @override
    void initState() {
        super.initState();
        flutterWebViewPlugin.onUrlChanged.listen(this.onURLChanged);
    }

    /// Destroy webview when widget is closed
    @override
    void dispose() {
        super.dispose();
        flutterWebViewPlugin.dispose();
    }

    /// Build widget
    @override
    Widget build(BuildContext context) {
        return new SafeArea(
            child: WebviewScaffold(
                url: url,
                appCacheEnabled: false,
                clearCookies: true,
                clearCache: true,
                withJavascript: true,
            )
        );
    }
}
