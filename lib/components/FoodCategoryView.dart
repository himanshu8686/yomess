import 'package:flutter/material.dart';
import 'package:indglobalyomess/components/FoodCategoryCardItem.dart';
import 'package:indglobalyomess/utils/size_config.dart';

class FoodCategoryView extends StatefulWidget {
  @override
  _FoodCategoryViewState createState() => _FoodCategoryViewState();
}

class _FoodCategoryViewState extends State<FoodCategoryView> {
  @override
  Widget build(BuildContext context) {
    //Initialize SizeConfig class
    SizeConfig().init(context);

    double defaultSize =
        SizeConfig.defaultSize; // default size is approximately 10

    return AspectRatio(
      aspectRatio: defaultSize * 0.2,
      child: Container(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            FoodCategoryCardItem(),
            FoodCategoryCardItem(),
            FoodCategoryCardItem(),
            FoodCategoryCardItem()
          ],
        ),
      ),
    );
  }
}
