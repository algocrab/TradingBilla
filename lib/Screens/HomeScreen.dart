import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:test_app_chat/Authenticate/LoginScree.dart';
import 'package:test_app_chat/Authenticate/Methods.dart';
import 'package:test_app_chat/Screens/ChatRoom.dart';
import 'package:test_app_chat/group_chats/group_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app_chat/widgets/custom_elevated_button.dart';

import '../group_chats/group_chat_room.dart';
import 'BasicGroup.dart';
import 'SearchGroups.dart';
import 'basic_chat.dart';

class HomeScreen extends StatefulWidget {

//   final String phoneNumber;
//   HomeScreen({
//     required this.phoneNumber,
// });
  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> membersList = [];
  void getCurrentUserDetails() async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((map) {
      setState(() {
        membersList.add({
          "name": map['name'],
          "email": map['email'],
          "uid": map['uid'],
          "isAdmin": true,
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
    getAvailableGroups();

  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }

  // void setPhone(String phone) async {
  //   await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
  //     "phone": widget.phoneNumber,
  //   });
  // }


  List groupList = [];



  void getAvailableGroups() async {
    String uid = _auth.currentUser!.uid;
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('groups')
        .get()
        .then((value) {
      setState(() {
        groupList = value.docs;
        isLoading = false;
      });
    });
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }

  String chatRoomId(String user1, String user2){
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where("phone", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: HexColor("#F5BD04"),
        centerTitle: false,
        elevation: 0,
        title: Text("Trading Billa",
        style: TextStyle(
          color: Colors.white,
          // fontWeight: FontWeight.bold,
          fontSize: 25,
          fontFamily: 'Cairo'
        ),
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LoginScreen();
            },));
          }, icon: Icon(Iconsax.logout_1))
        ],
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: Container(),
              ),
            )
          :ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 10,
                  right: 10,
                ),
                child: Container(
                  width: double.infinity,
                  height: 150,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.5),
                    //     spreadRadius: 5,
                    //     blurRadius: 7,
                    //     offset: Offset(0, 3), // changes position of shadow
                    //   ),
                    // ],
                    // borderRadius: BorderRadius.circular(25),
                  ),
                  child:Stack(
                 children: [
                  Container(
                    height: 150,
                    width: 6,
                    color: Colors.green,
                  ),
                   Column(
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(
                           left: 15,
                           top: 10,
                           right: 15,
                         ),
                         child: Row(
                           children: [
                             Text('NIFTY-SGX',style: TextStyle(
                                 color: Colors.black,
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold
                             ),),

                             Spacer(),
                             Text('+15%'  ,style: TextStyle(
                                 color: Colors.black,
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold
                             ),),

                           ],
                         ),
                       ),


                       Padding(
                         padding: const EdgeInsets.only(
                           top: 15,
                           left: 15,
                           right: 15,
                         ),
                         child: Row(
                           children: [
                             Spacer(),
                             Text('17500.00'  ,style: TextStyle(
                                 color: Colors.green.shade300,
                                 fontSize: 40,
                                 fontWeight: FontWeight.bold
                             ),),
                           ],
                         ),
                       ),

                       Padding(
                         padding: const EdgeInsets.only(top: 25,left: 15,right: 15),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text('C:175000',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                             Text('H:172000',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                             Text('L:160000',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                             Text('S:171000',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                           ],
                         ),
                       ),

                     ],
                   ),
                 ],
                  ),

                ),
              ),


              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 16,
                  right: 10,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          height: 90,
                          width: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,

                          ),
                          child: Stack(
                            children: [
                             Container(
                               height: 100,
                               width: 5,
                               color: Colors.green,
                             ),

                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  top: 5
                                ),
                                child: Column(
                                  children: [
                                    Text('NIFTY',
                                      style: TextStyle(
                                   color: Colors.black,
                                   fontSize: 20,
                                   fontWeight: FontWeight.bold
                                   ),

                                    )
                                  ],
                                ),
                              ),
                            // SizedBox(height: 40,),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10,
                                    top: 5
                                ),
                                child: Column(
                                  children: [

                                    Spacer(),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Row(
                                       children: [
                                         Text('15400.00',style: TextStyle(
                                           color: Colors.black,
                                           fontWeight: FontWeight.bold
                                         ),),

                                         Spacer(),
                                         Text('+8985'   ,style: TextStyle(
                                             color: Colors.black,
                                             fontWeight: FontWeight.bold
                                         ), ),

                                       ],
                                     ),
                                   ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          height: 90,
                          width: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,

                          ),
                          child: Stack(
                            children: [
                              Container(
                                height: 100,
                                width: 5,
                                color: Colors.red,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10,
                                    top: 5
                                ),
                                child: Column(
                                  children: [
                                    Text('NIFTY',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),

                                    )
                                  ],
                                ),
                              ),
                              // SizedBox(height: 40,),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10,
                                    top: 5
                                ),
                                child: Column(
                                  children: [

                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text('15400.00',style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),),

                                          Spacer(),
                                          Text('+8985'   ,style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ), ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding (
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          height: 90,
                          width: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,

                          ),
                          child: Stack(
                            children: [
                              Container(
                                height: 100,
                                width: 5,
                                color: Colors.green,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10,
                                    top: 5
                                ),
                                child: Column(
                                  children: [
                                    Text('NIFTY',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),

                                    )
                                  ],
                                ),
                              ),
                              // SizedBox(height: 40,),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10,
                                    top: 5
                                ),
                                child: Column(
                                  children: [

                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text('15400.00',style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),),

                                          Spacer(),
                                          Text('+8985'   ,style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ), ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


               Padding(
                 padding: const EdgeInsets.only(
                   top: 20,
                   left: 20,
                   right: 10
                 ),
                 child: Row(
                   children: [
                     Text('Basic Group',
                     style: TextStyle(
                       color: Colors.black,
                       fontWeight: FontWeight.bold,
                       fontSize: 22,
                     ),
                     )
                   ],
                 ),
               ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey,
                      ),
                      title: Text('Billa Group'),
                      subtitle: Text('Aug 10, 2022 12:54:50 PM'),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                          ),
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return BasicChat();
                          },));
                        },
                        child: Text('Join Group'),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 10
                ),
                child: Row(
                  children: [
                    Text('Your Group',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
