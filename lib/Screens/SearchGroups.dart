import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:test_app_chat/fb_controller/fb_firestore.dart';
class SearchGroups extends StatefulWidget {
  const SearchGroups({Key? key}) : super(key: key);

  @override
  State<SearchGroups> createState() => _SearchGroupsState();
}

class _SearchGroupsState extends State<SearchGroups> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: HexColor("#F5BD04"),
      appBar: AppBar(
        backgroundColor: HexColor("#F5BD04"),
        elevation: 0,
        title: Text("Search Groups"),
      ),


      body:  StreamBuilder<QuerySnapshot>(
          stream: FbFirestoreController().getProducts1(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> notes = snapshot.data!.docs;
              return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.group),
                    title: Text(notes[index].get('name')),
                    subtitle: Text(notes[index].get('id')),
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
    );
  }
}
