import 'package:flutter/material.dart';
import 'package:indglobalyomess/components/FoodCategoryView.dart';
import 'package:indglobalyomess/components/HorizontalMessView.dart';
import 'package:indglobalyomess/components/HorizontalTrendingFoodView.dart';
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
/// This is the class responsible for the Home Screen's Body
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

              /************** Search Text Field ****************/
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  // contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
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
                  hintStyle:
                      Constant.normalBodyText(kFontColor: Colors.grey[500]),
                ),
              ),
              SizedBox(
                height: defaultSize * 2,
              ),

              /************** Image carousel view  ****************/
              AspectRatio(
                aspectRatio: defaultSize * 0.25,
                child: Container(color: kPrimaryBlueColor),
              ),
              SizedBox(
                height: defaultSize * 2,
              ),

              /************** Top mess row ****************/
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageIcon(
                    AssetImage("assets/img/chef_icon.png"),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultSize),
                      child: Text(
                        'Top Mess',
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style:
                            Constant.textBoldHeading(kFontColor: Colors.black),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => {},
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: kLightGrey,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Text(
                        'Delivery',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
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
                        color: kLightGrey,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Text(
                        'Pickup',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: defaultSize,
              ),

              /************** Horizontal Mess List view  ****************/
              HorizontalMessView(),
              SizedBox(
                height: defaultSize * 2,
              ),

              /************** Trending this week row ****************/
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.trending_up),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultSize),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Trending this week',
                            style: Constant.textBoldHeading(
                                kFontColor: Colors.black),
                          ),
                          Text(
                            'Click on the food to get the more details about it',
                            style:
                                Constant.normalBodyText(kFontColor: kLightGrey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultSize * 2,
              ),

              /************** Horizontal Trending food list  ****************/
              HorizontalTrendingFoodView(),
              SizedBox(
                height: defaultSize * 2,
              ),

              /************** Food categories heading row  ****************/

              Row(
                children: [
                  Icon(Icons.category),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultSize),
                    child: Text(
                      'Food Categories',
                      style: Constant.textBoldHeading(kFontColor: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultSize * 2,
              ),

              /************** Food categories list  ****************/
              FoodCategoryView(),
              SizedBox(
                height: defaultSize * 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
