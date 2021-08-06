import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ai_flutter/bloc/notify_state/bloc/notify_bloc.dart';
import 'package:ai_flutter/bloc/report_state/report_list/bloc/report_list_bloc.dart';
import 'package:ai_flutter/loan/loan_page.dart';
import 'package:ai_flutter/notify/model/fcm_notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './user/models/trr_user_model.dart';
import './global_const.dart' as cons;
import './base_class/models/ai_base_model.dart';
import './home/landing/pages/trr_home_page.dart';
import './money/money_page.dart';
import './chat/chat_page.dart';
import './notify/notify.dart';
import './profile/profile_page.dart';
import 'basic/models/trr_object.dart';
import 'home/activity/type_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import './test_nav_bloc/test_chat_notification_bloc/bloc/test_chat_notification_bloc.dart';
import './test_nav_bloc/test_notification_bloc/bloc/test_notification_bloc.dart';

const kHomeCaption = 'หน้าหลัก';
const kBalanceCaption = 'วงเงินสินเชื่อ';
const kBalanceSelectedImage = 'assets/images/landing/balance_select.png';
const kBalanceImage = 'assets/images/landing/balance.png';
const kChatCaption = 'แชท';
const kNotifyCaption = 'แจ้งเตือน';
const kProfileCaption = 'โปรไฟล์';

class NavMenuItem extends AiBasicItem {
  GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navKey => _navKey;
  Widget icon;
  String label;
  Widget viewPage;
  Widget activeIcon;

  NavMenuItem(this.icon, this.label, this.viewPage, [this.activeIcon]);

  NavMenuList _navMenuOwnerList;
  // assign owner to item
  NavMenuList get ownerList => _navMenuOwnerList;
  set ownerList(value) => _navMenuOwnerList = value;
  // customize getting normal icon
  @protected
  Widget internalGetNormalIcon() => this.icon;
  Widget get normalIcon => internalGetNormalIcon();
  // customize getting selected icon
  @protected
  Widget internalGetSelectedIcon() =>
      this.activeIcon == null ? this.icon : this.activeIcon;
  Widget get selectedIcon => internalGetSelectedIcon();
}

//======================================================================================
class NavChatMenuItem extends NavMenuItem {
  Widget get activeIcon => super.activeIcon;
  set activeIcon(aValue) => super.activeIcon = aValue;

  NavChatMenuItem(Widget icon, String label, Widget viewPage,
      [Widget activeIcon])
      : super(icon, label, viewPage, activeIcon);

  @protected
  Widget alertBadge(int aAlertCount) {
    String alertLabel = '';
    alertLabel = (aAlertCount > 0) ? '$aAlertCount' : '';
    alertLabel = (aAlertCount > 99) ? '99+' : '$aAlertCount';
    return Positioned(
      right: 0,
      top: 0,
      child: Container(
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.transparent),
          color: (aAlertCount > 0) ? Colors.red : null,
        ),
        constraints: BoxConstraints(minWidth: 18, minHeight: 18),
        child: Text(
          aAlertCount > 0 ? alertLabel : '',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget internalGetNormalIcon() {
    Widget result = super.internalGetNormalIcon();
    if (this.ownerList != null) {
      result = Stack(
        children: [
          this.icon,
          // alert by chat notificaiton count
          alertBadge(this.ownerList.chatAlertCount),
        ],
      );
    }
    return result;
  }
}

//======================================================================================
class NavNotifyMenuItem extends NavChatMenuItem {
  NavNotifyMenuItem(Widget icon, String label, Widget viewPage,
      [Widget activeIcon])
      : super(icon, label, viewPage, activeIcon);

  @override
  Widget internalGetNormalIcon() {
    Widget result = super.internalGetNormalIcon();
    if (this.ownerList != null) {
      result = Stack(
        children: [
          this.icon,
          // alert by notification count
          alertBadge(this.ownerList.notificationCount),
        ],
      );
    }
    return result;
  }
}

//======================================================================================
class NavMenuList extends AiBasicList {
  final TrrData globalTrrDataObj = TrrData.instance;

  @override
  List<AiBaseItem> getObjList() => <NavMenuItem>[];
  List<NavMenuItem> get menuItems => super.items;

  int chatAlertCount = 0;
  int notificationCount = 0;

  void updateChatCount(int aChatAlertCount) => chatAlertCount = aChatAlertCount;
  void updateNotificationCount(int aNotificationCount) =>
      this.notificationCount = aNotificationCount;

  // add normal menu item
  @protected
  addMenu(Widget aIconWidget, String aLabel, Widget aViewPage,
          {Widget aActiveIcon}) =>
      menuItems.add(NavMenuItem(aIconWidget, aLabel, aViewPage,
          (aActiveIcon != null) ? aActiveIcon : null)
        ..ownerList = this);

  // add chat notification alertable menu item
  @protected
  addChatMenu(Widget aIconWidget, String aLabel, Widget aViewPage,
      {Widget aActiveIcon}) {
    menuItems.add(NavChatMenuItem(aIconWidget, aLabel, aViewPage,
        (aActiveIcon != null) ? aActiveIcon : null)
      ..ownerList = this);
  }

  // add notification aleratble menu item
  @protected
  addNotificationMenu(Widget aIconWidget, String aLabel, Widget aViewPage,
      {Widget aActiveIcon}) {
    menuItems.add(NavNotifyMenuItem(aIconWidget, aLabel, aViewPage,
        (aActiveIcon != null) ? aActiveIcon : null)
      ..ownerList = this);
  }

  @protected
  void initMenu() => internalPrepareMenu();

  @protected
  void internalPrepareMenu() {
    addMenu(Icon(CupertinoIcons.house_fill), kHomeCaption,
        TrrHomePage(dataObj: globalTrrDataObj));
    addMenu(
        Image(image: AssetImage(kBalanceImage)), kBalanceCaption, LoanPage(),
        aActiveIcon: Image(image: AssetImage(kBalanceSelectedImage)));
    addChatMenu(
        Icon(Icons.chat_bubble_outline_rounded), kChatCaption, ChatPage());
    addNotificationMenu(
        Icon(CupertinoIcons.bell), kNotifyCaption, NotifyPage());
    addMenu(Icon(CupertinoIcons.person_crop_rectangle), kProfileCaption,
        UserProfilePage(dataObj: globalTrrDataObj));
  }

  static final NavMenuList instance = NavMenuList()..initMenu();
}

//======================================================================================
class GuestNavMenuList extends NavMenuList {
  @override
  void internalPrepareMenu() {
    addMenu(Icon(CupertinoIcons.house_fill), kHomeCaption,
        TrrHomePage(dataObj: globalTrrDataObj));
    addChatMenu(
        Icon(Icons.chat_bubble_outline_rounded), kChatCaption, ChatPage());
    addMenu(Icon(CupertinoIcons.person_crop_rectangle), kProfileCaption,
        UserProfilePage(dataObj: globalTrrDataObj));
  }

  static final GuestNavMenuList instance = GuestNavMenuList()..initMenu();
}

//======================================================================================
class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  // final mainMenu = NavMenuList.instance;
  final TrrData globalTrrDataObj = TrrData.instance;
  NavMenuList mainMenu;

  CupertinoTabController tabController;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  initialFCM() {
    BlocProvider.of<NotifyBloc>(context).add(LoadNotifyInitial());
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      // _showNotifications(
      //     1, message.notification.title, message.notification.body);
      showNotification(
          1, message.notification.title, message.notification.body);
      print(message.notification);
      print(message.data);
      if (Platform.isIOS) {
      } else {
        Data fcmData = Data.fromJson(message.data);
        // showNotification();
        FcmNotification fcmNotification = new FcmNotification();
        fcmNotification.data = fcmData;
        // await notificationTextTypeChannel(
        //     context, fcmNotification.data.notificationTextType);
        BlocProvider.of<NotifyBloc>(context).add(CountNewNotify());
        // BlocProvider.of<NotifyBloc>(context).add(LoadNotifyInitial());
        // BlocProvider.of<NotifyBloc>(context)
        //     .add(NewNotifyFromFCM(fcmNotification));
        // TestChatNotificationBloc chatBloc =
        //     BlocProvider.of<TestChatNotificationBloc>(context);
        // chatBloc.add(TestChatNotificationSendMessageEvent());
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new onMessageOpenedApp event was published!');
      Data fcmData = Data.fromJson(message.data);
      // showNotification();
      FcmNotification fcmNotification = new FcmNotification();
      fcmNotification.data = fcmData;
      await notificationTextTypeChannel(
          context, fcmNotification.data.notificationTextType);
      BlocProvider.of<NotifyBloc>(context).add(CountNewNotify());
      // BlocProvider.of<NotifyBloc>(context).add(LoadNotifyInitial());
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });
  }

  Future<void> _showNotifications(int id, String title, String content) async {
    // await notification(id,title,content);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      '$id',
      'channelName',
      'channelDescription',
      priority: Priority.high,
      importance: Importance.max,
      // ticker: 'test',
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      '$title',
      '$content',
      notificationDetails,
    );
  }

  void showNotification(var id, String title, String body) {
    flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name, channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
  void initState() {
    super.initState();
    switch (globalTrrDataObj.userDataObj.userType) {
      case TrrUserType.Guest:
        mainMenu = GuestNavMenuList.instance;
        break;
      default:
        mainMenu = NavMenuList.instance;
    }
    initialFCM();
    tabController = CupertinoTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    TestChatNotificationBloc chatAlertBloc =
        BlocProvider.of<TestChatNotificationBloc>(context);
    // TestNotificationBloc notifyBloc =
    //     BlocProvider.of<TestNotificationBloc>(context);
    NotifyBloc notifyBloc = BlocProvider.of<NotifyBloc>(context);

    return WillPopScope(
      onWillPop: () async {
        return !await mainMenu
            .menuItems[tabController.index].navKey.currentState
            .maybePop();
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<TestChatNotificationBloc, TestChatNotificationState>(
              listener: (context, chatState) {
            if (chatState is TestChatNotificationUpdateState)
              mainMenu.updateChatCount(chatAlertBloc.messageCount);
          }),
          BlocListener<NotifyBloc, NotifyState>(
              listener: (context, notifyState) {
            if (notifyState is NotifyCount || notifyState is NotifyLoaded) {
              mainMenu.notificationCount = notifyBloc.countUnRead;
              // mainMenu.updateNotificationCount(notifyBloc.countUnRead);
              print("in here");
            }
          }),
          // BlocListener<TestNotificationBloc, TestNotificationState>(
          //     listener: (context, notifyState) {
          //   if (notifyState is TestNotificationUpdateState)
          //     mainMenu.updateNotificationCount(notifyBloc.notifyCount);
          // }),
        ],
        child: BlocBuilder<TestChatNotificationBloc, TestChatNotificationState>(
          builder: (context, chatState) {
            return BlocBuilder<NotifyBloc, NotifyState>(
              builder: (context, state) {
                return CupertinoTabScaffold(
                  controller: tabController,
                  tabBar: CupertinoTabBar(
                    items: [
                      for (var navItem in mainMenu.menuItems)
                        BottomNavigationBarItem(
                          icon: navItem.normalIcon,
                          activeIcon: navItem.selectedIcon,
                          label: navItem.label,
                        ),
                    ],
                    onTap: (index) {
                      NavMenuItem navItem = mainMenu.menuItems.elementAt(index);
                      if (navItem.runtimeType == NavChatMenuItem) {
                        // Reset count to Chat Notification Bloc
                        chatAlertBloc
                            .add(TestChatNotificationClearAlertCount());
                      } else if (navItem.runtimeType == NavNotifyMenuItem) {
                        // Reset count to Notificaiton Bloc
                        notifyBloc.add(CountClearNotify());
                      }
                    },
                    activeColor: cons.kBlueColor,
                    inactiveColor: Colors.grey,
                  ),
                  tabBuilder: (BuildContext context, int index) {
                    return SafeArea(
                      child: CupertinoTabView(
                        navigatorKey: mainMenu.menuItems[index].navKey,
                        builder: (BuildContext context) =>
                            mainMenu.menuItems[index].viewPage,
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

notificationTextTypeChannel(BuildContext context, String textType) {
  switch (textType) {
    case "Activity":
    case "activity":
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => TypePage()));
      // BlocProvider.of<ReportListBloc>(context).add(LoadReportListInitial());
      break;
    case "SugarcaneQueue":
    case "sugarcanequeue":
      break;
    case "Income":
    case "income":
      break;
    case "ContractorWeight":
    case "contractorweight":
      break;
    case "Radio":
    case "radio":
      break;
    case "Journal":
    case "journal":
      break;
    case "New":
    case "new":
      break;
    case "SugarcanePrice":
    case "sugarcaneprice":
      break;
    case "Chat":
    case "chat":
      break;
    default:
  }
}
