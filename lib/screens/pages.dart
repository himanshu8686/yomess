import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:indglobalyomess/get_state/get_user_state.dart';
import 'package:indglobalyomess/screens/order_place_successful_screen.dart';
import 'package:indglobalyomess/screens/explore_screen.dart';
import 'package:indglobalyomess/screens/location_screen.dart';
import 'package:indglobalyomess/screens/our_services_screen.dart';
import 'package:indglobalyomess/screens/profile_screen.dart';
import 'package:indglobalyomess/screens/side_navigation_drawer.dart';
import 'package:indglobalyomess/screens/home_screen.dart';
import 'package:indglobalyomess/services/permission_service.dart';
import 'package:indglobalyomess/utils/size_config.dart';

class Pages extends StatefulWidget {
  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  @override
  void initState() {
    permissionAccess();
    super.initState();
  }

  int selectedIndex = 2;

  final Controller controller = Get.find();
  /**
   *
   */
  Future permissionAccess() {
    PermissionService().requestAllPermission();
  }

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    OrderPlaceSuccessfulScreen(),
    OurServicesScreen(),
    ExploreScreen(),
    ProfileScreen()
  ];

  int _currentSelected = 0;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void _onItemTapped(int index) {
    setState(() {
      _currentSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double defaultSize = SizeConfig.defaultSize;

    return Scaffold(
      key: _scaffoldKey,
      body: _widgetOptions.elementAt(_currentSelected),
      appBar: buildAppBar(),
      drawer: SideNavigationDrawer(),
      bottomNavigationBar: buildBottomNavigationBar(defaultSize),
    );
  }

  /**
   *  Method for building bottom navigation bar
   */
  Widget buildBottomNavigationBar(double defaultSize) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            offset: Offset(0, -5),
            blurRadius: 30,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = 0;
              });
            },
            child: getBottomIcon('assets/img/order_icon.png',
                title: 'Order', isSelected: selectedIndex == 0),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = 1;
              });
            },
            child: getBottomIcon('assets/img/favorite_icon.png',
                title: 'Favorite', isSelected: selectedIndex == 1),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = 2;
              });
            },
            child: getBottomIcon('assets/img/card_icon.png',
                title: 'My Card', isSelected: selectedIndex == 2),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = 3;
              });
            },
            child: getBottomIcon('assets/img/history_icon.png',
                title: 'History', isSelected: selectedIndex == 3),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = 4;
              });
            },
            child: getBottomIcon('assets/img/profile_icon.png',
                title: 'Profile', isSelected: selectedIndex == 4),
          ),
        ],
      ),
    );
    // return BottomNavigationBar(
    //   onTap: _onItemTapped,
    //   currentIndex: _currentSelected,
    //   type: BottomNavigationBarType.fixed,
    //   selectedItemColor: kPrimaryBlueColor,
    //   elevation: defaultSize,
    //   items: [
    //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    //     BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
    //     BottomNavigationBarItem(
    //         icon: Icon(Icons.room_service), label: 'Service'),
    //     BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
    //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
    //   ],
    // );
  }

  Widget getBottomIcon(String iconPath,
      {String title, bool isSelected = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: isSelected
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0XFF4CD6CC),
                  boxShadow: [
                      BoxShadow(
                        color: Color(0XFF00FFEC),
                        blurRadius: 10,
                        offset: Offset(0, 7),
                      )
                    ])
              : BoxDecoration(),
          alignment: Alignment.center,
          child: Image(
            image: AssetImage(iconPath),
            fit: BoxFit.contain,
            height: 23,
            width: 23,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Text(title)
      ],
    );
  }

  /**
   *  Method for building side drawer
   */
  // Drawer buildDrawer(double defaultSize, BuildContext context) {
  //   return Drawer(
  //     child: ListView(
  //       children: [
  //         Container(
  //           padding: EdgeInsets.symmetric(vertical: defaultSize),
  //           decoration: BoxDecoration(color: Colors.black12),
  //           child: ListTile(
  //             leading: Icon(
  //               Icons.person,
  //               color: kPrimaryAuthOrangeColor,
  //               size: defaultSize * 3,
  //             ),
  //             title: Text(
  //               'Guest',
  //               style: TextStyle(
  //                   color: kPrimaryAuthOrangeColor,
  //                   fontSize: defaultSize * 2.2),
  //             ),
  //           ),
  //         ),
  //         ListTile(
  //           onTap: () {
  //             _onItemTapped(NavigationHelper.HOME_INDEX);
  //             Navigator.pop(context);
  //           },
  //           leading: Icon(
  //             Icons.home,
  //           ),
  //           title: Text(
  //             'Home',
  //           ),
  //         ),
  //         ListTile(
  //           onTap: () {
  //             _onItemTapped(NavigationHelper.CART_INDEX);
  //             Navigator.pop(context);
  //           },
  //           leading: Icon(
  //             Icons.shopping_cart,
  //           ),
  //           title: Text(
  //             'Cart',
  //           ),
  //         ),
  //         Divider(),
  //         ListTile(
  //           dense: true,
  //           title: Text(
  //             "Application preferences",
  //             style: Theme.of(context).textTheme.bodyText2,
  //           ),
  //           trailing: Icon(
  //             Icons.remove,
  //             color: Theme.of(context).focusColor.withOpacity(0.3),
  //           ),
  //         ),
  //         ListTile(
  //           onTap: () {},
  //           leading: Icon(
  //             Icons.help,
  //           ),
  //           title: Text(
  //             'Help And Support',
  //           ),
  //         ),
  //         ListTile(
  //           onTap: () {},
  //           leading: Icon(
  //             Icons.settings,
  //           ),
  //           title: Text(
  //             'Settings',
  //           ),
  //         ),
  //         controller.isUserLogIn == true.obs
  //             ? ListTile(
  //                 onTap: () {
  //                   print(controller.isUserLogIn.obs);
  //
  //                   prefs.setBool('isLogin', false);
  //                   Navigator.push(context,
  //                       MaterialPageRoute(builder: (context) => Splash()));
  //                 },
  //                 leading: Icon(
  //                   Icons.exit_to_app,
  //                 ),
  //                 title: Text(
  //                   'LogOut',
  //                 ),
  //               )
  //             : ListTile(
  //                 onTap: () {
  //                   print('____________________  LOGIN _________________');
  //                 },
  //                 leading: Icon(
  //                   Icons.login,
  //                 ),
  //                 title: Text(
  //                   'Login',
  //                 ),
  //               ),
  //         ListTile(
  //           onTap: () {},
  //           leading: Icon(
  //             Icons.person_add,
  //           ),
  //           title: Text(
  //             'Register',
  //           ),
  //         ),
  //         Divider(),
  //         ListTile(
  //           dense: true,
  //           title: Text(
  //             "Version 1.0",
  //             style: Theme.of(context).textTheme.bodyText2,
  //           ),
  //           trailing: Icon(
  //             Icons.remove,
  //             color: Theme.of(context).focusColor.withOpacity(0.3),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /**
   * Method for building appBar
   */
  Widget buildAppBar() {
    return PreferredSize(
      preferredSize: MediaQuery.of(context).size,
      child: Container(
        height: 100,
        width: Size.fromWidth(100).width,
        child: Column(
          children: [
            SizedBox(height: 45),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20),
                InkResponse(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black)),
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                    child: Icon(
                      Icons.menu,
                      size: 18,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Icon(
                    Icons.location_on,
                    color: Color(0XFF00CFC1),
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationScreen(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deliver to',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 17),
                      ),
                      Text(
                        '5/9 High court colony Gandhi nagar.',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.qr_code_scanner,
                  color: Colors.grey[500],
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.notifications,
                  color: Colors.grey[500],
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
