import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holbegram/widgets/holbegram_header.dart';
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
          padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(
            height: 220,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HolbegramHeader(),
                Text("Hello ${widget.username}",
                    style: const TextStyle(fontSize: 20)),
                Text("Choose an image from your gallery or take a new one",
                    style: const TextStyle(fontSize: 12)),
              ],
            )),
            image != null
                    ? Image.memory(
                        image!,
                        height: 200,
                        width: 200,
                        fit: BoxFit.contain,
                      )
                    : Text('Loading image...'),
            // Row(
            //   children: [
            //     IconButton(
            //       icon: Icon(Icon.),
            //       onPressed: selectImageFromGallery,
            //     ),
            //     IconButton(
            //       Icon(Icon.camera),
            //       onPressed: selectImageFromCamera,
            //     ),
            //   ],
            // )
        ]
      )
      
    ));
  }
}
