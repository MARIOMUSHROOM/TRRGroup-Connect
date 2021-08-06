import 'dart:convert';
import 'dart:io';

import 'package:ai_flutter/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatAPI extends ApiProvider {
  ChatAPI();

  getChatList() async {
    String _url = '$endPoint/chat/444';
    return http.get(Uri.parse(_url), headers: headers);
  }

  sendMessage(var message) async {
    String _url = '$endPoint/chat/send-message';
    var body = json.encode({
      "user_id": "444",
      "name": "เทส",
      "message": message,
    });
    return http.post(Uri.parse(_url), headers: headers, body: body);
  }

  sendImageMessage({@required File imagePath}) async {
    String _url = '$endPoint/chat/send-image';
    // var body = json.encode({
    //   "user_id": "444",
    //   "name": "เทส",
    //   "message": message,
    // });
    // return http.post(Uri.parse(_url), headers: headers, body: body);

    var request = http.MultipartRequest('POST',
        Uri.parse('https://www.trrgroup.advancedis.co.th/api/chat/send-image'));
    request.fields.addAll({'user_id': '444', 'name': 'เทส'});
    request.files
        .add(await http.MultipartFile.fromPath('path', imagePath.path));
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    return response.stream.bytesToString();
  }
}
