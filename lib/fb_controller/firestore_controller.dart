import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

class FbFireStoreController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<Users> readUser({required String id}) async {
    return await _firebaseFirestore
        .collection('users')
        .where('id', isEqualTo: id)
        .get()
        .then((value) {
      Users user = Users();
      user.id = value.docs.first.get('id');
      user.name = value.docs.first.get('name');
      user.email = value.docs.first.get('email');
      return user;
    },
        onError: (e) {
          return Users();
        });
  }


    // get all users from firebse

  Stream<QuerySnapshot> getAllUsers()async*{
    yield*  _firebaseFirestore.collection('users').snapshots();
  }

  Future<bool> delete({required String path}) async {
    return _firebaseFirestore
        .collection('users')
        .doc(path)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }
}