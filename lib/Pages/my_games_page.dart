import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:game_trophy_manager/Provider/ps4_guide_provider.dart';
import 'package:game_trophy_manager/Provider/internal_db_provider.dart';
import 'package:game_trophy_manager/Router/router_constant.dart';
import 'package:game_trophy_manager/Utilities/colors.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MyGamesPage extends StatefulWidget {
  @override
  _MyGamesPageState createState() => _MyGamesPageState();
}

class _MyGamesPageState extends State<MyGamesPage> {
  TextEditingController searchController = new TextEditingController();
  String searchKeyword = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double hp = MediaQuery.of(context).size.height;
    double wp = MediaQuery.of(context).size.width;
    return KeyboardDismissOnTap(
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: wp * 0.03, vertical: hp * 0.03),
          child: (Provider.of<InternalDbProvider>(context).myGames.length != 0)
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10, left: 2, right: 2),
                        itemCount: Provider.of<InternalDbProvider>(context)
                            .myGames
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            margin: new EdgeInsets.symmetric(vertical: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Provider.of<PS4GuideProvider>(context,
                                        listen: false)
                                    .clearGuideList();
                                Navigator.of(context)
                                    .pushNamed(guidePageRoute,
                                        arguments:
                                            Provider.of<InternalDbProvider>(
                                                    context,
                                                    listen: false)
                                                .myGames[index])
                                    .then((value) {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: new BorderRadius.all(
                                      const Radius.circular(10)),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 13.0),
                                  leading: Container(
                                    padding: EdgeInsets.only(right: 12.0),
                                    decoration: new BoxDecoration(
                                        border: new Border(
                                            right: new BorderSide(
                                                width: 1.0,
                                                color: Colors.white24))),
                                    child: Hero(
                                      tag:
                                          '${Provider.of<InternalDbProvider>(context).myGames[index].gameName}',
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            Provider.of<InternalDbProvider>(
                                                    context)
                                                .myGames[index]
                                                .gameImageUrl,
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(
                                          backgroundColor: primaryAccentColor,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            new Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    '${Provider.of<InternalDbProvider>(context).myGames[index].gameName}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_right,
                                      color: Colors.white, size: 30.0),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              LineAwesomeIcons.trophy,
                                              color: goldenColor,
                                              size: 25,
                                            ),
                                            Text(
                                              Provider.of<InternalDbProvider>(
                                                      context)
                                                  .myGames[index]
                                                  .gold,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              LineAwesomeIcons.trophy,
                                              color: silverColor,
                                              size: 25,
                                            ),
                                            Text(
                                              Provider.of<InternalDbProvider>(
                                                      context)
                                                  .myGames[index]
                                                  .silver,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              LineAwesomeIcons.trophy,
                                              color: bronzeColor,
                                              size: 25,
                                            ),
                                            Text(
                                              Provider.of<InternalDbProvider>(
                                                      context)
                                                  .myGames[index]
                                                  .bronze,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        width: wp * 0.7,
                        image: AssetImage(
                          'images/no_data_1.png',
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
