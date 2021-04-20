import 'package:flutter/material.dart';
import 'package:indglobalyomess/utils/constant.dart';
import 'package:indglobalyomess/utils/size_config.dart';

class FoodCategoryCardItem extends StatefulWidget {
  @override
  _FoodCategoryCardItemState createState() => _FoodCategoryCardItemState();
}

class _FoodCategoryCardItemState extends State<FoodCategoryCardItem> {
  @override
  Widget build(BuildContext context) {
    //Initialize SizeConfig class
    SizeConfig().init(context);

    double defaultSize =
        SizeConfig.defaultSize; // default size is approximately 10

    return Container(
      width: defaultSize * 17,
      margin: EdgeInsets.symmetric(horizontal: defaultSize),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey[400],
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Icon(
                Icons.fastfood,
                color: kPrimaryBlueColor,
                size: defaultSize * 5,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                child: Text(
                  'Cold Drink',
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: Constant.textBoldHeading(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
