import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/utils/app_router.dart';
import 'package:student_portal/core/utils/assets_app.dart';
import 'package:student_portal/features/home/presentation/manager/discussion_bloc/discussion_bloc.dart';
import 'package:student_portal/features/home_layout/ui/widgets/drawer.dart';
import 'package:student_portal/features/home_layout/ui/widgets/nav_bar.dart';
import 'package:student_portal/features/resource/presentation/manager/get_resource_bloc/get_resource_bloc.dart';
import '../../../core/utils/socket_service.dart';
import '../../chats/presentation/manager/chats_bloc/chats_bloc.dart';
import '../../chats/presentation/pages/chats_screen.dart';
import '../../events/presentation/manager/events_bloc/events_bloc.dart';
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
    _initializeSocket();
  }

  Future<void> _initializeSocket() async {
    await SocketService.init();
    _listenToSocketEvents();
  }

  void _listenToSocketEvents() {
    SocketService.socket.on('newMessage', (data) {
      debugPrint('newMessage: $data');
    });

    SocketService.socket.on('friendRequestReceived', (data) {
      debugPrint('friendRequestReceived: $data');
    });

    SocketService.socket.on('friendRequestAccepted', (data) {
      debugPrint('friendRequestAccepted: $data');
    });

    SocketService.socket.on('friendRequestSent', (data) {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<DiscussionBloc>(create: (_) => DiscussionBloc()..add(DiscussionRequested())),
        BlocProvider<EventsBloc>(create: (_) => EventsBloc()..add(EventsRequested())),
        BlocProvider<GetResourceBloc>(create: (_) => GetResourceBloc()..add(GetResourceEventRequested())),
        BlocProvider<ChatsBloc>(create: (context) => ChatsBloc()..add(StartListeningToConversations())),
      ],
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
