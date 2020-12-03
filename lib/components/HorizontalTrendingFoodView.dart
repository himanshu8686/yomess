import 'package:flutter/material.dart';
import 'package:indglobalyomess/components/HorizontalMessCardItem.dart';
import 'package:indglobalyomess/components/HorizontalTrendingFoodCardItem.dart';
import 'package:indglobalyomess/utils/size_config.dart';

class HorizontalTrendingFoodView extends StatefulWidget {
  @override
  _HorizontalTrendingFoodViewState createState() =>
      _HorizontalTrendingFoodViewState();
}

class _HorizontalTrendingFoodViewState
    extends State<HorizontalTrendingFoodView> {
  @override
  Widget build(BuildContext context) {
    //Initialize SizeConfig class
    SizeConfig().init(context);

    double defaultSize =
        SizeConfig.defaultSize; // default size is approximately 10

    return AspectRatio(
      aspectRatio: defaultSize * 0.16,
      child: Container(
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            HorizontalTrendingFoodCardItem(),
            HorizontalTrendingFoodCardItem(),
            HorizontalTrendingFoodCardItem(),
            HorizontalTrendingFoodCardItem(),
            HorizontalTrendingFoodCardItem(),
          ],
        ),
      ),
    );
  }
}
