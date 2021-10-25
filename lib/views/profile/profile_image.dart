import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_shop/services/auth.dart';
import 'package:dsc_shop/services/firestore.dart';
import 'package:dsc_shop/models/user.dart';
import 'package:dsc_shop/shared/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;

class ProfileImage extends StatefulWidget {

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: DataBase().getUser(Users(id: Provider.of<AuthProvider>(context).currentUser())),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        } else {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Positioned(
            top: MediaQuery.of(context).size.height * 0.03,
            left: MediaQuery.of(context).size.width / 3,
            child: CircleAvatar(
              backgroundColor: whiteColor,
              radius: MediaQuery.of(context).size.width * 0.18,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CachedNetworkImage(
                    imageUrl: data["image"],
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    width: MediaQuery.of(context).size.width * 0.330,
                    height: MediaQuery.of(context).size.width * 0.330,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.170,
                      backgroundColor: Colors.transparent,
                      backgroundImage: imageProvider,
                    ),
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: whiteColor,
                    child: CircleAvatar(
                      child: IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: whiteColor,
                          ),
                          onPressed: () {
                            getImageFromGallery(context);
                          }),
                      backgroundColor: grey400Color,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  void getImageFromGallery(context)  {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value){
      setState(() {
        if (value != null) {
          uploadImage(File(value.path),context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You Updated Image Successful")));
        } else {
          print('No image selected.');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select Your Image")));
        }
      });
    });
  }

  Future<void> uploadImage(File image,context) async {
    FirebaseStorage storage = FirebaseStorage.instanceFor(bucket: "gs://dsc-shop-a48c1.appspot.com");
    final Reference storageReference = storage.ref().child(p.basename(image.path));
    await storageReference.putFile(image).whenComplete(() async {
      String downUrl= await storageReference.getDownloadURL();
      await DataBase().updateUser(Users(id: FirebaseAuth.instance.currentUser!.uid),{
        "image":downUrl,
      });

    });
  }
}
