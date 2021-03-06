import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rawg_flutter/core/network/model/genres.dart';
import 'package:rawg_flutter/core/network/model/parent_platform.dart';
import 'package:rawg_flutter/utils/sizes.dart';

class CardGames extends StatelessWidget {
  final String image, name, date;
  final List<ParentPlatform> platform;
  final List<Genres> genres;
  final int metacritic;

  int getMetaCritic() {
    int score = 0;
    if (metacritic != null) score = metacritic;
    return score;
  }

  int getCountGenre() {
    int count = 0;
    if (genres.length >= 4)
      count = 4;
    else
      count = genres.length;
    return count;
  }

  const CardGames(
      {Key key,
      this.image,
      this.name,
      this.platform,
      this.metacritic,
      this.date,
      this.genres})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: Sizes.width(context) * .8,
          child: Card(
            color: Colors.grey.withOpacity(0.2),
            margin: EdgeInsets.all(8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  child: CachedNetworkImage(imageUrl: image),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  height: Sizes.width(context) * .07,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: platform.length,
                          itemBuilder: (BuildContext context, int index) {
                            ParentPlatform parentPlatform = platform[index];
                            return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 2),
                                child: Image.asset(
                                  parentPlatform.platform.getImage(),
                                  width: Sizes.width(context) * .04,
                                ));
                          }),
                      Spacer(),
                      Visibility(
                          visible: metacritic != null,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.green)),
                            child: Text(
                              metacritic.toString(),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontFamily: 'Roboto-Bold',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  alignment: Alignment.topLeft,
                  child: Text(
                    name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Roboto-Bold',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Release Date : ',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      Spacer(),
                      Text(date,
                          style: TextStyle(
                              fontSize: 13, fontFamily: 'Roboto-Black'))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child: Divider(color: Colors.grey),
                ),
                Container(
                  height: Sizes.width(context) * .07,
                  margin: EdgeInsets.only(left: 8, right: 8, top: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Genres : ',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      Spacer(),
                      ListView.builder(
                          itemCount: getCountGenre(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            Genres genre = genres[index];
                            String name = genre.name + ",";
                            if (index == genres.length - 1) {
                              name = genre.name;
                              if (name.contains("Massively Multiplayer"))
                                name = "MMO";
                            }
                            return Container(
                              child: Text(
                                name,
                                style: TextStyle(
                                    fontSize: 13, fontFamily: 'Roboto-Black'),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(color: Colors.grey),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
