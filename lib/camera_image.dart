import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:covapp/vax-details.dart';

final Color teal = Colors.teal;
final Color blue = Colors.lightBlueAccent;
String imageURL="";

class UploadingImageToFirebaseStorage extends StatefulWidget {
  @override
  _UploadingImageToFirebaseStorageState createState() =>
      _UploadingImageToFirebaseStorageState();
}

class _UploadingImageToFirebaseStorageState
    extends State<UploadingImageToFirebaseStorage> {
  var _imageFile;

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(File(_imageFile.path));
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => imageURL=value,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0)),
              gradient: LinearGradient(
                colors: [blue, teal],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Uploading Vaccination Card",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        height: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: _imageFile != null
                              ? Image.file(File(_imageFile.path))
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                  ),
                                  child: Icon(
                                    Icons.add_a_photo,
                                    size: 50,
                                    color: Colors.black,
                                  ),
                                  onPressed: pickImage,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                uploadImageButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget uploadImageButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                uploadImageToFirebase(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VaccineInfo()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                onPrimary: Colors.white,
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontStyle: FontStyle.italic),
              ),
              child: Text(
                "Upload Image",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     context.read<AuthenticationService>().signOut();
          //   },
          //   child: Text("Sign Out"),
          // ),
        ],
      ),
    );
  }
}
