import 'dart:async';

import 'package:Epicture/components/cardScrollFeed.dart';
import 'package:Epicture/components/searchBar.dart';
import 'package:Epicture/objects/image.dart' as object;
import 'package:Epicture/pages/search.dart';
import 'package:Epicture/utils/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchResults extends StatefulWidget {

    final Search parent;

    /// SearchResults constructor
    SearchResults({Key key, @required this.parent}) : super(key: key);

    /// Create a state and call
    _SearchResults createState() => _SearchResults();
}

class _SearchResults extends State<SearchResults> {

    /// Class variables
    List<object.Image> images;
    bool firstTime = true;
    bool loading = true;
    String lastResearch;
    Map<Function, Timer> _timeouts = {};

    /// Call function when search bar text is not changed since [timeout] passed
    void debounce(Duration timeout, Function target, [List arguments = const []]) {
        if (this._timeouts.containsKey(target))
            this._timeouts[target].cancel();

        // Call function if timer passed
        Timer timer = Timer(timeout, () => Function.apply(target, arguments));
        this._timeouts[target] = timer;
    }

    /// Call API and do request
    /// Argument passed as [String] is a value of text field
    void performResearch() {
        String req = widget.parent.searchController.text;

        // Empty or len inferior than three
        if (req.length < 3 || lastResearch == req)
            return;

        String url = "/gallery/search?q_any=" + Uri.encodeFull(req);
        print(url);
        Future<Map<String, dynamic>> request = getRequest(url, "data");
        List<object.Image> tmpImages = [];

        // Waiting for the request result
        this.setState(() {
            this.loading = true;
            this.firstTime = false;
        });
        request.then((data) {
            List<dynamic> values = data["data"];
            values.where((item) => item['images'] != null).forEach((tmp) {
                object.Image image = object.Image.fromJson(tmp);

                // Check for valid type of codec
                if (image.images[0].type.startsWith("image")) {
                    image.link = image.images[0].link;
                    tmpImages.add(image);
                }
            });

            // Try to setState [SearchResults] class
            this.setState(() {
                this.images = tmpImages;
                this.loading = false;
                this.lastResearch = req;
            });
        });
    }

    @override
    void initState() {
        super.initState();

        // Configure listener for text editing controller
        widget.parent.searchController.addListener(() =>
            this.debounce(const Duration(milliseconds: 500), this.performResearch, null));
    }

    /// Build a results of [SearchBar] class
    @override
    Widget build(BuildContext context) {
        // First time build, display nothing
        if (firstTime)
            return Container();

        // Currently searching
        if (loading) {
            return Padding(
                padding: EdgeInsets.only(top: 200, bottom: 10),
                child: Align(
                    alignment: Alignment.center,
                    child: SpinKitFadingCube(
                        color: Colors.white,
                        size: 60,
                    ),
                ),
            );
        }

        // No results, display just "No results"
        if (this.images.length == 0) {
            return Padding(
                padding: EdgeInsets.all(30),
                child: Align(
                    alignment: Alignment.center,
                    child: Text("No results found."),
                ),
            );
        }

        return Padding(
            padding: EdgeInsets.only(top: 20),
            child: CardScrollFeed(images: this.images, links: []),
        );
    }
}