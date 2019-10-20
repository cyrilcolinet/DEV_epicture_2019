import 'package:Epicture/components/buttons/goToHomeButton.dart';
import 'package:Epicture/components/layout.dart';
import 'package:Epicture/objects/arguments/pictureInformationArguments.dart';
import 'package:Epicture/utils/request.dart';
import 'package:flutter/material.dart';

/// State creator of the [PictureInformation] class
/// Extended from class [State] and applying setState function
/// Returns a [Widget] to display content
class FavoritePictureInformation extends StatelessWidget {

    Function unFavorite(BuildContext context, String id) {
        return () {
            postRequest("/image/" + id + "/favorite");
            Navigator.pop(context);
        };
    }

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

                                        Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: InkWell(
                                                    onTap: this.unFavorite(context, args.image.id),
                                                    splashColor: Colors.transparent,
                                                    child: Container(
                                                        width: 150,
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: 22.0,
                                                            vertical: 6.0
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius: BorderRadius.circular(20.0)
                                                        ),
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: <Widget>[
                                                                Icon(Icons.add,
                                                                    size: 16,
                                                                    color: Colors.white,
                                                                ),
                                                                SizedBox(width: 5),
                                                                Text("Unfavorite",
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
                                        )

                                        //CommentsList(id: args.image.id)
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