import 'package:Epicture/objects/image.dart' as object;
import 'package:Epicture/request/request.dart';
import 'package:flutter/material.dart';

class VoteButton extends StatefulWidget {

  final object.Image image;

  /// Constructor
  VoteButton({this.image});

  // Create state to rebuild simple
  _VoteButton createState() => _VoteButton(this.image);
}

class _VoteButton extends State<VoteButton> with TickerProviderStateMixin {

  final object.Image image;

  /// Constructor
  _VoteButton(this.image);

  /// Action triggered when user click to "fav" button
  /// Just like picture and change colors and icon
  void UpvoteImage() {
    print("here");
    print(image.id);
    if (image.vote == "down")
      image.downs -= 1;
    if (image.vote == "up") {
      print("image was alrdy upvoted");
      postRequest("/gallery/" + image.id + "/vote/veto");
      setState(() {
        print(image.vote);
        image.vote = "null";
        image.ups -=1;
      });
    } else {
      print("upvoting image");
      postRequest("/gallery/" + image.id + "/vote/up");
      setState(() {
        print(image.vote);
        image.vote = "up";
        image.ups +=1;
      });
    }
  }


  void DownvoteImage() {
    print("here");
    print(image.id);
    if (image.vote == "up")
      image.ups -= 1;
    if (image.vote == "down") {
      print("image was alrdy downvoted");
      postRequest("/gallery/" + image.id + "/vote/veto");
      setState(() {
        print(image.vote);
        image.vote = "null";
        image.downs -=1;
      });
    } else {
      print("downvoting image");
      postRequest("/gallery/" + image.id + "/vote/down");
      setState(() {
        print(image.vote);
        image.vote = "down";
        image.downs +=1;
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
              icon: Icon((image.vote != "up" ? Icons.arrow_upward : Icons.arrow_upward),
                color: (image.vote != "up" ? Colors.grey : Colors.green),
                size: 25.0,
              ),
              onPressed: this.UpvoteImage,
            ),
          ),

          // Text
          Text(this.image.ups.toString(),
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
              icon: Icon((image.vote != "down" ? Icons.arrow_downward : Icons.arrow_downward),
                color: (image.vote != "down" ? Colors.grey : Colors.red),
                size: 25.0,
              ),
              onPressed: this.DownvoteImage,
            ),
          ),

          // Text
          Text(this.image.downs.toString(),
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