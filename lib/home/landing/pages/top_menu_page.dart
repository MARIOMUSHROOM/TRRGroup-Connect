// import 'package:flutter/material.dart';
// import '../../../basic/pages/trr_basic_page.dart';
// import './trr_home_page.dart';
// import '../../../basic/models/trr_object.dart';
// import '../home_const.dart' as homeCons;

// class TopMenuPage extends TrrBasicPageStatefulWidget {
//   @override
//   _TopMenuPageState createState() => _TopMenuPageState();
// }

// class _TopMenuPageState extends TrrBasicPageStatefulWidgetState<TopMenuPage> {
//   int currentPageIndex = 0;
//   List<Widget> pageList = [];
//   TrrData dummyData = TrrData();

//   @override
//   void initState() {
//     super.initState();
//     for (var i = 0; i <= 4; i++) pageList.add(TrrHomePage(dataObj: dummyData));
//   }

//   @override
//   Widget internalBuild(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: IndexedStack(
//           index: currentPageIndex,
//           children: pageList,
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           backgroundColor: Colors.white,
//           type: BottomNavigationBarType.fixed,
//           currentIndex: this.currentPageIndex,
//           items: [
//             for (var i in pageList)
//               BottomNavigationBarItem(
//                   activeIcon: Icon(Icons.home, color: homeCons.kSolidBlueColor, size: 32),
//                   icon: Icon(Icons.home, color: Colors.grey, size: 32),
//                   label: '$i'),
//           ],
//           onTap: (index) => setState(() => this.currentPageIndex = index),
//         ),
//       ),
//     );
//   }
// }
