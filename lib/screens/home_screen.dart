import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indglobalyomess/controller/banner_controller.dart';
import 'package:indglobalyomess/models/banner_model.dart';
import 'package:indglobalyomess/models/restaurant_list_model.dart';
import 'package:indglobalyomess/repo/restaurant_list_repo.dart';
import 'package:indglobalyomess/repo/get_banner_data_repo.dart';
import 'package:indglobalyomess/screens/mess_detail_screen.dart';
import 'package:indglobalyomess/utils/constant.dart';
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
  int indexSelected = 0;
  // GetFoodListController controller = Get.put(GetFoodListController());
  BannerController bannerController = Get.put(BannerController());

  @override
  void initState() {
    print('iniit===>>>');
    // controller.fetchData();
    bannerController.fetchData();
    // print('${bannerController.bannerModel.data[2].media[0].url}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double defaultSize =
        SizeConfig.defaultSize; // default size is approximately 10

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultSize * 1.5), //15
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: defaultSize * 2,
                ),

                /************** Search Text Field ****************/
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          // contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText: "Search for mess or foods",
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[300], width: 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[300], width: 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          hintStyle: Constant.normalBodyText(
                              kFontColor: Colors.grey[500]),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.verified_outlined,
                          color: Colors.orange,
                          size: 28,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Offers',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.orange,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: defaultSize * 2,
                ),

                /************** Image carousel view  ****************/

                FutureBuilder<BannerModel>(
                  future: GetBannerData.getBannerData(),
                  builder: (BuildContext context,
                      AsyncSnapshot<BannerModel> snapshot) {
                    if (snapshot.hasData) {
                      return AspectRatio(
                        aspectRatio: 16 / 9,
                        child: CarouselSlider(
                          options: CarouselOptions(
                              viewportFraction: 0.8,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  indexSelected = index;
                                });
                              }),
                          items: [0, 1, 2, 3, 4].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: 300,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[200],
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Image(
                                        image: snapshot.data.data[i].hasMedia ==
                                                false
                                            ? AssetImage(
                                                'assets/img/placeholder.jpg',
                                              )
                                            : NetworkImage(
                                                '${snapshot.data.data[i].media[0].url}'),
                                        fit: BoxFit.fill,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: defaultSize * 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Container(
                      height: 8,
                      width: 8,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: indexSelected == index
                            ? Color(0XFF00B9AC)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: defaultSize * 2,
                ),
                Column(
                  children: [
                    FutureBuilder<RestaurantListModel>(
                      future: RestaurantListData.restaurantListData(),
                      builder: (BuildContext context,
                          AsyncSnapshot<RestaurantListModel> snapshot) {
                        if (snapshot.hasData) {
                          print("list is: ${snapshot.data.data.length}");
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${snapshot.data.data.length} Mess',
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                    style: Constant.textBoldHeading(
                                        kFontColor: Colors.black),
                                  ),
                                  Spacer(),
                                  DropdownButton(
                                    items: [],
                                    onChanged: (v) {},
                                    hint: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.filter_alt_sharp,
                                            color: Color(0XFF00CFC1),
                                            size: 15,
                                          ),
                                          Text(
                                            'Filter',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    icon: Container(),
                                    underline: Container(),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: defaultSize * 2,
                              ),
                              Column(
                                children: List.generate(
                                  snapshot.data.data.length,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MessDetailScreen(
                                            id: snapshot.data.data[index].id
                                                .toString(),
                                            address: snapshot
                                                .data.data[index].address
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[300],
                                            blurRadius: 20,
                                            spreadRadius: -5,
                                          ),
                                        ],
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      height: 120,
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 120,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey[300],
                                                  blurRadius: 20,
                                                  spreadRadius: -5,
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 15),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  height: 90,
                                                  width: 90,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: Image(
                                                      image: snapshot
                                                                  .data
                                                                  .data[index]
                                                                  .hasMedia ==
                                                              false
                                                          ? AssetImage(
                                                              'assets/img/placeholder.jpg',
                                                            )
                                                          : NetworkImage(
                                                              '${snapshot.data.data[index].media[0].url}'),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${snapshot.data.data[index].name}',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            75,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Price ',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        Text(
                                                          ' \$ 49 / Plate',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0XFF00CFC1),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          color: Colors.orange,
                                                          size: 16,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Colors.orange,
                                                          size: 16,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Colors.orange,
                                                          size: 16,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Colors.orange,
                                                          size: 16,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: Colors.orange,
                                                          size: 16,
                                                        ),
                                                        Text(
                                                          ' 53 Votes',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          // Positioned(
                                          //   bottom: 10,
                                          //   right: 10,
                                          //   child: Icon(
                                          //     Icons.favorite_border,
                                          //     color: Colors.red,
                                          //     size: 20,
                                          //   ),
                                          // ),
                                          if (index == 0) ...{
                                            Positioned(
                                              right: -60,
                                              top: -50,
                                              child: Transform(
                                                transform:
                                                    Matrix4.rotationZ(0.75),
                                                child: Container(
                                                  height: 25,
                                                  width: 150,
                                                  color: Color(0XFF00CFC1),
                                                  child: Align(
                                                    alignment:
                                                        Alignment(0.4, 0),
                                                    child: Text(
                                                      'YOMES',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          } else if (index == 3) ...{
                                            Positioned(
                                              right: 15,
                                              top: 15,
                                              child: Container(
                                                height: 12,
                                                width: 12,
                                                child: Image(
                                                  image: AssetImage(
                                                      'assets/img/non_veg.png'),
                                                ),
                                              ),
                                            ),
                                          } else ...{
                                            Positioned(
                                              right: 15,
                                              top: 15,
                                              child: Container(
                                                height: 12,
                                                width: 12,
                                                child: Image(
                                                  image: AssetImage(
                                                      'assets/img/veg.png'),
                                                ),
                                              ),
                                            ),
                                          },
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: defaultSize * 2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
