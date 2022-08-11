import 'package:cloud_firestore/cloud_firestore.dart';

class FbFirestoreController{

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getProducts1()async*{
    yield*  _firebaseFirestore.collection('users').snapshots();
  }
}