import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:indglobalyomess/screens/login_screen.dart';
import 'package:indglobalyomess/utils/constant.dart';

class SliderScreen extends StatefulWidget {
  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image(
              image: AssetImage('assets/img/slider_1.png'),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.35),
            child: Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                options: CarouselOptions(
                    height: 300.0,
                    viewportFraction: 0.7,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        indexSelected = index;
                      });
                    }),
                items: [1, 2, 3].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: 250,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 40,
                                spreadRadius: -10,
                                offset: Offset(0, 0.5),
                              )
                            ]),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Image(
                              image: AssetImage('assets/img/slider_i.png'),
                              width: 250,
                            ),
                            Text(
                              'Yummy and fresh foods',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Hurry and make these fresh summer recipes while you still can! You\'ll find salads, main dishes',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.78),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Container(
                    height: 20,
                    width: 20,
                    margin: EdgeInsets.symmetric(horizontal: 7),
                    decoration: BoxDecoration(
                      border: indexSelected != index
                          ? Border.all(color: Colors.black38)
                          : Border.all(color: Colors.transparent),
                      color: indexSelected == index
                          ? Color(0XFF00B9AC)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                )),
          ),
          Align(
            alignment: Alignment(0.95, 0.98),
            child: Container(
              width: MediaQuery.of(context).size.width / 6,
              height: MediaQuery.of(context).size.height / 25,
              child: FlatButton(
                onPressed: () {
                  prefs.setBool('isSlider', true);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false);
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.height / 65,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey[300],
                    ),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
