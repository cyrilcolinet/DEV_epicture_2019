import 'package:Epicture/components/buttons/favButton.dart';
import 'package:Epicture/objects/image.dart' as object;
import 'package:flutter/material.dart';

/// CardScrollFeed class
/// Stateless Widget extended
class CardScrollFeed extends StatelessWidget {

    final List<object.Image> images;

    /// CardScrollFeed constructor
    CardScrollFeed({this.images});

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
                                        child: FadeInImage(
                                            image: NetworkImage(this.images[index].link),
                                            placeholder: AssetImage("assets/images/placeholder-img.jpg"),
                                        )
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
                                                Text(this.images[index].title,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25.0,
                                                        fontFamily: "SF-Pro-Text-Regular"
                                                    )
                                                ),

                                                Row(
                                                    children: <Widget>[
                                                        // Favourites
                                                        Padding(
                                                            padding: EdgeInsets.only(right: 15),
                                                            child: FavButton(image: images[index])
                                                        ),

                                                        // User
                                                        FlatButton.icon(
                                                            icon: Icon(Icons.people,
                                                                size: 25,
                                                                color: Colors.grey,
                                                            ),
                                                            label: Text(images[index].accountUrl,
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    color: Colors.white
                                                                ),
                                                            ),
                                                            onPressed: () {},
                                                        ),
                                                    ],
                                                ),

                                                // Space
                                                Padding(
                                                    padding: EdgeInsets.only(top: 10),
                                                    child: Row(
                                                        children: <Widget>[

                                                            // Like button
                                                            InkWell(
                                                                onTap: () {},
                                                                child: Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: 22.0,
                                                                        vertical: 6.0
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.redAccent,
                                                                        borderRadius: BorderRadius.circular(20.0)
                                                                    ),
                                                                    child: Text("Like",
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