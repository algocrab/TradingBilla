
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:test_app_chat/Screens/setting_screen.dart';
import 'package:test_app_chat/group_chats/create_group/create_group.dart';

import '../group_chats/group_chat_screen.dart';
import '../model/bn_model.dart';
import 'HomeScreen.dart';
import 'SearchUsers.dart';


class AppScreen extends StatefulWidget{
  const AppScreen({Key? key}) : super(key: key);

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen>{
  late int _currentIndex = 0;
  final List<BnScreen> _bnScreen = <BnScreen>[
    BnScreen(widget: HomeScreen(), title: 'Book'),
    BnScreen(widget: GroupChatHomeScreen(), title: 'Shop'),
    BnScreen(widget: SearchUser(), title: 'Profile'),
    BnScreen(widget: SettingsScreen(), title: 'Profile'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int value) {
          setState(() {
            _currentIndex = value;
          });
        },
        currentIndex: _currentIndex,
        selectedIconTheme: IconThemeData(color: Colors.black),

        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[400],
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            activeIcon: Icon(Iconsax.home, color: Colors.black),
            label: '',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group,),
            activeIcon: Icon(Icons.group, color: Colors.black,size: 25,),
            label: '',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.user,size: 20,),
            activeIcon: Icon(Iconsax.user, color: Colors.black),
            label: '',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.setting_2),
            activeIcon: Icon(Iconsax.settings, color: Colors.black),
            label: '',
            tooltip: '',
          ),
        ],
      ),
      body: _bnScreen[_currentIndex].widget,
    );

  }


}
