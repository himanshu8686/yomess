import 'package:flutter/material.dart';
import 'package:indglobalyomess/utils/Constant.dart';
import 'package:indglobalyomess/utils/size_config.dart';

class HorizontalTrendingFoodCardItem extends StatefulWidget {
  @override
  _HorizontalTrendingFoodCardItemState createState() =>
      _HorizontalTrendingFoodCardItemState();
}

class _HorizontalTrendingFoodCardItemState
    extends State<HorizontalTrendingFoodCardItem> {
  @override
  Widget build(BuildContext context) {
    //Initialize SizeConfig class
    SizeConfig().init(context);

    double defaultSize =
        SizeConfig.defaultSize; // default size is approximately 10

    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultSize),
      ),
      child: Container(
        width: defaultSize * 18,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://st.depositphotos.com/1900347/4146/i/950/depositphotos_41466555-stock-photo-image-of-slice-of-pizza.jpg'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultSize),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultSize * 2,
                          vertical: defaultSize * 0.4),
                      decoration: BoxDecoration(
                        color: kPrimaryBlueColor,
                        borderRadius:
                            BorderRadius.all(Radius.circular(defaultSize * 2)),
                      ),
                      child: Text(
                        '\$ 15.00',
                        style:
                            Constant.normalBodyText(kFontColor: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultSize * 0.8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pizza',
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: Constant.textBoldHeading(),
                    ),
                    Expanded(
                      child: Text(
                        'Double Cheese pizza',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: Constant.normalBodyText(kFontColor: kLightGrey,fontSize: defaultSize *  1.6,height: defaultSize * 0.13,letterSpacing: defaultSize * 0.05),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
