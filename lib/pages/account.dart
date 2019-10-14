import 'package:epicture/components/buttons/goToHomeButton.dart';
import 'package:epicture/components/layout.dart';
import 'package:epicture/components/masonryView.dart';
import 'package:epicture/objects/user.dart';
import 'package:epicture/request/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:epicture/objects/accountImage.dart' as object;

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
    List<object.AccountImage> images = [];

    final List<TileSize> tileSizes = [
        new TileSize(1, 1.0),
        new TileSize(1, 1.0),
        new TileSize(1, 2.0),
        new TileSize(1, 1.0),
        new TileSize(2, 1.0),
        new TileSize(1, 2.0),
        new TileSize(1, 1.0),
        new TileSize(2, 2.0),
        new TileSize(2, 1.0),
        new TileSize(1, 1.0),
        new TileSize(2, 2.0),
        new TileSize(2, 1.0),
        new TileSize(1, 2.0),
        new TileSize(2, 4.0),
        new TileSize(3, 1.0),
        new TileSize(4, 2.0),
        new TileSize(1, 1.0),
        new TileSize(3, 2.0),
        new TileSize(2, 1.0),
    ];


    /// Get data futures to one future
    /// Return [Future] of user data and profile pictures
    Future getDataFutures() {
        return Future.wait([this.parseAccountPictures(), this.parseAccount()]);
    }

    /// Parse account picture and return [Future] of request
    Future parseAccountPictures() {
        Future request = getRequest("/account/me/images", "data");

        return request.then((data) {
            List<object.AccountImage> tmpImages = [];
            List<dynamic> values = data["data"];

            print(data);

            // Get all images
            values.forEach((tmp) {
                object.AccountImage image = object.AccountImage.fromJson(tmp);

                // Check for valid type of codec
                if (image.type.startsWith("image")) {
                    image.link = image.link;
                    tmpImages.add(image);
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

    /// On state init
    @override
    void initState() {
        super.initState();

        // Get all futures and load into view
        List tmpImages;
        User user;
        this.getDataFutures()
            .then((results) => this.setState(() {
                images = results[0];
                print(images);
                userData = results[1];
                print(userData.toJson().toString());
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
                        padding: EdgeInsets.only(left: 20.0, top: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                GoToHomeButton(),
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
                                                                        Expanded(
                                                                            child: Column(
                                                                                children: <Widget>[
                                                                                    Text("Reputation"),
                                                                                    Text(userData.reputation.toString())
                                                                                ],
                                                                            ),
                                                                        ),
                                                                        Expanded(
                                                                            child: Column(
                                                                                children: <Widget>[
                                                                                    Text("Grade"),
                                                                                    Text(userData.reputationName)
                                                                                ],
                                                                            ),
                                                                        ),
                                                                        Expanded(
                                                                            child: Column(
                                                                                children: <Widget>[
                                                                                    Text("Created"),
                                                                                    Text(userData.created.toString())
                                                                                ],
                                                                            ),
                                                                        ),
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
                                            ),

                                            SizedBox(
                                                width: MediaQuery.of(context).size.width,
                                                height: MediaQuery.of(context).size.height - 170,
                                                child: MasonryView.builder(
                                                    padding: new EdgeInsets.only(top: 10.0),
                                                    itemCount: this.images.length,
                                                    mainAxisSpacing: 10.0,
                                                    crossAxisSpacing: 10.0,
                                                    mainAxisRatio: 1.0,
                                                    crossAxisSpans: 4,
                                                    itemBuilder: this.buildImagesMasonry,
                                                    tileSizeBuilder: (index) {
                                                        if (index >= tileSizes.length) return null;
                                                        return tileSizes[index];
                                                    }
                                                ),
                                            )
                                        ],
                                    ),
                                )
                            ],
                        ),
                    ),
                    /*CardScrollFeed(
                        images: this.images,
                        titles: this.titles
                    ),*/
                ],
            ),
        );
    }

    Widget buildImagesMasonry(BuildContext context, int index) {
        if (index >= tileSizes.length)
            return null;

        // Image with loader
        return ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(3.0, 6.0),
                            blurRadius: 10.0
                        )
                    ]
                ),
                child: FadeInImage(
                    image: NetworkImage(this.images[index].link),
                    placeholder: AssetImage("assets/images/placeholder-img.jpg"),
                )
            ),
        );
    }

}