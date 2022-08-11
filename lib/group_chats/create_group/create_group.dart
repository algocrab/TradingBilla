import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:test_app_chat/Screens/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app_chat/Screens/app.dart';
import 'package:test_app_chat/widgets/custom_elevated_button.dart';
import 'package:uuid/uuid.dart';

class CreateGroup extends StatefulWidget {
  final List<Map<String, dynamic>> membersList;

  const CreateGroup({required this.membersList, Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final TextEditingController _groupName = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;



  File? imageFile;
  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    }
    );
  }

  Future uploadImage() async {
    String fileName = Uuid().v1();

  }


  void createGroup() async {

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AppScreen();
    },));
    setState(() {
      isLoading = true;
    });

    String groupId = Uuid().v1();
    String fileName = Uuid().v1();
    for (int i = 0; i < widget.membersList.length; i++) {
      int status = 1;
      String uid = widget.membersList[i]['uid'];

      var ref =
      FirebaseStorage.instance.ref().child('image-to-group').child(
          "$fileName.jpg");

      var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('groups')
            .doc(fileName)
            .delete();

        status = 0;
      });

      if (status == 1) {
        String imageUrl = await uploadTask.ref.getDownloadURL();
        String uid = widget.membersList[i]['uid'];

        await _firestore
            .collection('users')
            .doc(uid)
            .collection('groups')
            .doc(fileName)
            .set({
          "name": _groupName.text,
          "id": groupId,
          "image":imageUrl,
        });
        print(imageUrl);
      }
    }

    await _firestore.collection('groups').doc(groupId).set({
      "id": groupId,
      "name":_groupName.text,
      "createdBy":_auth.currentUser!.displayName,
      "createdAt":DateTime.now(),
      "members": widget.membersList,

    });


    await _firestore.collection('groups').doc(groupId).collection('chats').add({
      "message": "${_auth.currentUser!.displayName} Created This Group.",
      "type": "notify",
    });

    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#F5BD04"),
        elevation: 0,
        title: Text("Group Name",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),


        ),

      ),
      body: isLoading
          ? Container(
              height: size.height,
              width: size.width,
              alignment: Alignment.center,
              child:  LoadingAnimationWidget.dotsTriangle(
                color: HexColor("#F5BD04"),
                size: 30,
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: size.height / 10,
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: HexColor("#F5BD04"))

                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                      child: IconButton(
                        onPressed: getImage,
                        icon: Icon(Icons.add_circle,color: Colors.black,),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height / 14,
                  width: size.width,
                  alignment: Alignment.center,
                  child: Container(
                    height: size.height / 14,
                    width: size.width / 1.15,
                    child: TextField(
                      controller: _groupName,
                      decoration: InputDecoration(
                        hintText: "Enter Group Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 15,
                    right:15,
                  ),
                  child: CustomElevatedButton(function: createGroup, text:'Create Group'),
                )
              ],
            ),
    );
  }
}


//