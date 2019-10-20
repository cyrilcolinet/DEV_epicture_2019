import 'package:Epicture/components/buttons/favButton.dart';
import 'package:Epicture/components/buttons/goToHomeButton.dart';
import 'package:Epicture/components/buttons/voteButton.dart';
import 'package:Epicture/components/commentsList.dart';
import 'package:Epicture/components/layout.dart';
import 'package:Epicture/objects/arguments/pictureInformationArguments.dart';
import 'package:flutter/material.dart';

/// State creator of the [PictureInformation] class
/// Extended from class [State] and applying setState function
/// Returns a [Widget] to display content
class FavoritePictureInformation extends StatelessWidget {

    /// Display image
    /// Return [Widget]
    Widget displayImage(PictureInformationArguments args) {
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
                        image: NetworkImage(args.image.link),
                        placeholder: AssetImage("assets/images/placeholder-img.jpg"),
                    )
                ),
            ),
        );
    }

    /// Display button and user button
    /// Return [Widget]
    Widget displayButtonsAndUser(PictureInformationArguments args) {
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
                                child: FavButton(image: args.image, links: [])
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 0),
                                child: VoteButton(image: args.image)
                            ),
                        ],
                    ),
                ),

                // User
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                        children: <Widget>[
                            Icon(Icons.person,
                                size: 25,
                                color: Colors.grey,
                            ),
                            SizedBox(width: 10),
                            Text(args.image.accountUrl,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white
                                ),
                            )
                        ],
                    ),
                ),

            ],
        );
    }

    /// Build as a [Widget]
    @override
    Widget build(BuildContext context) {
        final PictureInformationArguments args = ModalRoute.of(context).settings.arguments;

        // Return display of content
        return Layout(
            body: SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                                children: <Widget>[
                                    GoToHomeButton(),
                                    Text("Picture Info",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40.0,
                                            fontFamily: "Calibre-Semibold",
                                            letterSpacing: 1.0,
                                        )
                                    ),
                                ],
                            ),
                        ),

                        // Display image
                        this.displayImage(args),

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
                                            child: Text(args.image.title,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25.0,
                                                    fontFamily: "SF-Pro-Text-Regular"
                                                )
                                            ),
                                        ),

                                        // Display buttons and more
                                        this.displayButtonsAndUser(args),

                                        // Comments
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: EdgeInsets.only(top: 20, bottom: 10, left: 20),
                                                child: Text("Comments",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 30.0,
                                                        fontFamily: "Calibre-Semibold",
                                                        letterSpacing: 1.0,
                                                    )
                                                ),
                                            ),
                                        ),

                                        CommentsList(id: args.image.id)
                                    ],
                                ),
                            )
                        )
                    ],
                ),
            ),
        );
    }
}