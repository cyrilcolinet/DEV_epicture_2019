import 'package:Epicture/utils/request.dart';
import 'package:flutter/material.dart';

class VoteButton extends StatefulWidget {

    final dynamic image;

    /// Constructor
    VoteButton({this.image});

    // Create state to rebuild simple
    _VoteButton createState() => _VoteButton();
}

class _VoteButton extends State<VoteButton> with TickerProviderStateMixin {

    /// Action triggered when user click to "fav" button
    /// Just like picture and change colors and icon
    void upVoteImage() {
        if (this.widget.image.vote == "down")
            this.widget.image.downs -= 1;
        if (this.widget.image.vote == "up") {
            postRequest("/gallery/" + this.widget.image.id + "/vote/veto");
            setState(() {
                this.widget.image.vote = "null";
                this.widget.image.ups -= 1;
            });
        } else {
            postRequest("/gallery/" + this.widget.image.id + "/vote/up");
            setState(() {
                this.widget.image.vote = "up";
                this.widget.image.ups += 1;
            });
        }
    }

    void downVoteImage() {
        if (this.widget.image.vote == "up")
            this.widget.image.ups -= 1;
        if (this.widget.image.vote == "down") {
            postRequest("/gallery/" + this.widget.image.id + "/vote/veto");
            setState(() {
                this.widget.image.vote = "null";
                this.widget.image.downs -=1;
            });
        } else {
            postRequest("/gallery/" + this.widget.image.id + "/vote/down");
            setState(() {
                this.widget.image.vote = "down";
                this.widget.image.downs +=1;
            });
        }
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
                            icon: Icon((this.widget.image.vote != "up" ? Icons.arrow_upward : Icons.arrow_upward),
                                color: (this.widget.image.vote != "up" ? Colors.grey : Colors.green),
                                size: 25.0,
                            ),
                            onPressed: this.upVoteImage,
                        ),
                    ),

                    // Text
                    Text(this.widget.image.ups.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                        ),
                    ),
                    AnimatedSize(
                        duration: Duration(milliseconds: 500),
                        vsync: this,
                        child: IconButton(
                            padding: EdgeInsets.all(0.0),
                            //alignment: Alignment.centerLeft,
                            splashColor: Colors.transparent,
                            icon: Icon((this.widget.image.vote != "down" ? Icons.arrow_downward : Icons.arrow_downward),
                                color: (this.widget.image.vote != "down" ? Colors.grey : Colors.red),
                                size: 25.0,
                            ),
                            onPressed: this.downVoteImage,
                        ),
                    ),

                    // Text
                    Text(this.widget.image.downs.toString(),
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