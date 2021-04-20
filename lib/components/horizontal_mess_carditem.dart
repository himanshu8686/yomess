import 'package:flutter/material.dart';
import 'package:indglobalyomess/utils/constant.dart';
import 'package:indglobalyomess/utils/size_config.dart';

class HorizontalMessCardItem extends StatefulWidget {
  @override
  _HorizontalMessCardItemState createState() => _HorizontalMessCardItemState();
}

class _HorizontalMessCardItemState extends State<HorizontalMessCardItem> {
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
        width: defaultSize * 30,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://static.toiimg.com/photo/51076300.cms'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultSize),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: kDarkGreen,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Text(
                              'Delivery',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: defaultSize,
                        ),
                        InkWell(
                          onTap: () => {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: kPrimaryBlueColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Text(
                              'Pickup',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(defaultSize * 0.5,
                          defaultSize * 0.3, 0, defaultSize * 0.3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Guru Kripa Restaurant',
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Constant.textBoldHeading(
                                kFontColor: Colors.black),
                          ),
                          Text(
                            'tasty and home delivery',
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Constant.textSubtitle(
                                kFontColor: Colors.grey[600]),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: defaultSize * 0.5),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: RaisedButton(
                          elevation: 0,
                          color: kPrimaryBlueColor,
                          onPressed: () {},
                          child: Image(
                              image: AssetImage("assets/img/diamond_icon.png")),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
