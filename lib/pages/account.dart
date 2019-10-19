import 'package:Epicture/components/accountResume.dart';
import 'package:Epicture/components/buttons/goToHomeButton.dart';
import 'package:Epicture/components/imageGridTile.dart';
import 'package:Epicture/components/layout.dart';
import 'package:Epicture/components/masonryView.dart';
import 'package:Epicture/objects/accountImage.dart';
import 'package:Epicture/objects/user.dart';
import 'package:Epicture/utils/request.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    List<AccountImage> images = [];
    List<TileSize> tileSizes = [];

    /// Get data futures to one future
    /// Return [Future] of user data and profile pictures
    Future getDataFutures() {
        return Future.wait([this.parseAccountPictures(), this.parseAccount()]);
    }

    /// Parse account picture and return [Future] of request
    Future parseAccountPictures() {
        Future request = getRequest("/account/me/images", "data");

        return request.then((data) {
            List<AccountImage> tmpImages = [];
            List<dynamic> values = data["data"];
            List<TileSize> sizes = [];

            // Get all images
            values.forEach((tmp) {
                AccountImage image = AccountImage.fromJson(tmp);

                // Check for valid type of codec
                if (image.type.startsWith("image")) {
                    image.link = image.link;
                    tmpImages.add(image);

                    // Configure size of tile
                    tileSizes.add(new TileSize(1, 1.0));
                }
            });

            return tmpImages;
        });
    }

    /// Parse account data and return [Future] of request
    Future parseAccount() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String url = "/account/" + prefs.getString("account_username");
        Future request = getRequest(url, "data");

        // Parse value and add it to object
        return request.then((data) => User.fromJson(data['data']));
    }

    // Log-out user
    void logout() {
        SharedPreferences.getInstance().then((prefs) => prefs.clear());

        // Redirect to webview
        Navigator.of(context).pushReplacementNamed('/login');
    }

    /// On state init
    @override
    void initState() {
        super.initState();

        // Get all futures and load into view
        this.getDataFutures()
            .then((results) => this.setState(() {
                images = results[0];
                userData = results[1];
                loaded = true;
            }));
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
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Row(
                                    children: <Widget>[
                                        GoToHomeButton(),
                                        Text("Account",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 40.0,
                                                fontFamily: "Calibre-Semibold",
                                                letterSpacing: 1.0,
                                            )
                                        ),
                                    ],
                                ),

                                Padding(
                                    padding: EdgeInsets.only(bottom: 10, right: 10),
                                    child: IconButton(
                                        onPressed: this.logout,
                                        icon: Icon(Icons.exit_to_app,
                                            color: Colors.white,
                                            size: 25,
                                        ),
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

                                                    // Account small resume
                                                    AccountResume(userData: this.userData, imageLength: this.images.length),

                                                    // Picture image
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
                                            ),

                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                    padding: EdgeInsets.only(top: 20, bottom: 10),
                                                    child: Text("My Uploads",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 30.0,
                                                            fontFamily: "Calibre-Semibold",
                                                            letterSpacing: 1.0,
                                                        )
                                                    ),
                                                ),
                                            ),

                                            SizedBox(
                                                width: MediaQuery.of(context).size.width,
                                                height: MediaQuery.of(context).size.height - 430,
                                                child: GridView.count(
                                                    //cacheExtent: 12,
                                                    children: List.generate(this.images.length, (int index) {
                                                        return ImageGridTile(image: this.images[index]);
                                                    }),
                                                    crossAxisCount: 2,
                                                )
                                            ),

                                        ],
                                    ),
                                )
                            ],
                        ),
                    ),
                ],
            ),
        );
    }

}