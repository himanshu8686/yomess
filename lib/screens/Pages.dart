import 'package:flutter/material.dart';
import 'package:indglobalyomess/screens/CartScreen.dart';
import 'package:indglobalyomess/screens/ExploreScreen.dart';
import 'package:indglobalyomess/screens/OurServicesScreen.dart';
import 'package:indglobalyomess/screens/ProfileScreen.dart';
import 'package:indglobalyomess/screens/home_screen.dart';
import 'package:indglobalyomess/services/permission_service.dart';
import 'package:indglobalyomess/utils/Constant.dart';
import 'package:indglobalyomess/utils/NavigationHelper.dart';
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

  /**
   *
   */
  Future permissionAccess() {
    PermissionService().requestAllPermission();
  }

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CartScreen(),
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
      drawer: buildDrawer(defaultSize, context),
      bottomNavigationBar: buildBottomNavigationBar(defaultSize),
    );
  }

  /**
   *  Method for building bottom navigation bar
   */
  BottomNavigationBar buildBottomNavigationBar(double defaultSize) {
    return BottomNavigationBar(
      onTap: _onItemTapped,
      currentIndex: _currentSelected,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: kPrimaryBlueColor,
      elevation: defaultSize,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        BottomNavigationBarItem(
            icon: Icon(Icons.room_service), label: 'Service'),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
      ],
    );
  }

  /**
   *  Method for building side drawer
   */
  Drawer buildDrawer(double defaultSize, BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: defaultSize),
              decoration: BoxDecoration(color: Colors.black12),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: kPrimaryAuthOrangeColor,
                  size: defaultSize * 3,
                ),
                title: Text(
                  'Guest',
                  style: TextStyle(
                      color: kPrimaryAuthOrangeColor,
                      fontSize: defaultSize * 2.2),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                _onItemTapped(NavigationHelper.HOME_INDEX);
                Navigator.pop(context);
              },
              leading: Icon(
                Icons.home,
              ),
              title: Text(
                'Home',
              ),
            ),
            ListTile(
              onTap: () {
                _onItemTapped(NavigationHelper.CART_INDEX);
                Navigator.pop(context);
              },
              leading: Icon(
                Icons.shopping_cart,
              ),
              title: Text(
                'Cart',
              ),
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text(
                "Application preferences",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              trailing: Icon(
                Icons.remove,
                color: Theme.of(context).focusColor.withOpacity(0.3),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.help,
              ),
              title: Text(
                'Help And Support',
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.settings,
              ),
              title: Text(
                'Settings',
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.exit_to_app,
              ),
              title: Text(
                'Login',
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.person_add,
              ),
              title: Text(
                'Register',
              ),
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text(
                "Version 1.0",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              trailing: Icon(
                Icons.remove,
                color: Theme.of(context).focusColor.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /**
   * Method for building appBar
   */
  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.sort,
          color: Colors.black,
        ),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.qr_code_scanner,
              color: Colors.black,
            ),
            onPressed: () {}),
        IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
            onPressed: () {}),
      ],
    );
  }
}
