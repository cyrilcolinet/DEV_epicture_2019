import 'package:flutter/material.dart';
import 'package:epicture/request/request.dart';

/// CardScrollFeed class
/// Stateless Widget extended
class CardScrollFeed extends StatelessWidget {

    final List<String> images;
    final List<String> titles;

    /// CardScrollFeed constructor
    CardScrollFeed({this.images, this.titles});

    /// Build content as list
    @override
    Widget build(BuildContext context) {
        return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 170,
            child: ListView.builder(
                itemCount: this.images.length,
                itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 50
                        ),
                        child: Column(
                            children: <Widget>[

                                // Display image
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
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
                                        child: Image.network(this.images[index])
                                    ),
                                ),

                                // Display text and buttons
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[

                                                // Title of image
                                                Text(this.titles[index],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25.0,
                                                        fontFamily: "SF-Pro-Text-Regular"
                                                    )
                                                ),

                                                // Space
                                                Padding(
                                                    padding: EdgeInsets.only(top: 10),
                                                    child: Row(
                                                        children: <Widget>[

                                                            // Like button
                                                            InkWell(
                                                                onTap: () {
                                                                    if (ModalRoute.of(context).settings.name != '/fav') {
                                                                        String tmp = this.images[index];
                                                                        String url = "https://api.imgur.com/3/image/";
                                                                        tmp = tmp.replaceAll(
                                                                            "https://i.imgur.com/",
                                                                            "");
                                                                        url += tmp.split('.')[0];
                                                                        url += "/favorite";
                                                                        postRequest(url);
                                                                    } else {

                                                                    }
                                                                },
                                                                child: Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: 22.0,
                                                                        vertical: 6.0
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.redAccent,
                                                                        borderRadius: BorderRadius.circular(20.0)
                                                                    ),
                                                                    child: Text(
                                                                        ModalRoute.of(context).settings.name == '/fav' ? "Dislike" : "Like",
                                                                        style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 16,
                                                                            fontFamily: "SF-Pro-Text-Regular"
                                                                        )
                                                                    ),
                                                                ),
                                                            ),

                                                            // Little space between two buttons
                                                            SizedBox(width: 10),

                                                            // See more button
                                                            InkWell(
                                                                onTap: () {

                                                                },
                                                                child: Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: 22.0,
                                                                        vertical: 6.0
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.blueAccent,
                                                                        borderRadius: BorderRadius.circular(20.0)
                                                                    ),
                                                                    child: Text("More",
                                                                        style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 16,
                                                                            fontFamily: "SF-Pro-Text-Regular"
                                                                        )
                                                                    ),
                                                                ),
                                                            )
                                                        ],
                                                    )
                                                )
                                            ],
                                        ),
                                    )
                                )
                            ],
                        ),
                    );
                },
            ),
        );
    }
}