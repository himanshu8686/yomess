import 'package:flutter/material.dart';
import 'package:indglobalyomess/components/HorizontalMessView.dart';
import 'package:indglobalyomess/services/permission_service.dart';
import 'package:indglobalyomess/utils/Constant.dart';
import 'package:indglobalyomess/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //Initialize SizeConfig class
    SizeConfig().init(context);

    return Scaffold(
      body: HomeBody(),
    );
  }
}

///
///
///
class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    double defaultSize =
        SizeConfig.defaultSize; // default size is approximately 10

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultSize * 1.5), //15
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: defaultSize * 2,
              ),
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  // contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  contentPadding: EdgeInsets.symmetric(vertical: defaultSize),
                  prefixIcon: Icon(
                    Icons.search,
                    color: kPrimaryBlueColor,
                  ),
                  hintText: "Search for mess or foods",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300], width: 1.0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(defaultSize),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300], width: 1.0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(defaultSize),
                    ),
                  ),
                  hintStyle: new TextStyle(color: Colors.grey[500]),
                ),
              ),
              SizedBox(
                height: defaultSize,
              ),
              AspectRatio(
                aspectRatio: defaultSize * 0.25,
                child: Container(color: kPrimaryBlueColor),
              ),
              SizedBox(
                height: defaultSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.outdoor_grill),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultSize),
                      child: Text(
                        'Top Mess',
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => {},
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Text('Delivery'),
                    ),
                  ),
                  SizedBox(
                    width: defaultSize,
                  ),
                  InkWell(
                    onTap: () => {},
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Text('Pickup'),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: defaultSize,
              ),
              // Mess Horizontal List
              HorizontalMessView(),
            ],
          ),
        ),
      ),
    );
  }
}
