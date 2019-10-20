import 'package:Epicture/components/accountProfileImage.dart';
import 'package:Epicture/objects/comment.dart';
import 'package:Epicture/utils/request.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CommentsList extends StatefulWidget {
    final String id;
    
    CommentsList({@required this.id});
    
    /// Create state from widget
    _CommentsList createState() => _CommentsList();
}

class _CommentsList extends State<CommentsList> {
    
    /// Class variables
    bool loaded = false;
    List<Comment> comments;

    /// Get image [Comment] as a [List]
    Future getImageComments() {
        String url = "/gallery/" + widget.id + "/comments/";
        Future<Map<String, dynamic>> request = getRequest(url, "data");
        List<Comment> tmpComments = [];

        return request.then((data) {
            List<dynamic> values = data["data"];
            values.forEach((tmp) => tmpComments.add(Comment.fromJson(tmp)));

            return tmpComments;
        });
    }

    /// Init state
    @override
    void initState() {
        super.initState();
        
        // Request comments
        this.getImageComments().then((tmpComments) => setState(() {
            this.comments = tmpComments;
            print(comments);
            this.loaded = true;
        }));
    }

    /// Build a [Widget] that display comments
    @override
    Widget build(BuildContext context) {
        // Currently requesting comments list
        if (!loaded) {
            return Align(
                alignment: Alignment.center,
                child: SpinKitFadingCube(
                    color: Colors.white,
                    size: 60,
                ),
            );
        }

        // No comments :(
        if (this.comments.length == 0) {
            return Padding(
                padding: EdgeInsets.only(bottom: 100),
                child: Align(
                    alignment: Alignment.center,
                    child: Text("No comments... :("),
                ),
            );
        }

        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).size.height / 3) * 2,
                child: ListView.builder(
                    itemCount: this.comments.length,
                    itemBuilder: this.displayComment,
                ),
            ),
        );
    }

    /// Display one comment by comment
    Widget displayComment(BuildContext context, int index) {
        return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Container(
                //padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(0, 2.0),
                            blurRadius: 20.0,
                        )
                    ]
                ),
                child: Column(
                    children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                                children: <Widget>[
                                    SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: AccountProfileImage(accountName: this.comments[index].author),
                                    ),
                                    SizedBox(width: 15.0),
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Text(this.comments[index].author,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w400,
                                                ),
                                            ),
                                            Text(DateTime.fromMicrosecondsSinceEpoch(this.comments[index].datetime * 1000).toString(),
                                                style: TextStyle(color: Colors.black54),
                                            ),
                                        ],
                                    )
                                ],
                            ),
                        ),
                        this.displayCommentOrGif(this.comments[index]),
                    ],
                ),
            ),
        );
    }

    /// Detect if link is url, and display image
    Widget displayCommentOrGif(Comment comment) {
        try {
            bool isUrl = Uri.parse(comment.comment).isAbsolute;

            // If comment is only url, display it
            if (isUrl) {
                var parts = comment.comment.split('.');
                var extension = parts[parts.length - 1];
                var imageTypes = ['jpg', 'jpeg', 'tiff', 'png', 'gif', 'bmp'];

                // Check if image can be displayed
                if (imageTypes.indexOf(extension) != -1) {
                    return ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        ),
                        child: CachedNetworkImage(
                            imageUrl: comment.comment,
                            placeholder: (BuildContext context, String str) {
                                return SpinKitFadingCube(
                                    color: Colors.black26,
                                    size: 30,
                                );
                            },
                        ),
                    );
                }
            }
        } catch(ignored) {}

        // Just display comment
        return Padding(
            padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(comment.comment,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15
                    ),
                ),
            ),
        );
    }
}