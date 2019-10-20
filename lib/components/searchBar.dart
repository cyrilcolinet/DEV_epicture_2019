import 'package:Epicture/pages/search.dart';
import 'package:flutter/material.dart';

/// Class that includes a searchbar component
/// The [Function] onSubmitted is passed as parameter in class constructor
class SearchBar extends StatelessWidget {

    /// Class variables
    final Search parent;

    SearchBar({@required this.parent});

    /// Build a content and return a [Widget]
    @override
    Widget build(BuildContext context) {
        return Material(
            elevation: 10,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
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
                    child: Row(
                        children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 20, right: 10),
                                child: Icon(Icons.search,
                                    color: Colors.green,
                                    size: 30,
                                ),
                            ),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: TextField(
                                        controller: this.parent.searchController,
                                        maxLines: 1,
                                        textInputAction: TextInputAction.go,
                                        cursorColor: Colors.green,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Search for image...",
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15,
                                                fontFamily: "Calibre-Semibold",
                                                letterSpacing: 1.0,
                                            ),

                                        ),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontFamily: "Calibre-Semibold",
                                            letterSpacing: 1.0,
                                        ),
                                    ),
                                ),
                            )
                        ],
                    )
                ),
            ),
        );
    }
}