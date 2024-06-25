import 'package:flutter/material.dart';

class HolbegramHeader extends StatelessWidget {
  const HolbegramHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      children: [
        SizedBox(
          height: 78,
          child: Text(
            "Holbegram",
            style: TextStyle(
              fontFamily: 'Billabong',
              fontSize: 50,
            ),
          ),
        ),
        SizedBox(
            height: 80,
            child: Image(
              height: 60,
              width: 80,
              image: AssetImage('assets/images/logo.webp'),
            )),
      ],
    ));
  }
}
