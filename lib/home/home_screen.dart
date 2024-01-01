import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/constants.dart';
import '../../models/function.dart';
import '../screens/screen1/intro_screen1.dart';
import '../screens/screen2/intro_screen2.dart';
import '../screens/screen3/intro_screen3.dart';
import '../screens/screen4/intro_screen4.dart';
import '../screens/screen5/intro_screen5.dart';
import '../screens/screen6/intro_screen6.dart';
import 'item_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home',style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: GridView.builder(
                itemCount: fitnessfunctions.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) => ItemCard(
                  fitnessfunction: fitnessfunctions[index],
                  press: () {
                    if (fitnessfunctions[index].id == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IntroScreen1(
                            fitnessfunction: fitnessfunctions[index],
                          ),
                        ),
                      );
                    } else if (fitnessfunctions[index].id == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IntroScreen2(
                            fitnessfunction: fitnessfunctions[index],
                          ),
                        ),
                      );
                    }
                    else if (fitnessfunctions[index].id == 3) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IntroScreen3(
                            fitnessfunction: fitnessfunctions[index],
                          ),
                        ),
                      );
                    }
                    else if (fitnessfunctions[index].id == 4) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IntroScreen4(
                            fitnessfunction: fitnessfunctions[index],
                          ),
                        ),
                      );
                    }
                    else if (fitnessfunctions[index].id == 5) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IntroScreen5(
                            fitnessfunction: fitnessfunctions[index],
                          ),
                        ),
                      );
                    }
                    else if (fitnessfunctions[index].id == 6) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IntroScreen6(
                            fitnessfunction: fitnessfunctions[index],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(displayWidth * .05),
        height: displayWidth * .155,
        decoration: BoxDecoration(
          color: Colors.pinkAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .32
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == currentIndex ? displayWidth * .12 : 0,
                    width: index == currentIndex ? displayWidth * .32 : 0,
                    decoration: BoxDecoration(
                      color: index == currentIndex
                          ? Colors.blueAccent.withOpacity(.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .31
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                            index == currentIndex ? displayWidth * .13 : 0,
                          ),
                          AnimatedOpacity(
                            opacity: index == currentIndex ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == currentIndex
                                  ? '${listOfStrings[index]}'
                                  : '',
                              style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                            index == currentIndex ? displayWidth * .03 : 20,
                          ),
                          Icon(
                            listOfIcons[index],
                            size: displayWidth * .076,
                            color: index == currentIndex
                                ? Colors.white
                                : Colors.black12,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.settings_rounded,
    Icons.person_rounded,
  ];

  List<String> listOfStrings = [
    'Home',
    'Favorite',
    'Settings',
    'Account',
  ];
}
