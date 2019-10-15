import 'package:Epicture/components/buttons/goToHomeButton.dart';
import 'package:Epicture/components/layout.dart';
import 'package:Epicture/objects/arguments/pictureInformationArguments.dart';
import 'package:flutter/material.dart';

/// PictureInformation for one picture in particularity
/// Extended from [StatefulWidget]
class PictureInformation extends StatefulWidget {
    _PictureInformation createState() => _PictureInformation();
}

/// State creator of the [PictureInformation] class
/// Extended from class [State] and applying setState function
/// Returns a [Widget] to display content
class _PictureInformation extends State<PictureInformation> {

    @override Widget build(BuildContext context) {
        final PictureInformationArguments args = ModalRoute.of(context).settings.arguments;

        return Layout(
            body: SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 20),
                            child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                    GoToHomeButton(),
                                    Text("Picture Info",
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

                        Container()

                        /*Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Stack(
                            children: <Widget>[
                                Container(
                                    child: Column(
                                        children: <Widget>[
                                            Stack(
                                                children: <Widget>[
                                                    Container(
                                                        padding: EdgeInsets.all(16.0),
                                                        margin: EdgeInsets.only(top: 16.0),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(5.0)
                                                        ),
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                                Container(
                                                                    margin: EdgeInsets.only(left: 96.0),
                                                                    child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: <Widget>[
                                                                            Text(userData.url, style: Theme.of(context).textTheme.title,),
                                                                            SizedBox(height: 30)
                                                                        ],
                                                                    ),
                                                                ),
                                                                SizedBox(height: 10.0),
                                                                Row(
                                                                    children: <Widget>[
                                                                        Expanded(
                                                                            child: Column(
                                                                                children: <Widget>[
                                                                                    Text("Reputation"),
                                                                                    Text(userData.reputation.toString())
                                                                                ],
                                                                            ),
                                                                        ),
                                                                        Expanded(
                                                                            child: Column(
                                                                                children: <Widget>[
                                                                                    Text("Grade"),
                                                                                    Text(userData.reputationName)
                                                                                ],
                                                                            ),
                                                                        ),
                                                                        Expanded(
                                                                            child: Column(
                                                                                children: <Widget>[
                                                                                    Text("Uploads"),
                                                                                    Text(images.length.toString())
                                                                                ],
                                                                            ),
                                                                        ),
                                                                    ],
                                                                ),
                                                            ],
                                                        ),
                                                    ),
                                                    Container(
                                                        height: 80,
                                                        width: 80,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10.0),
                                                            image: DecorationImage(
                                                                image: CachedNetworkImageProvider(userData.avatar),
                                                                fit: BoxFit.cover
                                                            )
                                                        ),
                                                        margin: EdgeInsets.only(left: 16.0),
                                                    ),
                                                ],
                                            ),

                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                    padding: EdgeInsets.only(top: 20, bottom: 10),
                                                    child: Text("My Uploads",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 30.0,
                                                            fontFamily: "Calibre-Semibold",
                                                            letterSpacing: 1.0,
                                                        )
                                                    ),
                                                ),
                                            ),

                                            SizedBox(
                                                width: MediaQuery.of(context).size.width,
                                                height: MediaQuery.of(context).size.height - 170,
                                                child: MasonryView.builder(
                                                    itemCount: this.images.length,
                                                    mainAxisSpacing: 10.0,
                                                    crossAxisSpacing: 10.0,
                                                    mainAxisRatio: 1.0,
                                                    crossAxisSpans: 4,
                                                    itemBuilder: this.buildImagesMasonry,
                                                    tileSizeBuilder: (index) {
                                                        if (index >= tileSizes.length) return null;
                                                        return tileSizes[index];
                                                    }
                                                ),
                                            )
                                        ],
                                    ),
                                )
                            ],
                        ),
                    ),*/
                        /*CardScrollFeed(
                        images: this.images,
                        titles: this.titles
                    ),*/
                    ],
                ),
            ),
        );
    }
}