import 'dart:math';

import 'package:epicture/components/customIcons.dart';
import 'package:epicture/components/layout.dart';
import 'package:epicture/request/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// Home class
/// Statefull with state
class Home extends StatefulWidget {
    @override
    _HomeState createState() => new _HomeState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

// Images and titles
List<String> images = [];
List<String> titles = [];

/// Home State
/// State of Home class
class _HomeState extends State<Home> {
    var currentPage;
    var loaded = false;

    // Configure controller
    PageController _controller;

    void getViralUrls() {
        var request = getRequest("https://api.imgur.com/3/gallery/hot/viral/day/0", "data");
        request.then((values) {
            values["data"].forEach((image) {
                debugPrint(image['link']);
                if (image['link'] != null && image['title'] != null) {
                    images.add(image['link']);
                    titles.add(image['title']);
                }
            });

            // Configure controller
            _controller = PageController(initialPage: images.length - 1);
            _controller.addListener(() {
                setState(() {
                    currentPage = _controller.page;
                });
            });

            // Change and set state to loaded
            setState(() {
                currentPage = images.length - 1.0;
                loaded = true;
            });
        });
    }

    @override
    void initState() {
        getViralUrls();
        super.initState();
    }

    /// Build widget
    /// Adding controller to manager scrolling
    @override
    Widget build(BuildContext context) {
        return new Layout(this.displayContent());
    }

    /// Default content management
    Widget displayContent() {
        // If content not loaded, display loader
        if (!loaded) {
            return SizedBox(
                height: MediaQuery.of(context).size.height - 130,
                child: SpinKitFadingCube(
                    color: Colors.white,
                    size: 60,
                ),
            );
        }

        // Content loaded and images available
        return Column(
            children: <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                            Text("Gallerie",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40.0,
                                    fontFamily: "Calibre-Semibold",
                                    letterSpacing: 1.0,
                                )),
                            IconButton(
                                icon: Icon(
                                    CustomIcons.option,
                                    size: 12.0,
                                    color: Colors.white,
                                ),
                                onPressed: () {},
                            )
                        ],
                    ),
                ),
                Stack(
                    children: <Widget>[
                        CardScrollWidget(currentPage),
                        Positioned.fill(
                            child: PageView.builder(
                                itemCount: images.length,
                                controller: _controller,
                                reverse: true,
                                itemBuilder: (context, index) {
                                    return Container();
                                },
                            ),
                        )
                    ],
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                            Text("Favoris",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 46.0,
                                    fontFamily: "Calibre-Semibold",
                                    letterSpacing: 1.0,
                                )),
                            IconButton(
                                icon: Icon(
                                    CustomIcons.option,
                                    size: 12.0,
                                    color: Colors.white,
                                ),
                                onPressed: () {},
                            )
                        ],
                    ),
                ),
                SizedBox(
                    height: 20.0,
                ),
                Row(
                    children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 18.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset("assets/image_02.jpg",
                                    width: 296.0, height: 222.0),
                            ),
                        )
                    ],
                )
            ],
        );
    }
}

class CardScrollWidget extends StatelessWidget {
    var currentPage;
    var padding = 20.0;
    var verticalInset = 20.0;

    CardScrollWidget(this.currentPage);

    @override
    Widget build(BuildContext context) {
        return new AspectRatio(
            aspectRatio: widgetAspectRatio,
            child: LayoutBuilder(builder: (context, contraints) {
                var width = contraints.maxWidth;
                var height = contraints.maxHeight;

                var safeWidth = width - 2 * padding;
                var safeHeight = height - 2 * padding;

                var heightOfPrimaryCard = safeHeight;
                var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

                var primaryCardLeft = safeWidth - widthOfPrimaryCard;
                var horizontalInset = primaryCardLeft / 2;

                List<Widget> cardList = new List();

                for (var i = 0; i < images.length; i++) {
                    var delta = i - currentPage;
                    bool isOnRight = delta > 0;

                    var start = padding +
                        max(
                            primaryCardLeft -
                                horizontalInset * -delta * (isOnRight ? 15 : 1),
                            0.0);

                    var cardItem = Positioned.directional(
                        top: padding + verticalInset * max(-delta, 0.0),
                        bottom: padding + verticalInset * max(-delta, 0.0),
                        start: start,
                        textDirection: TextDirection.rtl,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Container(
                                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(3.0, 6.0),
                                        blurRadius: 10.0)
                                ]),
                                child: AspectRatio(
                                    aspectRatio: cardAspectRatio,
                                    child: Stack(
                                        fit: StackFit.expand,
                                        children: <Widget>[
                                            Image.network(images[i], fit: BoxFit.cover),
                                            Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                        Padding(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: 16.0, vertical: 8.0),
                                                            child: Text(titles[i],
                                                                style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 25.0,
                                                                    fontFamily: "SF-Pro-Text-Regular")),
                                                        ),
                                                        SizedBox(
                                                            height: 10.0,
                                                        ),
                                                        Padding(
                                                            padding: const EdgeInsets.only(
                                                                left: 12.0, bottom: 12.0),
                                                            child: Container(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal: 22.0, vertical: 6.0),
                                                                decoration: BoxDecoration(
                                                                    color: Colors.blueAccent,
                                                                    borderRadius: BorderRadius.circular(20.0)),
                                                                child: Text("Voir plus...",
                                                                    style: TextStyle(color: Colors.white)),
                                                            ),
                                                        )
                                                    ],
                                                ),
                                            )
                                        ],
                                    ),
                                ),
                            ),
                        ),
                    );
                    cardList.add(cardItem);
                }
                return Stack(
                    children: cardList,
                );
            }),
        );
    }
}