import 'package:ai_flutter/bloc/notify_state/bloc/notify_bloc.dart';
import 'package:ai_flutter/global_const.dart';
import 'package:ai_flutter/notify/model/local_model.dart';
import 'package:ai_flutter/notify/setting.dart';
import 'package:ai_flutter/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ai_flutter/notify/test/test_data.dart';
import 'package:intl/intl.dart';

class NotifyPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => NotifyPage(),
      );
  List<LocalNotificationModel> localNotifyListNew = new List();
  List<LocalNotificationModel> localNotifyListOld = new List();

  Widget widgetToday = SizedBox();
  Widget widgetLast = SizedBox();
  Widget widgetLoading = SizedBox();

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: true);
    widgetToday = SizedBox();
    widgetLast = SizedBox();
    await Future.delayed(Duration(seconds: 2));
    _notifyBloc.add(LoadNotifyInitial());
    print("refresh");
    return null;
  }

  bool hasMore;
  ScrollController controller;
  // @override
  // void initState() {
  //   super.initState();

  // }

  // @override
  // void dispose() {
  //   controller.removeListener(_scrollListener);
  //   super.dispose();
  // }
  int notifyCount = 0;

  double _height;
  double _width;
  NotifyBloc _notifyBloc;
  @override
  Widget build(BuildContext context) {
    _notifyBloc = BlocProvider.of<NotifyBloc>(context);
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return BlocBuilder<NotifyBloc, NotifyState>(
      builder: (context, state) {
        controller = new ScrollController()..addListener(_scrollListener);
        if (state is NotifyInitial) {
          widgetLoading = Center(
            child: Container(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(),
            ),
          );
          _notifyBloc.add(LoadNotifyInitial());
        } else if (state is NotifyNoData) {
          widgetLoading = Center(child: Text("ไม่มีข้อมูล"));
        } else if (state is NotifyLoading) {
          hasMore = false;
          widgetLoading = Center(
            child: Container(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is NotifyError) {
          widgetLoading = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ไม่สามารถทำรายการได้ กรุณาลองใหม่อีกครั้ง : ",
                  maxLines: 10,
                ),
                FlatButton(
                  onPressed: () {
                    _notifyBloc.add(LoadNotifyInitial());
                  },
                  color: Colors.grey,
                  child: Text("โหลดอีกครั้ง"),
                ),
              ],
            ),
          );
        } else if (state is NotifyLoaded) {
          hasMore = _notifyBloc.hasMore;
          localNotifyListNew = _notifyBloc.localNotificationModelListToday;
          localNotifyListOld = _notifyBloc.localNotificationModelListLast;
          widgetLoading = SizedBox();
          widgetToday = ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: localNotifyListNew.length,
            padding: EdgeInsets.all(1),
            itemBuilder: (context, index) {
              LocalNotificationModel only = localNotifyListNew[index];
              return GestureDetector(
                onTap: () {
                  notificationClick(context, only);
                  // print("click read");
                  // _notifyBloc.add(ReadNotify(only));
                  // var route =
                  //     MaterialPageRoute(builder: (context) => only.routeName);
                  // Navigator.push(context, route);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: Container(
                    // height: 90,
                    width: _width,
                    constraints: BoxConstraints(minHeight: 90),
                    decoration: BoxDecoration(
                      color: only.read ? Colors.white : Colors.blue[50],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(1, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: new BoxDecoration(
                                  color: kGoldColor,
                                  // image: new DecorationImage(
                                  //   image: new ExactAssetImage(
                                  //       'assets/images/cards/pastel_card_01.jpg'),
                                  //   fit: BoxFit.cover,
                                  // ),
                                  shape: BoxShape.circle,
                                ),
                                child: only.image == null
                                    ? Icon(
                                        Icons.image_outlined,
                                        size: 50,
                                        color: Colors.white,
                                      )
                                    : Image.asset("${only.image}"),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    only.message,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    only.date.toString(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
          widgetLast = ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: localNotifyListOld.length,
            padding: EdgeInsets.all(1),
            itemBuilder: (context, index) {
              LocalNotificationModel only = localNotifyListOld[index];
              return GestureDetector(
                onTap: () {
                  notificationClick(context, only);
                  // print("click read");
                  // _notifyBloc.add(ReadNotify(only));
                  // var route =
                  //     MaterialPageRoute(builder: (context) => only.routeName);
                  // Navigator.push(context, route);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: Container(
                    // height: 90,
                    width: _width,
                    constraints: BoxConstraints(minHeight: 90),
                    decoration: BoxDecoration(
                      color: only.read ? Colors.white : Colors.blue[50],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(1, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: new BoxDecoration(
                                  color: kGoldColor,
                                  // image: new DecorationImage(
                                  //   image: new ExactAssetImage(
                                  //       'assets/images/cards/pastel_card_01.jpg'),
                                  //   fit: BoxFit.cover,
                                  // ),
                                  shape: BoxShape.circle,
                                ),
                                child: only.image == null
                                    ? Icon(
                                        Icons.image_outlined,
                                        size: 50,
                                        color: Colors.white,
                                      )
                                    : Image.asset("${only.image}"),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    only.message,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    only.date.toString(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "แจ้งเตือน",
              style: GoogleFonts.kanit(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
            backgroundColor: kContentColorLightTheme,
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingNotifyPage()));
                },
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
            ],
            // backgroundColor: kPrimaryColor,
          ),
          body: RefreshIndicator(
            key: refreshKey,
            onRefresh: refreshList,
            child: SingleChildScrollView(
              controller: controller,
              child: Container(
                color: kPageBackgroundColor,
                constraints: BoxConstraints(minHeight: _height),
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // BlocListener<NotifyBloc, NotifyState>(
                    //   listener: (context, state) {
                    //     if (state is NotifyCount) {
                    //       notifyCount = _notifyBloc.countUnRead;
                    //     }
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 8.0),
                    //     child: Text(
                    //       notifyCount.toString(),
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "ใหม่",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    widgetToday,
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "ก่อนหน้านี้",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    widgetLast,
                    widgetLoading,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  notificationClick(BuildContext context, LocalNotificationModel only) {
    _notifyBloc.add(ReadNotify(only.notificatioID));
    if (only.routeName != null) {
      var route = MaterialPageRoute(builder: (context) => only.routeName);
      Navigator.push(context, route);
    }
  }

  Future<void> _scrollListener() async {
    // print(controller.position.extentAfter);
    // print(_scanBloc.pageLimit);
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if (hasMore) {
        print("scroll max");
        _notifyBloc.add(LoadMoreNotify());
      }
    }
  }
}
