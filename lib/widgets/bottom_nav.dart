import 'package:flutter/material.dart';
import 'package:holbegram/pages/feed.dart';
import 'package:holbegram/screens/debug_screen.dart';
import 'package:holbegram/pages/add_image.dart';
import 'package:holbegram/pages/favorite.dart';

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
          indicatorColor: const Color.fromARGB(255, 255, 190, 185),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: _currentIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(index);
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.add_outlined),
              label: 'Add',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border),
              label: 'Favorites'
            ),
            NavigationDestination(
              icon: Icon(Icons.star_outline),
              label: 'Debug',
            ),
          ]),
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          if (_currentIndex == value) return;
          setState(() {
            _currentIndex = value;
          });
        },
        children: [
          Feed(),
          AddImage(
            captionController: TextEditingController(),
          ),
          const Favorites(),
          const DebugScreen()
        ],
      ),
    );
  }
}
