import 'dart:convert';
import 'dart:io';

import 'package:ai_flutter/basic/models/trr_object.dart';
import 'package:ai_flutter/provider/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ActivityAPI extends ApiProvider {
  ActivityAPI();

  //yearTime == ปีกิจกรรม 63_64
  //idSugarcraneType == ประเภทกิจกรรม
  //startday == วันเริ่มต้นที่เลือกแสดงผล
  //endDay == วันสิ้นสุดที่เลือกแสดงผล
  //farmSelect == แปลงที่
  //userID = ไอดี user

  //ไถและเตรียมดิน
  getSoilView(String yearTime, String idSugarcraneType, String startday,
      String endDay, String farmSelect) async {
    var demoObj = TrrData.instance;
    int userEnrollID = demoObj.userDataObj.userEnrollID;
    String _url =
        '$endPoint/get_soil_view/$yearTime/$idSugarcraneType/$startday/$endDay/$farmSelect/$userEnrollID';
    print(_url);
    return http.get(Uri.parse(_url), headers: headers);
  }

  //ปลูกอ้อย
  getGrowView(String yearTime, String idSugarcraneType, String startday,
      String endDay, String farmSelect) async {
    var demoObj = TrrData.instance;
    int userEnrollID = demoObj.userDataObj.userEnrollID;
    String _url =
        '$endPoint/get_grow_view/$yearTime/$idSugarcraneType/$startday/$endDay/$farmSelect/$userEnrollID';
    print(_url);
    return http.get(Uri.parse(_url), headers: headers);
  }

  //ให้น้ำ
  getWaterView(String yearTime, String idSugarcraneType, String startday,
      String endDay, String farmSelect) async {
    var demoObj = TrrData.instance;
    int userEnrollID = demoObj.userDataObj.userEnrollID;
    String _url =
        '$endPoint/get_water_view/$yearTime/$idSugarcraneType/$startday/$endDay/$farmSelect/$userEnrollID';
    print(_url);
    return http.get(Uri.parse(_url), headers: headers);
  }

  //ปุ๋ยยูเรีย
  getUreaView(String yearTime, String idSugarcraneType, String startday,
      String endDay, String farmSelect) async {
    var demoObj = TrrData.instance;
    int userEnrollID = demoObj.userDataObj.userEnrollID;
    String _url =
        '$endPoint/get_urea_view/$yearTime/$idSugarcraneType/$startday/$endDay/$farmSelect/$userEnrollID';
    print(_url);
    return http.get(Uri.parse(_url), headers: headers);
  }

  //ฉีดพ่นสารกำจัดศัตรูพืช
  getSprayView(String yearTime, String idSugarcraneType, String startday,
      String endDay, String farmSelect) async {
    var demoObj = TrrData.instance;
    int userEnrollID = demoObj.userDataObj.userEnrollID;
    String _url =
        '$endPoint/get_spray_view/$yearTime/$idSugarcraneType/$startday/$endDay/$farmSelect/$userEnrollID';
    return http.get(Uri.parse(_url), headers: headers);
  }

  //ใส่ปุ๋ย
  getFertilizerView(String yearTime, String idSugarcraneType, String startday,
      String endDay, String farmSelect) async {
    var demoObj = TrrData.instance;
    int userEnrollID = demoObj.userDataObj.userEnrollID;
    String _url =
        '$endPoint/get_fertilizer_view/$yearTime/$idSugarcraneType/$startday/$endDay/$farmSelect/$userEnrollID';
    return http.get(Uri.parse(_url), headers: headers);
  }

  //ตัดอ้อย
  getLeavesView(String yearTime, String idSugarcraneType, String startday,
      String endDay, String farmSelect) async {
    var demoObj = TrrData.instance;
    int userEnrollID = demoObj.userDataObj.userEnrollID;
    String _url =
        '$endPoint/get_leaves_view/$yearTime/$idSugarcraneType/$startday/$endDay/$farmSelect/$userEnrollID';
    return http.get(Uri.parse(_url), headers: headers);
  }

  //ขอส่งอ้อย
  getTransportView(String yearTime, String idSugarcraneType, String startday,
      String endDay, String farmSelect) async {
    var demoObj = TrrData.instance;
    int userEnrollID = demoObj.userDataObj.userEnrollID;
    String _url =
        '$endPoint/get_transport_view/$yearTime/$idSugarcraneType/$startday/$endDay/$farmSelect/$userEnrollID';
    return http.get(Uri.parse(_url), headers: headers);
  }

  //กิจกกรมสำเร็จ
  getLastView(
      String yearTime, String idSugarcraneType, String stationSelected) async {
    var demoObj = TrrData.instance;
    int userEnrollID = demoObj.userDataObj.userEnrollID;
    String _url =
        '$endPoint/get_last_view/$yearTime/$idSugarcraneType/$stationSelected/$userEnrollID';
    print(_url);
    return http.get(Uri.parse(_url), headers: headers);
  }

  //บันทึกไถและเตรียมดิน
  saveSoilData({
    // @required var idUser,
    @required var plot,
    @required var year,
    @required var idSugarcraneType,
    @required var idActivity,
    @required var no,
    @required var date,
    @required var idSoilDetail,
    @required var idSoilType,
    @required var idHybrid,
    @required var soilDesc,
    @required var laborCost,
    @required var tractorCost,
    @required var fuelPrice,
    @required var fuelAmount,
    @required var billPath,
  }) async {
    String _url = '$endPoint/save_soil_data';
    var demoObj = TrrData.instance;
    int userEnrollID = demoObj.userDataObj.userEnrollID;
    var body = json.encode({
      "idUserEnroll": userEnrollID,
      "plot": plot,
      "year": year,
      "idSugarcraneType": idSugarcraneType,
      "idActivity":
          idActivity, //มีทั้งหมด 9 กิจกรรม (กิจกรรมสุดท้ายเป็นหน้า confirm กิจกรรมทั้งหมด)
      "no": no, //จำนวนครั้งของกิจกรรม
      "date": date,
      "idSoilDetail": idSoilDetail, // 1 = ไถบุกเบิก, 2= ไถพรวน
      "idSoilType":
          idSoilType, // 1 = ริปเปอร์ระเบิดดินดาน, 2 = ไถหัวหมู, 3..4..5..6..etc.
      "idHybrid": idHybrid, //เลือกปลูกใหม่ = 1, ตอ = 2, ปลูกใหม่ และ ตอ = 3
      "soilDesc": soilDesc,
      "laborCost": laborCost,
      "tractorCost": tractorCost,
      "fuelPrice": fuelPrice,
      "fuelAmount": fuelAmount,
      "billPath": billPath,
    });
    print(body);
    return http.post(Uri.parse(_url), headers: headers, body: body);
  }

  //บันทึกปลูกอ้อย
  saveGrowData({
    @required var plot,
    @required var year,
    @required var idSugarcraneType,
    @required var idActivity,
    @required var date,
    @required var idHybrid,
    @required var idGenre,
    @required var genreDesc,
    @required var grooveSpace,
    @required var fdFertilizer,
    @required var recipe,
    @required var recipeAmount,
    @required var cutOffCost,
    @required var cutOffAmount,
    @required var price,
    @required var gougeCost,
    @required var foundationCost,
    @required var growerCost,
    @required var laborCost,
    @required var fuelPrice,
    //
    @required var billPath,
  }) async {
    String _url = '$endPoint/save_grow_data';
    var demoObj = TrrData.instance;
    int userEnrollID = demoObj.userDataObj.userEnrollID;
    var body = json.encode({
      "idUserEnroll": userEnrollID,
      "plot": plot,
      "year": year,
      "idSugarcraneType": idSugarcraneType,
      "idActivity": idActivity,
      "date": date,
      "idHybrid": idHybrid,
      //
      "idGenre": idGenre, //ประเภทกิจกกรม(ปลูกอ้อย)
      "genreDesc": genreDesc, //พันธุ์อ้อย
      "grooveSpace": grooveSpace, //ระยะห่างระหว่างร่อง
      "fdFertilizer": fdFertilizer, //การใช้ปุ๋ยรองพื้น
      "recipe": recipe, //สูตรปุ๋ย
      "recipeAmount": recipeAmount, //ปริมาณที่ใช้
      //
      "cutOffCost": cutOffCost, //ค่าตัดท่อนพันธุ์
      "cutOffAmount": cutOffAmount, //ปริมาณที่ใช้
      "price": price, //ราคาท่อนพันธุ์
      "gougeCost": gougeCost, //ค่าชักร่อง
      "foundationCost": foundationCost, //ค่าปุ๋ยรองพื้น
      "growerCost": growerCost, //ค่าจ้างรถปลูกอ้อย
      "laborCost": laborCost, //ค่าจ้างแรงงาน
      "fuelPrice": fuelPrice, //ค่าเชื้อเพลิง
      //
      "billPath": billPath,
    });
    print(body);
    return http.post(Uri.parse(_url), headers: headers, body: body);
  }

  //บันทึกให้น้ำ
  saveWaterData({
    @required var plot,
    @required var year,
    @required var idSugarcraneType,
    @required var idActivity,
    @required var date,
    @required var idHybrid,
    //
    @required var idWaterResources,
    @required var idWaterSystem,
    @required var waterSystemDesc,
    @required var laborCost,
    @required var fuelPrice,
    //
    @required var billPath,
  }) async {
    String _url = '$endPoint/save_water_data';
    var demoObj = TrrData.instance;
    int userEnrollID = demoObj.userDataObj.userEnrollID;
    var body = json.encode({
      "idUserEnroll": userEnrollID,
      "plot": plot,
      "year": year,
      "idSugarcraneType": idSugarcraneType,
      "idActivity": idActivity,
      "date": date,
      "idHybrid": idHybrid,
      //
      "idWaterResources": idWaterResources,
      "idWaterSystem": idWaterSystem,
      "waterSystemDesc": waterSystemDesc,
      //
      "laborCost": laborCost,
      "fuelPrice": fuelPrice,
      //
      "billPath": billPath,
    });
    print(body);
    return http.post(Uri.parse(_url), headers: headers, body: body);
  }

  //บันทึกปุ๋ยยูเรีย
  saveUreaData({
    @required var plot,
    @required var year,
    @required var idSugarcraneType,
    @required var idActivity,
    @required var date,
    @required var idHybrid,
    //
    @required var no,
    @required var idUrea,
    @required var recipeAmount,
    @required var ureaWeight,
    @required var waterWeight,
    //
    @required var ureaPrice,
    @required var otherRecipe,
    @required var otherRecipeAmount,
    @required var sprayCost,
    @required var laborCost,
    @required var fuelPrice,
    //
    @required var billPath,
  }) async {
    String _url = '$endPoint/save_urea_data';
    var demoObj = TrrData.instance;
    int userEnrollID = demoObj.userDataObj.userEnrollID;
    var body = json.encode({
      "idUserEnroll": userEnrollID,
      "plot": plot,
      "year": year,
      "idSugarcraneType": idSugarcraneType,
      "idActivity": idActivity,
      "date": date,
      "idHybrid": idHybrid,
      //
      "no": no,
      "idUrea": idUrea,
      "recipeAmount": recipeAmount,
      "ureaWeight": ureaWeight,
      "waterWeight": waterWeight,
      //
      "ureaPrice": ureaPrice,
      "otherRecipe": otherRecipe,
      "otherRecipeAmount": otherRecipeAmount,
      "sprayCost": sprayCost,
      "laborCost": laborCost,
      "fuelPrice": fuelPrice,
      //
      "billPath": billPath,
    });
    print(body);
    return http.post(Uri.parse(_url), headers: headers, body: body);
  }

  //บันทึกฉีดพ่นสารเคมี
  saveSprayData({
    @required var plot,
    @required var year,
    @required var idSugarcraneType,
    @required var idActivity,
    @required var date,
    @required var idHybrid,
    //
    @required var idSprayType,
    @required var idProductName,
    @required var productName,
    @required var sprayRate,
    @required var sprayQuantity,
    //
    @required var chemicalCost,
    @required var contractCost,
    @required var laborCost,
    @required var fuelPrice,
    //
    @required var billPath,
  }) async {
    String _url = '$endPoint/save_spray_data';
    var demoObj = TrrData.instance;
    int userEnrollID = demoObj.userDataObj.userEnrollID;
    var body = json.encode({
      "idUserEnroll": userEnrollID,
      "plot": plot,
      "year": year,
      "idSugarcraneType": idSugarcraneType,
      "idActivity": idActivity,
      "date": date,
      "idHybrid": idHybrid,
      //
      "idSprayType": idSprayType,
      "idProductName": idProductName,
      "productName": productName,
      "sprayRate": sprayRate,
      "sprayQuantity": sprayQuantity,
      //
      "chemicalCost": chemicalCost,
      "contractCost": contractCost,
      "laborCost": laborCost,
      "fuelPrice": fuelPrice,
      //
      "billPath": billPath,
    });
    print(body);
    return http.post(Uri.parse(_url), headers: headers, body: body);
  }

  //บันทึกใส่ปุ๋ย
  saveFertilizerData({
    @required var plot,
    @required var year,
    @required var idSugarcraneType,
    @required var idActivity,
    @required var date,
    @required var idHybrid,
    //
    @required var no,
    @required var idFertilizerType,
    @required var recipe,
    @required var recipeAmount,
    //
    @required var sackPrice,
    @required var laborCost,
    @required var machineCost,
    @required var fuelPrice,
    //
    @required var billPath,
  }) async {
    String _url = '$endPoint/save_fertilizer_data';
    var demoObj = TrrData.instance;
    int userEnrollID = demoObj.userDataObj.userEnrollID;
    var body = json.encode({
      "idUserEnroll": userEnrollID,
      "plot": plot,
      "year": year,
      "idSugarcraneType": idSugarcraneType,
      "idActivity": idActivity,
      "date": date,
      "idHybrid": idHybrid,
      //
      "no": no,
      "idFertilizerType": idFertilizerType,
      "recipe": recipe,
      "recipeAmount": recipeAmount,
      //
      "sackPrice": sackPrice,
      "machineCost": machineCost,
      "laborCost": laborCost,
      "fuelPrice": fuelPrice,
      //
      "billPath": billPath,
    });
    print(body);
    return http.post(Uri.parse(_url), headers: headers, body: body);
  }

  //บันทึกตัดอ้อย
  saveLeaveData({
    @required var plot,
    @required var year,
    @required var idSugarcraneType,
    @required var idActivity,
    @required var date,
    @required var idHybrid,
    //
    @required var idCutOffType,
    @required var cutOffAmount,
    @required var idPercentLeaves,
    @required var leaves,
    @required var idSugarcraneCat,
    //
    @required var havestCost,
    @required var grabCost,
    @required var laborCost,
    @required var fuelPrice,
    //
    @required var billPath,
  }) async {
    String _url = '$endPoint/save_leaves_data';
    var demoObj = TrrData.instance;
    int userEnrollID = demoObj.userDataObj.userEnrollID;
    var body = json.encode({
      "idUserEnroll": userEnrollID,
      "plot": plot,
      "year": year,
      "idSugarcraneType": idSugarcraneType,
      "idActivity": idActivity,
      "date": date,
      "idHybrid": idHybrid,
      //
      "idCutOffType": idCutOffType,
      "cutOffAmount": cutOffAmount,
      "idPercentLeaves": idPercentLeaves,
      "leaves": leaves,
      "idSugarcraneCat": idSugarcraneCat,
      //
      "havestCost": havestCost,
      "grabCost": grabCost,
      "laborCost": laborCost,
      "fuelPrice": fuelPrice,
      //
      "billPath": billPath,
    });
    print(body);
    return http.post(Uri.parse(_url), headers: headers, body: body);
  }

  //บันทึกส่งอ้อย
  saveTransportData({
    @required var plot,
    @required var year,
    @required var idSugarcraneType,
    @required var idActivity,
    @required var date,
    @required var idHybrid,
    //
    @required var no,
    @required var cutOffAmount,
    //
    @required var transportCost,
    @required var laborCost,
    @required var fuelPrice,
    //
    @required var billPath,
  }) async {
    String _url = '$endPoint/save_transport_data';
    var demoObj = TrrData.instance;
    int userEnrollID = demoObj.userDataObj.userEnrollID;
    var body = json.encode({
      "idUserEnroll": userEnrollID,
      "plot": plot,
      "year": year,
      "idSugarcraneType": idSugarcraneType,
      "idActivity": idActivity,
      "date": date,
      "idHybrid": idHybrid,
      //
      "no": no,
      "cutOffAmount": cutOffAmount,
      //
      "transportCost": transportCost,
      "laborCost": laborCost,
      "fuelPrice": fuelPrice,
      //
      "billPath": billPath,
    });
    print(body);
    return http.post(Uri.parse(_url), headers: headers, body: body);
  }

  //ลบกิจกรรม
  deleteActivityHistory(var activityId) async {
    String _url = '$endPoint/delete_activity_process/$activityId';
    return http.get(Uri.parse(_url), headers: headers);
  }

  //บันทึกจำนวนไร่ กรณีแปลงผสม
  saveFarmData(var stationSelected) async {
    String _url = '$endPoint/save_farm_data';
    var body = json.encode(stationSelected.toJson());
    print(body);
    return http.post(Uri.parse(_url), headers: headers, body: body);
  }

  //แสดงปีสำหรับบันทึกกิจกรรม
  getYearActivity() async {
    String _url = '$endPoint/get_year_data';
    return http.get(Uri.parse(_url), headers: headers);
  }

  // //แสดงแปลงเสร็จสิ้นกิจกกรมทั้งหมด
  // getPlotActivity(var year, var sugarType) async {
  //   String _url = '$endPoint/get_sugarcrane_success/$year/$sugarType/1';
  //   return http.get(Uri.parse(_url), headers: headers);
  // }

  // แสดงแปลงสำหรับบันทึกกิจกรรม
  getPlotActivity() async {
    String _url = '$endPointFormTrr/plot_user';
    var body = json.encode({"FacID": "1", "QuotaNO": "74", "Year": "6364"});
    print(_url);
    return http.post(Uri.parse(_url), headers: headers, body: body);
  }

  //ดึงข้อมูลแก้ไขไถและเตรียมดิน
  getSoilData(var id) async {
    String _url = '$endPoint/get_soil_data/$id';
    print(_url);
    return http.get(Uri.parse(_url), headers: headers);
  }

  //ดึงข้อมูลแก้ไขปลูกอ้อย
  getGrowData(var id) async {
    String _url = '$endPoint/get_grow_data/$id';
    return http.get(Uri.parse(_url), headers: headers);
  }

  //ดึงข้อมูลแก้ไขให้น้ำ
  getWaterData(var id) async {
    String _url = '$endPoint/get_water_data/$id';
    return http.get(Uri.parse(_url), headers: headers);
  }

  //ดึงข้อมูลแก้ไขสเปรย์ปุ๋ยยูเรีย
  getUreaData(var id) async {
    String _url = '$endPoint/get_urea_data/$id';
    return http.get(Uri.parse(_url), headers: headers);
  }

  //ดึงข้อมูลแก้ไขสเปรย์
  getSprayData(var id) async {
    String _url = '$endPoint/get_spray_data/$id';
    print(_url);
    return http.get(Uri.parse(_url), headers: headers);
  }

  //ดึงข้อมูลแก้ไขใส่ปุ๋ย
  getFertilizerData(var id) async {
    String _url = '$endPoint/get_fertilizer_data/$id';
    print(_url);
    return http.get(Uri.parse(_url), headers: headers);
  }

  //ดึงข้อมูลแก้ไขตัดอ้อย
  getLeavesData(var id) async {
    String _url = '$endPoint/get_leaves_data/$id';
    print(_url);
    return http.get(Uri.parse(_url), headers: headers);
  }

  //ดึงข้อมูลแก้ไขขนส่ง
  getTransportData(var id) async {
    String _url = '$endPoint/get_transport_data/$id';
    print(_url);
    return http.get(Uri.parse(_url), headers: headers);
  }

  //เสร็จสิ้นกิจกรรม
  Future<Response> saveSuccessProcess({
    @required var idUser,
    @required var idSugarcraneType,
    @required var plot,
    @required var year,
    @required var status,
  }) async {
    String _url = '$endPoint/save_success_process';
    var body = json.encode({
      "idUser": idUser,
      "idSugarcraneType": idSugarcraneType,
      "plot": plot,
      "year": year,
      "status": 1,
    });
    print(body);
    return http.post(Uri.parse(_url), headers: headers, body: body);
  }

  //อัพโหลดไฟล์
  uploadFile({@required File imagePath}) async {
    var demoObj = TrrData.instance;
    int userEnrollID = demoObj.userDataObj.userEnrollID;
    String _url = '$endPoint/upload_file';
    var request = http.MultipartRequest('POST', Uri.parse(_url));
    request.fields.addAll({'type': 'User_$userEnrollID' + '_activity'});
    request.files
        .add(await http.MultipartFile.fromPath('path', imagePath.path));
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    return response.stream.bytesToString();
  }
}
