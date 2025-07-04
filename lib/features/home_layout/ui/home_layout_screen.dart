import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/custom_toast.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/utils/app_router.dart';
import 'package:student_portal/core/utils/assets_app.dart';
import 'package:student_portal/features/home_layout/ui/widgets/drawer.dart';
import 'package:student_portal/features/home_layout/ui/widgets/nav_bar.dart';
import '../../../core/errors/data/model/socket_failure.dart';
import '../../../core/helpers/notification/firebase_notification.dart';
import '../../../core/utils/socket_service.dart';
import '../../chats/presentation/manager/chats_bloc/chats_bloc.dart';
import '../../chats/presentation/pages/chats_screen.dart';
import '../../events/presentation/pages/events_screen.dart';
import '../../home/presentation/pages/home_screen.dart';
import '../../home/presentation/widgets/app_bar_home.dart';
import '../../resource/presentation/pages/resources_screen.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({super.key});

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {

  @override
  void initState() {
    super.initState();
    FirebaseManager.saveToken();
    _initializeSocket();
  }

  Future<void> _initializeSocket() async {
    try {
      await SocketService.init();
      SocketService.socket.onReconnect(
        (data) {
          if (data != null) {
            context.read<ChatsBloc>().add(StartListeningToConversations());
            _listenToSocketEvents();
          }
        },
      );
      _listenToSocketEvents();
    } on SocketFailure catch (e) {
      log("Socket failure: ${e.message}");
      context.showErrorToast(message: e.message);
    } catch (e) {
      log("Unexpected error: $e");
      context.showErrorToast(message: "Unexpected error: ");
    }
  }

  void _listenToSocketEvents() {
    final socket = SocketService.socket;

    socket.off('newMessage');
    socket.off('friendRequestReceived');
    socket.off('friendRequestAccepted');
    socket.off('friendRequestSent');

    socket.on('newMessage', (data) {
      debugPrint('newMessage: $data');
    });

    socket.on('friendRequestReceived', (data) {
      debugPrint('friendRequestReceived: $data');
    });

    socket.on('friendRequestAccepted', (data) {
      debugPrint('friendRequestAccepted: $data');
    });

    socket.on('friendRequestSent', (data) {
      debugPrint('friendRequestSent: $data');
    });
  }

  int currentIndex = 0;
  bool isMenuOpen = false;

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void toggleShowPopMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  static List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
    EventsScreen(),
    SizedBox.shrink(),
    ResourcesScreen(),
    ChatsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if(!didPop){
          if(currentIndex != 0){
            _onItemTapped(0);
          }
        }
      },
      child: Scaffold(
        appBar: (currentIndex != 4) ? HomeAppBar() : null,
        // disappear appbar in chat screen
        backgroundColor: (currentIndex != 4)
            ? ColorsManager.backgroundColorLight2
            : Colors.white,
        body: widgetOptions[currentIndex],
        drawer: AppDrawer(),
        bottomNavigationBar: CustomNavBar(
          isMenuOpen: isMenuOpen,
          selectedItemColor: ColorsManager.mainColorLight,
          floatingOnTap: () {
            toggleShowPopMenu();
            _showPopupMenu(context, Offset(0.66.sw, .735.sh));
          },
          unselectedItemColor: ColorsManager.mainColorDark,
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          itemPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          items: _buildNavBarItems(),
        ),
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
      color: Colors.black54.withValues(alpha: 0.45),
      context: context,
      position: RelativeRect.fromRect(
        position & Size(70.w, 50.h), // Position of tap
        Offset.zero & overlay.size, // Full screen
      ),
      items: [
        PopupMenuItem<String>(
          value: "write_post",
          child: Row(
            children: [
              CircleAvatar(
                  radius: 15.r,
                  backgroundColor: ColorsManager.whiteColor,
                  child: Icon(
                    Icons.edit,
                    color: ColorsManager.mainColor,
                    size: 18.r,
                  )),
              10.widthBox,
              Text("Write a Post",
                  style: Styles.font16w500.copyWith(color: Colors.white)),
            ],
          ),
          onTap: () => AppRouter.router.push(AppRouter.addPost),
        ),
        PopupMenuItem<String>(
          value: "create_community",
          onTap: () => AppRouter.router.push(AppRouter.createGroup),
          child: Row(
            children: [
              CircleAvatar(
                  radius: 15.r,
                  backgroundColor: ColorsManager.whiteColor,
                  child: Icon(
                    Icons.people_alt_rounded,
                    color: ColorsManager.mainColor,
                    size: 18.r,
                  )),
              10.widthBox,
              Text("Create a Group", style: Styles.font16w500.copyWith(color: Colors.white)),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: "upload_resource",
          child: Row(
            children: [
              CircleAvatar(
                  radius: 15.r,
                  backgroundColor: ColorsManager.whiteColor,
                  child: Icon(
                    Icons.local_offer,
                    color: ColorsManager.mainColor,
                    size: 18.r,
                  )),
              10.widthBox,
              Text("Upload a Resource",
                  style: Styles.font16w500.copyWith(color: Colors.white)),
            ],
          ),
          onTap: () => AppRouter.router.push(AppRouter.addResource),
        ),
      ],
    ).then((value) => toggleShowPopMenu());
  }
}
