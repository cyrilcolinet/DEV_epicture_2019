import 'package:Epicture/utils/request.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// Class extended to [StatefulWidget]
/// This class create a image and call Imgur to get the accountAvatar URL and
/// display it a image
class AccountProfileImage extends StatefulWidget {

    // Class variables
    final String accountName;

    // Constructor
    AccountProfileImage({@required this.accountName});

    // Create state
    _AccountProfileImage createState() => _AccountProfileImage();
}

/// State creator of the [AccountProfileImage] class
/// Extended from class [State] and applying setState function
/// Returns a [Widget] to display content
class _AccountProfileImage extends State<AccountProfileImage> {

    /// Class variables
    bool loaded = false;
    String avatarUrl;

    /// Get image [Comment] as a [List]
    Future<String> getImageComments() {
        String url = "/account/" + widget.accountName;
        Future<Map<String, dynamic>> request = getRequest(url, "data");

        return request.then((data) => data["data"]["avatar"]);
    }

    /// On state init
    @override
    void initState() {
        super.initState();

        // Request image profile url
        this.getImageComments().then((avatar) => setState(() {
            this.avatarUrl = avatar;
            this.loaded = true;
        }));
    }

    /// Build a [Widget] and return [CachedNetworkImage]
    @override
    Widget build(BuildContext context) {
        // Currently loading
        if (!loaded) {
            return SpinKitFadingCube(
                color: Colors.black26,
                size: 30,
            );
        }

        // Content loaded, send it to cache :)
        return ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
                child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: CachedNetworkImage(
                        imageUrl: this.avatarUrl,
                        placeholder: (BuildContext context, String str) {
                            return SpinKitFadingCube(
                                color: Colors.black26,
                                size: 30,
                            );
                        },
                    ),
                ),
            ),
        );
    }
}