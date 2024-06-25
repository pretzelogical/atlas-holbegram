import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:holbegram/widgets/holbegram_header.dart';


class AddPicture extends StatefulWidget {
  final String email;
  final String password;
  final String username;
  final Uint8List? _image;


  const AddPicture({
    super.key,
    required this.email,
    required this.password,
    required this.username,
    Uint8List? image
  })
      : _image = image;

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  Uint8List? image;

  @override
  void initState() {
    super.initState();
    image = widget._image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 300,
            child: Column(
              children: [
                HolbegramHeader(),
                
              ],
            )
          )
        ],      )
    );
  }
}