import 'package:flutter/material.dart';
import 'package:holbegram/widgets/bottom_nav.dart';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BottomNav();
  }
}