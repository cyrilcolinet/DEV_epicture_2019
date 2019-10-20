import 'package:Epicture/components/buttons/goToHomeButton.dart';
import 'package:Epicture/components/layout.dart';
import 'package:Epicture/components/searchBar.dart';
import 'package:Epicture/components/searchResults.dart';
import 'package:Epicture/utils/request.dart';
import 'package:flutter/material.dart';
import 'package:Epicture/objects/image.dart' as object;

/// Search class with search bar and results
class Search extends StatelessWidget {

    /// Singleton management
    static Search _instance;
    factory Search() => _instance ??= new Search._();
    Search._();

    /// Class variables
    final TextEditingController searchController = TextEditingController();

    /// Build a [Widget]
    @override
    Widget build(BuildContext context) {
        return Layout(body: this.displayContent(context));
    }

    /// Display content in the [Layout]
    Widget displayContent(BuildContext context) {
        return SingleChildScrollView(
            child: Column(
                children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                GoToHomeButton(),
                                Text("Search",
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

                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                            children: <Widget>[

                                // Implements SearchBar widget
                                Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: SearchBar(parent: this),
                                ),

                                // Display results of research
                                SearchResults(
                                    key: Key("search_results"),
                                    parent: this,
                                )

                            ],
                        ),
                    ),
                ],
            ),
        );
    }
}