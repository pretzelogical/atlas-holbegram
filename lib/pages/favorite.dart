import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Favorites', style: TextStyle(fontFamily: 'Billabong', fontSize: 32)),
          ],
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: const 
      ),
    );
  }
}