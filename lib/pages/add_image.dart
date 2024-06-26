import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:holbegram/models/user.dart';
import 'package:holbegram/widgets/text_field.dart';
import 'package:holbegram/methods/post_storage.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  final TextEditingController captionController;
  final ImagePicker imagePicker = ImagePicker();
  AddImage({super.key, required this.captionController});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  Uint8List? image;

  void selectImage(ImageSource source) async {
    final XFile? imgRes = await widget.imagePicker.pickImage(source: source);
    if (imgRes == null) {
      return;
    }
    final imageTemp = await imgRes.readAsBytes();
    setState(() {
      image = imageTemp;
    });
  }

  @override
  void initState() {
    super.initState();
    image = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Image',
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const Column(children: [
              Text('Add Image',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              Text(
                'Choose an image from gallery or take one',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ]),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFieldInput(
                  controller: widget.captionController,
                  hintText: 'Write a caption',
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: image == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              selectImage(ImageSource.gallery);
                            },
                            icon: const Icon(Icons.image),
                          ),
                          IconButton(
                            onPressed: () {
                              selectImage(ImageSource.camera);
                            },
                            icon: const Icon(Icons.camera),
                          ),
                        ],
                      )
                    : Column(children: [
                        Image.memory(
                          image!,
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  image = null;
                                });
                              },
                              icon: const Icon(Icons.close),
                            ),
                            IconButton(
                              onPressed: () async {
                                final UserModel userDetails =
                                    await AuthMethods().getUserDetails();
                                final res = await PostStorage().uploadPost(
                                  widget.captionController.text,
                                  userDetails.uid ?? '',
                                  userDetails.username ?? '',
                                  userDetails.photoUrl ?? '',
                                  image ?? Uint8List(0),
                                );
                                if (mounted) {
                                  if (res == 'Success') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Post Uploaded')),
                                    );
                                    return;
                                  }

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(res)),
                                  );
                                }
                              },
                              icon: const Icon(Icons.send),
                            )
                          ],
                        )
                      ]))
          ],
        )));
  }
}
