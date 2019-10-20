import 'package:Epicture/objects/arguments/pictureInformationArguments.dart';
import 'package:Epicture/objects/image.dart' as object;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// ImageGridTile for [GridView] only
/// Display image and implements [GestureDetector] to apply like/unlike on
/// double tap, and zoom in single tap
class ImageGridTile extends StatelessWidget {

    /// Class variables
    final dynamic image;

    /// Constructor
    ImageGridTile({@required this.image});

    /// See more action as a [Function]
    /// Pass parameter [object.Image] in route to get data without requesting
    /// Render new page called [PictureInformation]
    Function seeMoreAction(BuildContext context, dynamic image) {
        return () {
            // If main image object
            if (this.image is object.Image) {
                Navigator.pushNamed(context, '/pictureInformation',
                    arguments: PictureInformationArguments(image));
                return;
            }
        };
    }

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: GestureDetector(
                onTap: this.seeMoreAction(context, this.image),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
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
                        child: AspectRatio(
                            aspectRatio: 3 / 2,
                            child: CachedNetworkImage(
                                imageUrl: this.image.link,
                                placeholder: (BuildContext context, String str) {
                                    return SpinKitFadingCube(
                                        color: Colors.black26,
                                        size: 30,
                                    );
                                },
                            ),
                        ),
                    ),
                ),
            ),
        );
    }
}