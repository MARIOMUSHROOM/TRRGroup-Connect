import 'dart:convert';

import 'package:ai_flutter/provider/api_provider.dart';
import 'package:http/http.dart' as http;

class NotificationAPI extends ApiProvider {
  NotificationAPI();

  getNotificationList(var startOffset, var lastOffset) async {
    String _url = '$endPoint/notification/1/$startOffset/$lastOffset';
    print(_url);
    return http.get(Uri.parse(_url), headers: headers);
  }

  updateNotificatioRead(var notificationId) async {
    String _url = '$endPoint/notification/$notificationId';
    print(_url);
    return http.post(Uri.parse(_url), headers: headers);
  }
}
