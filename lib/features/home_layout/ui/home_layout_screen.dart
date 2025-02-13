import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/utils/assets_app.dart';
import 'package:student_portal/features/home_layout/ui/widgets/drawer.dart';
import 'package:student_portal/features/home_layout/ui/widgets/nav_bar.dart';

import '../../home/presentation/view/home_screen.dart';
import '../../home/presentation/view/widgets/app_bar_home.dart';

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
  bool isMenuOpen = false;

  void _onItemTapped(int index) {
    log("index $index");
    setState(() {
      currentIndex = index;
    });
  }

  void toggleShowPopMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
    HomeScreen(),
    SizedBox.shrink(),
    HomeScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      backgroundColor: ColorsManager.backgroundColor,
      body: widgetOptions[currentIndex],
      drawer: AppDrawer(),
      bottomNavigationBar: CustomNavBar(
        isMenuOpen: isMenuOpen,
        selectedItemColor: ColorsManager.mainColorLight,
        floatingOnTap: () {
          toggleShowPopMenu();
          _showPopupMenu(context, Offset(0.66.sw, 0.66.sh));
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
      NavBarButtonItem(iconPath: AssetsApp.eventIcon, title: "Events"),
      NavBarButtonItem(iconPath: 'add', title: "Add"),
      NavBarButtonItem(iconPath: AssetsApp.resourcesIcon, title: "Resources"),
      NavBarButtonItem(iconPath: AssetsApp.chatIcon, title: "Chat"),
    ];
  }

  void _showPopupMenu(BuildContext context, Offset position) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    await showMenu(
      color: Colors.white,
      context: context,
      position: RelativeRect.fromRect(
        position & Size(50.w, 50.h), // Position of tap
        Offset.zero & overlay.size, // Full screen
      ),
      items: [
        PopupMenuItem<String>(
          value: 'write_post',
          child: Text('Write a Post', style: Styles.font16w500),
          onTap: () {},
        ),
        PopupMenuItem<String>(
          value: 'create_community',
          child: Text('Create a Community', style: Styles.font16w500),
          onTap: () {},
        ),
        PopupMenuItem<String>(
          value: 'upload_resource',
          child: Text('Upload a Resource', style: Styles.font16w500),
          onTap: () {},
        ),
      ],
    ).then((value) => toggleShowPopMenu());
  }
}
