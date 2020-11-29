import 'package:flutter/material.dart';
import 'package:indglobalyomess/components/HorizontalMessCard.dart';
import 'package:indglobalyomess/utils/Constant.dart';
import 'package:indglobalyomess/utils/size_config.dart';

class HorizontalMessView extends StatefulWidget {
  @override
  _HorizontalMessViewState createState() => _HorizontalMessViewState();
}

class _HorizontalMessViewState extends State<HorizontalMessView> {
  @override
  Widget build(BuildContext context) {
    //Initialize SizeConfig class
    SizeConfig().init(context);

    double defaultSize =
        SizeConfig.defaultSize; // default size is approximately 10
    return AspectRatio(
      aspectRatio: defaultSize * 0.175,
      child: Container(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            HorizontalMessCard(),
            HorizontalMessCard(),
            HorizontalMessCard()
          ],
        ),
      ),
    );
  }
}
