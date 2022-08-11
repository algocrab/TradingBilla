
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_app_chat/Authenticate/Methods.dart';
import 'package:test_app_chat/Screens/ChatRoom.dart';
import 'package:test_app_chat/group_chats/group_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app_chat/widgets/custom_elevated_button.dart';
import 'package:test_app_chat/widgets/custom_text_field.dart';

import '../fb_controller/fb_firestore.dart';

class SearchUser extends StatefulWidget {
//
//   final String phoneNumber;
//   SearchUser({
//     required this.phoneNumber,
// });
  @override
  _SearchUserState createState() => _SearchUserState();

}

class _SearchUserState extends State<SearchUser> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver(this);
  //   setStatus("Online");
  // }
  //
  // void setStatus(String status) async {
  //   await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
  //     "status": status,
  //   });
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     // online
  //     setStatus("Online");
  //   } else {
  //     // offline
  //     setStatus("Offline");
  //   }
  // }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1 $user2";
    } else {
      return "$user2 $user1";
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        // .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        // userMap = value.docs[1].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: HexColor("#F5BD04"),
      appBar: AppBar(
        backgroundColor: HexColor("#F5BD04"),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text("Trading Billa",
        style: TextStyle(
          color: Colors.white,
          // fontWeight: FontWeight.bold,
          fontSize: 25,
          fontFamily: 'Cairo'
        ),
        ),
        // actions: [
        //   IconButton(icon: Icon(Iconsax.logout_1,
        //   size: 26,
        //   ), onPressed: () => logOut(context))
        // ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: TextField(
              controller:_search,
              decoration: InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 400,
            child: StreamBuilder<QuerySnapshot>(
                stream: FbFirestoreController().getProducts1(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    List<QueryDocumentSnapshot> notes = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        return InkWell(

                          onTap: (){
                            // onSearch();
                            // // print(userMap);
                            // String roomId = chatRoomId(
                            //     _auth.currentUser!.displayName!,
                            //     userMap!['name']);
                            //
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (_) => ChatRoom(
                            //       chatRoomId: roomId,
                            //       userMap: userMap![_auth.currentUser!.displayName]
                            //     ),
                            //   ),
                            // );
                          },
                          child: ListTile(
                            leading: const Icon(Icons.group),
                            title: Text(notes[index].get('name')),
                            subtitle: Text(notes[index].get('email')),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.warning, size: 80),
                          Text(
                            'NO DATA',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
          ),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: HexColor("#F5BD04"),
      //   child: Icon(Icons.group),
      //   onPressed: () => Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (_) => GroupChatHomeScreen(),
      //     ),
      //   ),
      // ),
    );
  }
}


/*
isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: Container(),
              ),
            )
          :Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40,
                left:20,
                right:20,
              ),
              child: Column(
                children: [

                 Row(
                   children: [
                     Text('Welcome , ${_auth.currentUser!.displayName}',
                       style: TextStyle(
                         color: Colors.black,
                         fontSize: 25,
                         fontFamily: 'Cairo',
                         fontWeight: FontWeight.bold,
                       ),

                     ),
                   ],
                 ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10
                    ),
                    child: Row(
                      children: [
                      Column(
                        children: [
                          Text('Search about users here !',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 19,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                            ),

                          ),

                        ],
                      ),

                      ],
                    ),
                  ),
                Row(
                  children: [
                    Text('Using Email Address',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: TextField(
                      controller:_search,
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  CustomElevatedButton(
                      function: (){
                        onSearch();
                      },
                      text: 'Search'
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  userMap != null
                      ?
                  Container(
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow.shade100),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade100,
                    ),
                    child: Center(
                      child: ListTile(
                        onTap: () {
                          String roomId = chatRoomId(
                              _auth.currentUser!.displayName!,
                              userMap!['name']);

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ChatRoom(
                                chatRoomId: roomId,
                                userMap: userMap!,
                              ),
                            ),
                          );
                        },
                        leading: Icon(Iconsax.profile_2user, color: Colors.black),
                        title: Text(
                          userMap!['name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(userMap!['email']),
                        trailing: Icon(Iconsax.message, color: Colors.black),
                      ),
                    ),
                  )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
 */