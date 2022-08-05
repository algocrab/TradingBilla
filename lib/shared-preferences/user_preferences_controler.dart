import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class UserPreferenceController {
  static final UserPreferenceController _instanse =
  UserPreferenceController._internal();
  late SharedPreferences _sharedPreferences;
  UserPreferenceController._internal();
  factory UserPreferenceController() {
    return _instanse;
  }
  Future<void> initSharedPreference() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveUsers({
    required Users users ,
    required String name,
    required String email,
  }) async {
    _sharedPreferences.setBool('logged_in' ,true);
    _sharedPreferences.setString('id', users.id);
    _sharedPreferences.setString('name', users.name);
    _sharedPreferences.setString('email', users.email);

  }

  String get id =>_sharedPreferences.getString('id')??'111111';
  String get name =>_sharedPreferences.getString('name')??'Your Name';
  String get email =>_sharedPreferences.getString('email')??'example@gmail.com';
  //
  // Future<bool> get active =>_sharedPreferences.setBool('logged_in', true);
  //
  // Users get userInformation {
  //   Users user = Users();
  //   user.id = _sharedPreferences.getString('id')??'';
  //   user.email = _sharedPreferences.getString('email')??'';
  //   user.password = _sharedPreferences.getString('password')??'';
  //
  //   return user;
  // }

  bool get loggedIn =>_sharedPreferences.getBool('logged_in')??false;


  Future<bool> loggedOut()async{
    return await _sharedPreferences.clear();
  }

}