import 'package:Epicture/objects/image.dart' as object;
import 'package:Epicture/request/request.dart';
import 'package:flutter/material.dart';

class FavButton extends StatefulWidget {

    final object.Image image;

    /// Constructor
    FavButton({this.image});

    // Create state to rebuild simple
    _FavButton createState() => _FavButton(this.image);
}

class _FavButton extends State<FavButton> with TickerProviderStateMixin {

    final object.Image image;

    /// Constructor
    _FavButton(this.image);

    /// Action triggered when user click to "fav" button
    /// Just like picture and change colors and icon
    void favImage() {
        if (image.images[0].favorite) {
            setState(() {
                image.images[0].favorite = !image.images[0].favorite;
                image.favoriteCount -= 1;
            });
            return;
        }
        postRequest("/image/" + image.images[0].id + "/favorite");
        setState(() {
            image.images[0].favorite = !image.images[0].favorite;
            image.favoriteCount += 1;
        });
    }

    /// Build (and re-build) widget
    @override
    Widget build(BuildContext context) {
        return Container(
            child: Row(
                children: <Widget>[

                    // Button
                    AnimatedSize(
                        duration: Duration(milliseconds: 500),
                        vsync: this,
                        child: IconButton(
                            padding: EdgeInsets.all(0.0),
                            //alignment: Alignment.centerLeft,
                            splashColor: Colors.transparent,
                            icon: Icon((image.images[0].favorite ? Icons.favorite : Icons.favorite_border),
                                color: (image.images[0].favorite ? Colors.red : Colors.grey),
                                size: 25.0,
                            ),
                            onPressed: this.favImage,
                        ),
                    ),

                    // Text
                    Text(this.image.favoriteCount.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                        ),
                    )
                ],
            ),
        );
    }
}

//FlatButton.icon(
//            padding: EdgeInsets.all(0),
//            icon: Icon((image.favorite ? Icons.favorite : Icons.favorite_border),
//                color: (image.favorite ? Colors.grey : Colors.red),
//                size: 25.0,
//            ),
//            label: Text(this.image.favoriteCount.toString(),
//                style: TextStyle(fontSize: 18,color: Colors.white),
//            ),
//            onPressed: () {},
//        )