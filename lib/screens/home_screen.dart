import 'package:flutter/material.dart';
import 'package:indglobalyomess/services/permission_service.dart';
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

/**
 *
 */
class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

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


  @override
  Widget build(BuildContext context) {

    double defaultSize = SizeConfig.defaultSize; // default size is approximately 10

    return SafeArea(
      child: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(defaultSize),
            child: Text('This is home screen'),
          ),
        ),
      ),
    );
  }

}
