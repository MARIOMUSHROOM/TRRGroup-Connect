import 'package:ai_flutter/notify/test/test_model.dart';

List<Notify> notifyNewList = [notifyNew1, notifyNew2, notifyNew3];
Notify notifyNew1 = new Notify(
  content:
      "มีการเพิ่มกิจกรรม \"การปลูกอ้อย\" จำนวน 60 ไร่ พันธุ์อ้อย ขอนแก่น ในแปลงที่ 20",
  date: DateTime(2021, 12, 7),
);
Notify notifyNew2 = new Notify(
  content:
      "ทะเบียนรถ สบ-86-3339 ได้ชั่งเข้า, ชั่งออก วันที่ 30/12/63 น้ำหนักสุทธิ 20.52 ตัน",
  date: DateTime(2021, 12, 15),
);
Notify notifyNew3 = new Notify(
  content: "บริษัท TRR Group จำกัด ได้เพิ่มวารสาร ในวันที่ 31/12/63",
  date: DateTime(2021, 12, 20),
);
