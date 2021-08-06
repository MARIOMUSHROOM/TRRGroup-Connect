// // import 'package:ai_flutter/tabs/models/tab_navigation.dart';
// import 'package:ai_flutter/theme/constants.dart';
// import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:ai_flutter/chat/chat.dart';
// import 'package:ai_flutter/home/home.dart';
// import 'package:ai_flutter/notify/notify.dart';
// import 'package:ai_flutter/profile/profile.dart';
// import 'package:google_fonts/google_fonts.dart';

// // class TabsPage extends StatefulWidget {
// //   @override
// //   _TabsPageState createState() => _TabsPageState();
// // }

// // class _TabsPageState extends State<TabsPage> {
// //   int _currentIndex = 0;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: IndexedStack(
// //         index: _currentIndex,
// //         children: [
// //           for (final tabItem in TabNavigation.items) tabItem.page,
// //         ],
// //       ),
// //       bottomNavigationBar: BottomNavigationBar(
// //           currentIndex: _currentIndex,
// //           onTap: (int index) => setState(() => _currentIndex = index),
// //           items: [
// //             for (final tabItem in TabNavigation.items)
// //               BottomNavigationBarItem(
// //                 icon: tabItem.icon,
// //                 // ignore: deprecated_member_use
// //                 title: tabItem.title,
// //                 // backgroundColor: Colors.ci
// //                 backgroundColor: Color.fromRGBO(80, 45, 28, 1),
// //               )
// //           ]),
// //     );
// //   }
// // }

// class TabsPage extends StatefulWidget {
//   final titles = ['หน้าหลัก', 'แชท', 'แจ้งเตือน', 'โปรไฟล์'];
//   final colors = [Colors.red, Colors.purple, Colors.teal, Colors.cyan];

//   final icons = [
//     CupertinoIcons.home,
//     CupertinoIcons.chat_bubble,
//     CupertinoIcons.alarm,
//     CupertinoIcons.person,
//   ];

//   @override
//   _TabsPageState createState() => _TabsPageState();
// }

// class _TabsPageState extends State<TabsPage> {
//   PageController _pageController;
//   MenuPositionController _menuPositionController;
//   bool userPageDraggin = false;

//   @override
//   void initState() {
//     _menuPositionController = MenuPositionController(initPosition: 0);
//     _pageController = PageController(
//       initialPage: 0,
//       keepPage: false,
//       viewportFraction: 1.0,
//     );
//     _pageController.addListener(handlePageChange);
//     super.initState();
//   }

//   void handlePageChange() {
//     _menuPositionController.absolutePosition = _pageController.page;
//   }

//   int _tabState = -1;
//   int _selectedItem = 0;
//   int _state = 0;
//   var _pages = [HomePage(), ChatPage(), NotifyPage(), ProfilePage()];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: NotificationListener<ScrollNotification>(
//         child: _pages[_selectedItem],
//       ),
//       bottomNavigationBar: BubbledNavigationBar(
//         controller: _menuPositionController,
//         initialIndex: getState(),
//         itemMargin: EdgeInsets.symmetric(horizontal: 8.0),
//         backgroundColor: Colors.white,
//         defaultBubbleColor: kPrimaryColor,
//         onTap: (int index) => setState(() => {_selectedItem = index}),
//         items: widget.titles.map((title) {
//           var index = widget.titles.indexOf(title);
//           var color = widget.colors[index];
//           return BubbledNavigationBarItem(
//               icon: getIcon(index, color),
//               activeIcon: getIcon(index, Colors.white),
//               title: Text(
//                 title,
//                 style: GoogleFonts.kanit(
//                     fontSize: 13.0,
//                     fontWeight: FontWeight.w600,
//                     textStyle: TextStyle(color: Colors.white)),
//               ));
//         }).toList(),
//       ),
//     );
//   }

//   Padding getIcon(int index, Color color) {
//     return Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: Icon(
//           widget.icons[index],
//           size: 28.0,
//           color: color,
//         ));
//   }

//   getState() {
//     if (_selectedItem != _tabState) {
//       if (_selectedItem == 0) {
//         if (_tabState == 3) {
//           _state = 3;
//         } else {
//           _state = 2;
//         }
//       } else if (_selectedItem == 1) {
//         if (_tabState == 0) {
//           _state = 0;
//         } else {
//           _state = 2;
//         }
//       } else if (_selectedItem == 2) {
//         if (_tabState == 0) {
//           _state = 0;
//         } else if (_tabState == 1) {
//           _state = 1;
//         } else if (_tabState == 3) {
//           _state = 3;
//         } else {
//           _state = 2;
//         }
//       } else if (_selectedItem == 3) {
//         if (_tabState == 2) {
//           _state = 0;
//         } else {
//           _state = 2;
//         }
//       }
//     }

//     _tabState = _selectedItem;
//     return _state;
//   }
// }
