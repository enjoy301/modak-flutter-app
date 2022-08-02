import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/dark/DarkIcons_icons.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/screens/album/album_landing_screen.dart';
import 'package:modak_flutter_app/screens/chat/landing/chat_landing_screen.dart';
import 'package:modak_flutter_app/screens/home/home_landing_screen.dart';
import 'package:modak_flutter_app/screens/todo/landing/todo_landing_screen.dart';
import 'package:modak_flutter_app/screens/user/user_landing_screen.dart';
import 'package:modak_flutter_app/widgets/icon/icon_gradient_widget.dart';

class LandingBottomNavigator extends StatefulWidget {
  const LandingBottomNavigator({Key? key}) : super(key: key);

  @override
  State<LandingBottomNavigator> createState() => _LandingBottomNavigatorState();
}

class _LandingBottomNavigatorState extends State<LandingBottomNavigator> {
  int currentIndex = 0;

  final pages = [
    HomeLandingScreen(),
    TodoLandingScreen(),
    ChatLandingScreen(),
    AlbumLandingScreen(),
    UserLandingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    EdgeInsets iconPadding = EdgeInsets.only(top: 8, bottom: 3, left: 12, right: 12);
    return Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: Wrap(
          children: [
            Container(
              padding: EdgeInsets.only(top: 13),
              color: Colors.white,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() => currentIndex = 0);
                        },
                        icon: currentIndex == 0
                            ? IconGradientWidget(
                                DarkIcons.Home, 25, Coloring.sub_purple)
                            : Icon(
                                LightIcons.Home,
                                color: Coloring.gray_20,
                              ),
                        constraints: BoxConstraints(),
                        padding: iconPadding,
                      ),
                      Dot(
                        visability: currentIndex == 0,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() => currentIndex = 1);
                        },
                        icon: currentIndex == 1
                            ? IconGradientWidget(
                                DarkIcons.TickSquare, 25, Coloring.sub_purple)
                            : Icon(
                                LightIcons.TickSquare,
                                color: Coloring.gray_20,
                              ),
                        constraints: BoxConstraints(),
                        padding: iconPadding,
                      ),
                      Dot(
                        visability: currentIndex == 1,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatLandingScreen()));
                        },
                        icon: currentIndex == 2
                            ? IconGradientWidget(
                                DarkIcons.Chat, 25, Coloring.sub_purple)
                            : Icon(
                                LightIcons.Chat,
                                color: Coloring.gray_20,
                              ),
                        constraints: BoxConstraints(),
                        padding: iconPadding,
                      ),
                      Dot(
                        visability: currentIndex == 2,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() => currentIndex = 3);
                        },
                        icon: currentIndex == 3
                            ? IconGradientWidget(
                                DarkIcons.Image, 25, Coloring.sub_purple)
                            : Icon(
                                LightIcons.Image,
                                color: Coloring.gray_20,
                              ),
                        constraints: BoxConstraints(),
                        padding: iconPadding,
                      ),
                      Dot(
                        visability: currentIndex == 3,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() => currentIndex = 4);
                        },
                        icon: currentIndex == 4
                            ? IconGradientWidget(
                                DarkIcons.Profile, 25, Coloring.sub_purple)
                            : Icon(
                                LightIcons.Profile,
                                color: Coloring.gray_20,
                              ),
                        constraints: BoxConstraints(),
                        padding: iconPadding,
                      ),
                      Dot(
                        visability: currentIndex == 4,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class Dot extends StatelessWidget {
  const Dot({Key? key, required this.visability}) : super(key: key);
  final bool visability;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        color: visability ? null : Colors.white,
        gradient: visability ? Coloring.sub_purple : null,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
