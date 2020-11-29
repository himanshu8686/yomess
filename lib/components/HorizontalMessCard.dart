import 'package:flutter/material.dart';
import 'package:indglobalyomess/utils/Constant.dart';
import 'package:indglobalyomess/utils/size_config.dart';

class HorizontalMessCard extends StatefulWidget {
  @override
  _HorizontalMessCardState createState() => _HorizontalMessCardState();
}

class _HorizontalMessCardState extends State<HorizontalMessCard> {
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: defaultSize * 1.8),
                          ),
                          Text(
                            'tasty and home delivery',
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: defaultSize * 1.6,
                                color: Colors.grey[700]),
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
                          onPressed: () => {},
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
