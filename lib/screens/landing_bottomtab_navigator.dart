import 'package:flutter/material.dart';
import 'package:modak_flutter_app/screens/album/album_landing_screen.dart';
import 'package:modak_flutter_app/screens/chat/chat_landing_screen.dart';
import 'package:modak_flutter_app/screens/home/home_landing_screen.dart';
import 'package:modak_flutter_app/screens/todo/todo_landing_screen.dart';
import 'package:modak_flutter_app/screens/user/user_landing_screen.dart';

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
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
          BottomNavigationBarItem(icon: Icon(Icons.schedule_send), label: "TODO"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "CHAT"),
          BottomNavigationBarItem(icon: Icon(Icons.my_library_add), label: "ALBUM"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "USER"),
        ],
      ),
    );
  }
}
