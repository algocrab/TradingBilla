
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart'as firebase_storage ;
import 'package:firebase_core/firebase_core.dart'as firebase_core ;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/utils.dart';
import 'package:path/path.dart';


class FBStorage{
  final firebase_storage.FirebaseStorage storage =
  firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
      String filepath,
      String fileName,
      )async{
      File file = File(filepath);

        await storage.ref('posts/$fileName').putFile(file);

  }


  Future<String> dawonloadURL(String imageName)async{
   String dawonloadURL = await storage.ref('posts/$imageName').getDownloadURL();
   return dawonloadURL;
  }
}