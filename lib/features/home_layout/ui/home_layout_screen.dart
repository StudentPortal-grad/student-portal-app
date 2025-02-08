import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/utils/assets_app.dart';
import 'package:student_portal/features/home_layout/ui/widgets/nav_bar.dart';

import '../../home/presentation/view/home_screen.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({super.key});

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
  // @override
  // void initState() {
  //   FirebaseManager.saveToken();
  //   SocketService.emit('updateSocketId', message: {'token': 'Test_${AuthRepository.accessToken}'});
  //   super.initState();
  // }

  int currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColor,
      body: widgetOptions[currentIndex],
      bottomNavigationBar: CustomNavBar(
        selectedItemColor: ColorsManager.mainColorLight,
        floatingOnTap: () {
        },
        unselectedItemColor: ColorsManager.mainColorDark,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        itemPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        items: _buildNavBarItems(),
      ),
    );
  }

  static List<NavBarButtonItem> _buildNavBarItems() {
    return [
      NavBarButtonItem(iconPath: AssetsApp.homeIcon, title: "Home"),
      NavBarButtonItem(
        iconPath: AssetsApp.eventIcon,
        title: "Events",
      ),
      NavBarButtonItem(
        iconPath: 'add',
        title: "Add",
      ),
      NavBarButtonItem(
        iconPath: AssetsApp.resourcesIcon,
        title: "Resources",
      ),
      NavBarButtonItem(
        iconPath: AssetsApp.chatIcon,
        title: "Chat",
      ),
    ];
  }
}
