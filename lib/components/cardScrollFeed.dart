import 'package:Epicture/components/buttons/favButton.dart';
import 'package:Epicture/components/buttons/voteButton.dart';
import 'package:Epicture/objects/image.dart' as object;
import 'package:flutter/material.dart';

/// CardScrollFeed class
/// Stateless Widget extended
class CardScrollFeed extends StatelessWidget {

    final List<object.Image> images;
    final List<String> links;

    /// CardScrollFeed constructor
    CardScrollFeed({this.images, this.links});

    /// See more action
    /// Render new page called [
    void seeMoreAction(object.Image image) {

    }

    /// Display image
    /// Return [Widget]
    Widget displayImage(BuildContext context, int index) {
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
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
        );
    }

    /// Display button and user button
    /// Return [Widget]
    Widget displayButtonsAndUser(BuildContext context, int index) {
        return Column(
            children: <Widget>[
                // Favourites
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 0),
                                child: FavButton(image: images[index], links: this.links,)
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 0),
                                child: VoteButton(image: images[index])
                            ),
                        ],
                    ),
                ),

                // User
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                        onTap: () {},
                        child: Row(
                            children: <Widget>[
                                Icon(Icons.person,
                                    size: 25,
                                    color: Colors.grey,
                                ),
                                SizedBox(width: 10),
                                Text(images[index].accountUrl,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white
                                    ),
                                )
                            ],
                        ),
                    ),
                ),

            ],
        );
    }

    /// Display see more and comment buttons
    /// Return [Widget]
    Widget displaySeeMoreAndCommentButtons(BuildContext context, int index) {
        return Padding(
            padding: EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 40),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                    // See more button
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                            onTap: () {},
                            splashColor: Colors.transparent,
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22.0,
                                    vertical: 6.0
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20.0)
                                ),
                                child: Row(
                                    children: <Widget>[
                                        Icon(Icons.add,
                                            size: 16,
                                            color: Colors.white,
                                        ),
                                        SizedBox(width: 5),
                                        Text("See more...",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: "SF-Pro-Text-Regular"
                                            )
                                        )
                                    ],
                                ),
                            ),
                        ),
                    ),

                    // Comment button
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                            onTap: () {},
                            splashColor: Colors.transparent,
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22.0,
                                    vertical: 6.0
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20.0)
                                ),
                                child: Row(
                                    children: <Widget>[
                                        Icon(Icons.comment,
                                            size: 16,
                                            color: Colors.white,
                                        ),
                                        SizedBox(width: 5),
                                        Text("Comment",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: "SF-Pro-Text-Regular"
                                            )
                                        )
                                    ],
                                ),
                            ),
                        ),
                    )
                ],
            )
        );
    }

    /// Build content as list
    @override Widget build(BuildContext context) {
        return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 170,
            child: ListView.builder(
                itemCount: this.images.length,
                itemBuilder: (BuildContext context, int index) {
                    return Column(
                        children: <Widget>[

                            // Display image
                            this.displayImage(context, index),

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
                                            Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                                child: Text(this.images[index].title,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25.0,
                                                        fontFamily: "SF-Pro-Text-Regular"
                                                    )
                                                ),
                                            ),

                                            // Display buttons and more
                                            this.displayButtonsAndUser(context, index),

                                            // See more and comment buttons
                                            this.displaySeeMoreAndCommentButtons(context, index)
                                        ],
                                    ),
                                )
                            )
                        ],
                    );
                },
            ),
        );
    }
}