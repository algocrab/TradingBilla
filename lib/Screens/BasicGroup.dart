// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:test_app_chat/Screens/basic_chat.dart';
// import 'package:uuid/uuid.dart';
//
// class BasicGroup extends StatefulWidget {
//   const BasicGroup({Key? key}) : super(key: key);
//
//   @override
//   State<BasicGroup> createState() => _BasicGroupState();
// }
//
// class _BasicGroupState extends State<BasicGroup> {
//   final TextEditingController _message = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   bool isChecked = false;
//
//
//
//   File? imageFile;
//   Future getImage() async {
//     ImagePicker _picker = ImagePicker();
//
//     await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
//       if (xFile != null) {
//         imageFile = File(xFile.path);
//         // onSendMessage();
//       }
//     }
//     );
//   }
//
//
//
//
//
//
//
//
//
//   void onSendMessage() async {
//
//
//
//
//
//
//     String fileName = Uuid().v1();
//     int status = 1;
//
//     var ref =
//     FirebaseStorage.instance.ref().child('basic-group-Image').child("$fileName.jpg");
//
//     var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
//       await _firestore
//           .collection('basic-group')
//           .doc('NM6GQFTiF8rfCHzL5obP')
//           .collection('chats');
//
//       status = 0;
//     });
//
//     if (_message.text.isNotEmpty) {
//       String imageUrl = await uploadTask.ref.getDownloadURL();
//       Map<String, dynamic> chatData = {
//         "sendby": _auth.currentUser!.displayName,
//         "id":_auth.currentUser!.uid,
//         "message": _message.text,
//         "imageUrl":imageUrl,
//         "admin-approve":isChecked,
//         "type": "text",
//         "time": FieldValue.serverTimestamp(),
//       };
//
//       _message.clear();
//
//       await _firestore
//           .collection('basic-group')
//           .doc('NM6GQFTiF8rfCHzL5obP')
//           .collection('chats')
//           .add(chatData);
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: HexColor("#F5BD04"),
//         elevation: 0,
//         onPressed:(){
//           onSendMessage();
//           Navigator.push(context, MaterialPageRoute(builder: (context) {
//             return BasicChat();
//           },
//           )
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//       appBar: AppBar(
//         backgroundColor: HexColor("#F5BD04"),
//         elevation: 0,
//         title: Text("Trading Billa",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 25,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             // child:ShowImage(imageUrl: imageUrl),
//           ),
//           InkWell(
//               onTap:getImage,
//               child: Text('Add Image',
//               style: TextStyle(
//                 color: Colors.blue,
//               ),
//               ),
//           ),
//           Padding(
//             padding:  EdgeInsets.all(20.0),
//             child:TextField(
//               controller:_message,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Messege',
//               ),
//             )
//           ),
//
//
//
//           Padding(
//               padding:  EdgeInsets.all(20.0),
//               child:TextField(
//                 controller:_message,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Link',
//                 ),
//               )
//           ),
//
//
//           Column(
//             children: <Widget>[
//               const SizedBox(height: 30,),
//               CheckboxListTile(
//                 title: Text('keep Admin Confirmation'),
//                 checkColor: Colors.white,
//                 value: isChecked,
//                 onChanged: (bool? value) {
//                   setState(() {
//                     isChecked = value!;
//                   });
//                 },
//               ),
//             ],
//           ),
//
//     isChecked?Padding(
//       padding: const EdgeInsets.only(
//         left: 10,
//         right: 10,
//       ),
//       child: Container(
//         // height: 10,
//         width: double.infinity,
//         height: 30,
//         color: Colors.yellow.shade100,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 10,top: 6,bottom: 4),
//
//           child: Text(
//             'will show only once admin approve the post',
//
//             style: TextStyle(
//               color: Colors.black,
//
//             ),
//           ),
//         ),
//       ),
//     ):Container(),
//
//
//
//
//         ],
//       ),
//     );
//   }
//   // Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
//   //   return map['type'] == "text"
//   //       ? Container(
//   //     width: size.width,
//   //     alignment: map['sendby'] == _auth.currentUser!.displayName
//   //         ? Alignment.centerRight
//   //         : Alignment.centerLeft,
//   //     child: Container(
//   //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
//   //       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
//   //       decoration: BoxDecoration(
//   //         border: Border.all(
//   //             color: HexColor("#F5BD04")
//   //         ),
//   //         borderRadius: BorderRadius.circular(15),
//   //         color: Colors.white,
//   //       ),
//   //       child: Column(
//   //         children: [
//   //           Text(_auth.currentUser!.displayName.toString()),
//   //           Text(
//   //             map['message'],
//   //             style: TextStyle(
//   //               fontSize: 16,
//   //               fontWeight: FontWeight.w500,
//   //               color: Colors.black,
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   )
//   //       : Container(
//   //     height: size.height / 2.5,
//   //     width: size.width,
//   //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//   //     alignment: map['sendby'] == _auth.currentUser!.displayName
//   //         ? Alignment.centerRight
//   //         : Alignment.centerLeft,
//   //     child: InkWell(
//   //       onTap: () => Navigator.of(context).push(
//   //         MaterialPageRoute(
//   //           builder: (_) => ShowImage(
//   //             imageUrl: map['message'],
//   //           ),
//   //         ),
//   //       ),
//   //       child: Container(
//   //         height: size.height / 2.5,
//   //         width: size.width / 2,
//   //         decoration: BoxDecoration(border: Border.all()),
//   //         alignment: map['message'] != "" ? null : Alignment.center,
//   //         child: map['message'] != ""
//   //             ? Image.network(
//   //           map['message'],
//   //           fit: BoxFit.cover,
//   //         )
//   //             : CircularProgressIndicator(),
//   //       ),
//   //     ),
//   //   );
//   // }
// }
// // class ShowImage extends StatelessWidget {
// //   final String imageUrl;
// //
// //   const ShowImage({required this.imageUrl, Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final Size size = MediaQuery.of(context).size;
// //
// //     return Scaffold(
// //       body: Container(
// //         height: 100,
// //         width: 100,
// //         color: Colors.black,
// //         child: Image.network(imageUrl),
// //       ),
// //     );
// //   }
// // }