import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indglobalyomess/utils/constant.dart';
import 'package:indglobalyomess/utils/size_config.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FoodDetailsScreen extends StatefulWidget {
  final String id;

  const FoodDetailsScreen({Key key, this.id}) : super(key: key);

  @override
  _FoodDetailsScreenState createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  //FoodDetailController controller = Get.put(FoodDetailController());

  @override
  void initState() {
    //controller.fetchData(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kSecondaryTextColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Food details',
          style: TextStyle(
              color: kTextColor,
              fontSize: defaultSize * 2,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/img/burger.jpg'),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300],
                    blurRadius: defaultSize * 2, // soften the shadow
                    spreadRadius: defaultSize * 0.03, //extend the shadow
                  )
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(defaultSize * 2),
                  topRight: Radius.circular(defaultSize * 2),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: defaultSize * 1.5, horizontal: defaultSize * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          'assets/img/veg.png',
                          scale: 1,
                        ),
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      Text(
                        'Yomes Mess Yummy and fresh foods',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: defaultSize * 2.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: defaultSize * 0.5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: SmoothStarRating(
                                      isReadOnly: true,
                                      rating: 3,
                                      size: defaultSize * 2.5,
                                      color: Color(0xffff9b05),
                                      borderColor: kSecondaryTextColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " 4.6",
                                    style: TextStyle(
                                      color: kTextColor,
                                      fontSize: defaultSize * 2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.end,
                              text: TextSpan(
                                text: 'Price ',
                                style: TextStyle(
                                    color: kTextColor,
                                    fontSize: defaultSize * 2,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                    text: '₹49',
                                    style: TextStyle(
                                        color: kRegularColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: defaultSize * 2.5,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  TextSpan(
                                    text: '/Plate',
                                    style: TextStyle(
                                        color: kRegularColor,
                                        fontSize: defaultSize * 1.8,
                                        fontStyle: FontStyle.normal),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: defaultSize * 1.5,
                      ),
                      Text(
                        'Details',
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: defaultSize * 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: defaultSize,
                      ),
                      Text(
                        'Standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen Lorem Ipsum is simply dummy text of the printing and typesetting industry. industry\'s standard. text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: defaultSize * 1.6,
                        ),
                      ),
                      SizedBox(
                        height: defaultSize * 2.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'DELIVERY COST',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: defaultSize * 1.4,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: defaultSize,
                              ),
                              Text(
                                'Free',
                                style: TextStyle(
                                    color: kTextColor,
                                    fontSize: defaultSize * 1.6,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.grey[500],
                            width: 2,
                            height: defaultSize * 3,
                          ),
                          Column(
                            children: [
                              Text(
                                'DELIVERY TIME',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: defaultSize * 1.4,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: defaultSize,
                              ),
                              Text(
                                '11:15 a.m',
                                style: TextStyle(
                                    color: kTextColor,
                                    fontSize: defaultSize * 1.6,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: defaultSize * 5,
                      // ),
                      // Container(
                      //   width: double.infinity,
                      //   height: MediaQuery.of(context).size.height / 18,
                      //   child: MaterialButton(
                      //     onPressed: () {},
                      //     color: kRegularColor,
                      //     child: Text('Edit'),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
