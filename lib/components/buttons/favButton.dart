import 'package:Epicture/utils/request.dart';
import 'package:flutter/material.dart';

/// FavButton class for fav button
/// Extended to [StatefulWidget]
class FavButton extends StatefulWidget {

    final dynamic image;
    final List<String> links;

    /// Constructor
    FavButton({this.image, this.links});

    // Create state to rebuild simple
    _FavButton createState() => _FavButton();
}

/// State creator of the [FavButton] class
/// Extended from class [State] and applying setState function
/// Returns a [Widget] to display content
class _FavButton extends State<FavButton> with TickerProviderStateMixin {

    /// Action triggered when user click to "fav" button
    /// Just like picture and change colors and icon
    void favImage() {
        if (this.widget.image.images[0].favorite) {
            postRequest("/image/" + this.widget.image.images[0].id + "/favorite");
            setState(() {
                this.widget.links.remove(this.widget.image.images[0].link);
                this.widget.image.images[0].favorite = false;
                this.widget.image.favoriteCount -= 1;
            });
            return;
        }
        postRequest("/image/" + this.widget.image.images[0].id + "/favorite");
        setState(() {
            this.widget.image.images[0].favorite = !this.widget.image.images[0].favorite;
            this.widget.image.favoriteCount += 1;
        });
    }

    /// Build (and re-build) widget
    @override Widget build(BuildContext context) {
      if (this.widget.links.contains(this.widget.image.images[0].link))
          this.widget.image.images[0].favorite = true;

      return Container(
            child: Align(
                alignment: Alignment.centerLeft,
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
                                icon: Icon((this.widget.image.images[0].favorite ? Icons.favorite : Icons.favorite_border),
                                    color: (this.widget.image.images[0].favorite ? Colors.red : Colors.grey),
                                    size: 25.0,
                                ),
                                onPressed: this.favImage,
                            ),
                        ),

                        // Text
                        Text(this.widget.image.favoriteCount.toString(),
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white
                            ),
                        )
                    ],
                ),
            ),
        );
    }
}