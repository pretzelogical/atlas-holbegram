import 'package:flutter/material.dart';
import 'package:holbegram/pages/feed.dart';
import 'package:holbegram/screens/placeholder_home_page.dart';

class BottomNav extends StatefulWidget {
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn);
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.star),
              label: 'Debug',
            ),
          ]),
      body: PageView(
        controller: _pageController,
        children: [
          Feed(),
          const PlaceholderHomePage()
        ],
      ),
    );
  }
}
