import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holbegram/screens/home.dart';
import 'package:holbegram/widgets/holbegram_header.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:image_picker/image_picker.dart';

class AddPicture extends StatefulWidget {
  final String email;
  final String password;
  final String username;
  final Uint8List? _image;

  const AddPicture(
      {super.key,
      required this.email,
      required this.password,
      required this.username,
      Uint8List? image})
      : _image = image;

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  Uint8List? image;
  final ImagePicker _imagePicker = ImagePicker();
  final userImgUrl =
      "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png";

  void selectImageFromGallery() async {
    final XFile? imgRes =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (imgRes == null) {
      return;
    }
    final imageTemp = await imgRes.readAsBytes();
    setState(() {
      image = imageTemp;
    });
  }

  void selectImageFromCamera() async {
    final XFile? imgRes =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (imgRes == null) {
      return;
    }
    final imageTemp = await imgRes.readAsBytes();
    setState(() {
      image = imageTemp;
    });
  }

  void loadUserImage() async {
    var fetchedImage =
        await NetworkAssetBundle(Uri.parse(userImgUrl)).load(userImgUrl);
    if (widget._image != null) {
      setState(() {
        image = widget._image;
      });
    }
    setState(() {
      image = fetchedImage.buffer.asUint8List();
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: HolbegramHeader(),
                    ),
                    Text("Hello, ${widget.username} Welcome to Holbegram.",
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            height: 1.2)),
                    const Text(
                        "Choose an image from your gallery or take a new one.",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: ClipOval(
                      clipBehavior: Clip.antiAlias,
                      child: image != null
                          ? Image.memory(
                              image!,
                              height: 200,
                              width: 200,
                              fit: BoxFit.scaleDown,
                            )
                          : const CircularProgressIndicator())),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.image_outlined,
                          size: 50, color: Color.fromARGB(218, 226, 37, 24)),
                      onPressed: selectImageFromGallery,
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt_outlined,
                          size: 50, color: Color.fromARGB(218, 226, 37, 24)),
                      onPressed: selectImageFromCamera,
                    )
                  ]),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: FilledButton(
                    onPressed: () async {
                        final result = await AuthMethods().signUpUser(
                          email: widget.email,
                          password: widget.password,
                          username: widget.username,
                          file: image,
                        );
                        if (result == 'Success' && mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Account created successfully'),
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ),
                          );
                        }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 226, 37, 24)),
                      padding: WidgetStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    child: const Text('Next', style: TextStyle(fontSize: 28)),
                  ))
            ])));
  }
}
