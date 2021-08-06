import 'dart:async';
import 'dart:convert';

import 'package:ai_flutter/bloc/notify_state/function/check_null.dart';
import 'package:ai_flutter/home/activity/type_page.dart';
import 'package:ai_flutter/home/home.dart';
import 'package:ai_flutter/home/income_expense/income_expense_tab_page.dart';
import 'package:ai_flutter/home/queue/pages/queue_home_page.dart';
import 'package:ai_flutter/home/report/pages/report_plot_list_page.dart';
import 'package:ai_flutter/home/test_bloc/test_bloc_page.dart';
import 'package:ai_flutter/nav_page.dart';
import 'package:ai_flutter/notify/model/fcm_notification_model.dart';
import 'package:ai_flutter/notify/model/local_model.dart';
import 'package:ai_flutter/notify/model/notification_list_model.dart';
import 'package:ai_flutter/provider/notification_api.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'notify_event.dart';
part 'notify_state.dart';

class NotifyBloc extends Bloc<NotifyEvent, NotifyState> {
  NotifyBloc() : super(NotifyInitial());
  List<LocalNotificationModel> localNotificationModelListAll = [];
  List<LocalNotificationModel> localNotificationModelListToday = [];
  List<LocalNotificationModel> localNotificationModelListLast = [];
  FcmNotification fcmNotification;
  NotificationListModel notificationListModel;
  int offset;
  int takeData;
  bool hasMore;

  int countUnRead = 0;
  @override
  Stream<NotifyState> mapEventToState(
    NotifyEvent event,
  ) async* {
    if (event is LoadNotifyInitial) {
      localNotificationModelListAll = new List();
      localNotificationModelListToday = new List();
      localNotificationModelListLast = new List();
      hasMore = true;
      offset = 0;
      takeData = 5;
      //save count in local
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int countInStore = prefs.getInt('notification_count');
      if (countInStore == null || countInStore == 0) {
        countUnRead = 0;
      } else {
        countUnRead = countInStore;
      }
      //close
      yield* _connectAPI();
      // yield NotifyLoaded();
    } else if (event is LoadMoreNotify) {
      offset += 5;
      // lastOffset += 5;
      yield* _connectAPI();
    } else if (event is ReadNotify) {
      print("in bloc _mapNotificationModel");
      await NotificationAPI().updateNotificatioRead(event.notificationId);
      localNotificationModelListAll = new List();
      localNotificationModelListToday = new List();
      localNotificationModelListLast = new List();
      hasMore = true;
      offset = 0;
      takeData = 5;
      yield* _connectAPI();
    } else if (event is CountNewNotify) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int countInStore = prefs.getInt('notification_count');
      if (countInStore == null || countInStore == 0) {
        countUnRead++;
        await prefs.setInt('notification_count', countUnRead);
      } else {
        countUnRead++;
        await prefs.setInt('notification_count', countUnRead);
      }
      print(countUnRead);
      yield NotifyLoaded();
      // yield NotifyCount();
    } else if (event is CountClearNotify) {
      countUnRead = 0;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('notification_count', 0);
      print(countUnRead);
      yield NotifyLoaded();
      // yield NotifyCount();
    }
  }

  Stream<NotifyState> _connectAPI() async* {
    print("in _connectAPI");
    yield NotifyLoading();
    try {
      print("in _connectAPI");
      var rs = await NotificationAPI().getNotificationList(offset, takeData);
      print("rs");
      print(rs);
      var jsonRes = json.decode(rs.body);
      print(jsonRes);
      if (jsonRes['success']) {
        notificationListModel = NotificationListModel.fromJson(jsonRes);
        if (notificationListModel.data.notification.isNotEmpty && hasMore) {
          // localNotificationModelListAll = [];
          print(notificationListModel.data.notification.length);
          for (var i = 0;
              i < notificationListModel.data.notification.length;
              i++) {
            LocalNotificationModel only = new LocalNotificationModel();
            only.message = notificationListModel.data.notification[i].title;
            var checkType = await setImageWithNotificationType(
                notificationListModel.data.notification[i].idTypeNotification
                    .toString());
            only.notificatioID =
                notificationListModel.data.notification[i].idNotification;
            only.image = checkType['imagePath'];
            only.routeName = checkType['route'];
            only.date = notificationListModel.data.notification[i].createdAt;
            only.read = notificationListModel.data.notification[i].status == 1
                ? false
                : true;
            print("in for");
            Duration difference = DateTime.now().difference(only.date);
            print(difference.inDays == 0);
            print(difference.inDays);
            if (difference.inDays == 0) {
              localNotificationModelListToday.add(only);
            } else {
              localNotificationModelListLast.add(only);
            }
            print(localNotificationModelListToday);
            print(localNotificationModelListLast);
            // localNotificationModelListAll.add(only);
          }
          hasMore = notificationListModel.data.hasMore;
          await Future.delayed(Duration(seconds: 2));
          yield NotifyLoaded();
        } else {
          yield NotifyNoData();
        }
      } else {
        yield NotifyNoData();
      }
    } catch (e) {
      print("error :");
      print(e);
      yield NotifyError(e.toString());
    }
  }

  Map<String, dynamic> setImageWithNotificationType(String type) {
    String imageAssetPath = "";
    var routePath;
    switch (type) {
      case "1":
      case "Activity":
      case "activity":
        imageAssetPath = "assets/images/notification/Artboard_103.png";
        routePath = ReportPlotListPage();
        break;
      case "2":
      case "SugarcaneQueue":
      case "sugarcanequeue":
        imageAssetPath = "assets/images/notification/Artboard_107.png";
        routePath = QueueHomePage();
        break;
      case "3":
      case "Income":
      case "income":
        imageAssetPath = "assets/images/notification/Artboard_115.png";
        routePath = IncomeExpenseTabPage();
        break;
      case "4":
      case "ContractorWeight":
      case "contractorweight":
        imageAssetPath = "assets/images/notification/Artboard_109.png";
        routePath = QueueHomePage();
        break;
      case "5":
      case "Radio":
      case "radio":
        imageAssetPath = "assets/images/notification/Artboard_116.png";
        routePath = null;
        break;
      case "6":
      case "Journal":
      case "journal":
        imageAssetPath = "assets/images/notification/Artboard_105.png";
        routePath = TestBlocPage();
        break;
      case "7":
      case "New":
      case "new":
        imageAssetPath = "assets/images/notification/Artboard_105.png";
        routePath = null;
        break;
      case "8":
      case "SugarcanePrice":
      case "sugarcanePrice":
        imageAssetPath = "assets/images/notification/Artboard_115.png";
        routePath = IncomeExpenseTabPage();
        break;
      default:
        imageAssetPath = "assets/images/notification/Artboard_116.png";
        routePath = null;
        break;
    }
    var data = {"imagePath": imageAssetPath, "route": routePath};
    return data;
  }
}
