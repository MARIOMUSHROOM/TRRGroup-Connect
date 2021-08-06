import './models/report_activity_model.dart';
import 'dart:math';

ReportPlotList dummyReportPlotList() {
  var result = ReportPlotList.instance;
  result.plotItems.clear();
  for (var i = 1; i <= 40; i++)
    result.plotItems.add(
      ReportPlotItem(
        plotName: 'แปลงที่ $i',
        plotTypeName: 'อ้อยปลูกใหม่',
        activityDateList: dummyDateList,
        raiCount: i * Random().nextInt(99) * 1.0,
        sugarcaneVolume: Random().nextInt(999) * 1.0,
      ),
    );
  result.productSummary = 12000.34;
  return result;
}

final ReportActivityDateList dummyDateList = ReportActivityDateList.instance //ReportActivityDateList()
  ..dateItems.addAll(
    [
      ReportActivityDateItem(
        activityDateTime: DateTime(2021, 12, 1, 8, 0),
        activityList: ReportActivityList()
          ..activityItems.add(
            ReportActivityItem(
              label: 'ไถ พรวนดินครั้งที่ 1',
              detailList: ReportActivityDetailList()
                ..detailItems.addAll(
                  [
                    ReportActivityDetailItem(detailDescription: 'ริปเปอร์ระเบิดดินดาน'),
                    ReportActivityDetailItem(detailDescription: 'ค่าจ้างรถไถ 1,000 บาท'),
                    ReportActivityDetailItem(detailDescription: 'ค่าจ้างแรงงาน 1,000 บาท'),
                    ReportActivityDetailItem(detailDescription: 'ปริมาณใช้เชื้อเพลิง 10 ลิตร'),
                    ReportActivityDetailItem(detailDescription: 'ราคาเชื้อเพลิง 500 บาท'),
                  ],
                ),
            ),
          ),
      ),
      ReportActivityDateItem(
        activityDateTime: DateTime(2021, 12, 7, 9, 0),
        activityList: ReportActivityList()
          ..activityItems.addAll(
            [
              ReportActivityItem(
                label: 'ไถ พรวนดินครั้งที่ 2',
                detailList: ReportActivityDetailList()
                  ..detailItems.addAll(
                    [
                      ReportActivityDetailItem(detailDescription: 'ค่าจ้างรถไถ 1,000 บาท'),
                      ReportActivityDetailItem(detailDescription: 'ค่าจ้างแรงงาน 1,000 บาท'),
                      ReportActivityDetailItem(detailDescription: 'ปริมาณใช้เชื้อเพลิง 15 ลิตร'),
                      ReportActivityDetailItem(detailDescription: 'ราคาเชื้อเพลิง 1,500 บาท'),
                    ],
                  ),
              ),
              ReportActivityItem(
                label: 'ปลูกอ้อยใหม่',
                detailList: ReportActivityDetailList()
                  ..detailItems.addAll(
                    [
                      ReportActivityDetailItem(detailDescription: 'ค่าตัดท่อนพันธุ์ 100 บาท'),
                      ReportActivityDetailItem(detailDescription: 'ราคาท่อนพันธุ์ 1,000 บาท'),
                      ReportActivityDetailItem(detailDescription: 'ค่าจ้างรถชักร่อง 2,000 บาท'),
                      ReportActivityDetailItem(detailDescription: 'ค่าปุ๋ยรองพื้น 2,000 บาท'),
                      ReportActivityDetailItem(detailDescription: 'ค่าจ้างรถปลูกอ้อย 3,000 บาท'),
                      ReportActivityDetailItem(detailDescription: 'ค่าปุ๋ยรองพื้น 2,000 บาท'),
                      ReportActivityDetailItem(detailDescription: 'ค่าจ้างแรงงาน 13,000 บาท'),
                      ReportActivityDetailItem(detailDescription: 'ราคาเชื้อเพลิง 300 บาท'),
                    ],
                  ),
              ),
            ],
          ),
      ),
      ReportActivityDateItem(
        activityDateTime: DateTime(2021, 12, 20, 12, 0),
        activityList: ReportActivityList()
          ..activityItems.add(
            ReportActivityItem(
              label: 'แหล่งน้ำ น้ำฝน',
              detailList: ReportActivityDetailList()
                ..detailItems.addAll(
                  [
                    ReportActivityDetailItem(detailDescription: 'ระบบน้ำหยด'),
                    ReportActivityDetailItem(detailDescription: 'ค่าจ้างแรงงาน 2,000 บาท'),
                    ReportActivityDetailItem(detailDescription: 'ราคาเชื้อเพลิง 300 บาท'),
                  ],
                ),
            ),
          ),
      ),
      ReportActivityDateItem(
        activityDateTime: DateTime(2022, 1, 8, 7, 0),
        activityList: ReportActivityList()
          ..activityItems.add(
            ReportActivityItem(
              label: 'ฉีดน้ำหมักปุ๋ยยูเรียครั้งที่ 1',
              detailList: ReportActivityDetailList()
                ..detailItems.addAll(
                  [
                    ReportActivityDetailItem(detailDescription: 'ปริมาณน้ำหนักปุ๋ยยูเรีย 3 ลิตร'),
                    ReportActivityDetailItem(detailDescription: 'ปุ๋ยยูเรีย 40 กิโลกรัม'),
                    ReportActivityDetailItem(detailDescription: 'น้ำ 15 ลิตร'),
                    ReportActivityDetailItem(detailDescription: 'ค่าปุ๋ยยูเรีย กระสอบละ 75 บาท'),
                    ReportActivityDetailItem(detailDescription: 'ค่าจ้างรถฉีดพ่น 1,500 บาท'),
                    ReportActivityDetailItem(detailDescription: 'ค่าแรงงาน 2,000 บาท'),
                  ],
                ),
            ),
          ),
      ),
      ReportActivityDateItem(
        activityDateTime: DateTime(2021, 12, 1, 8, 0),
        activityList: ReportActivityList()
          ..activityItems.add(
            ReportActivityItem(
              label: 'ไถ พรวนดินครั้งที่ 1',
              detailList: ReportActivityDetailList()
                ..detailItems.addAll(
                  [
                    ReportActivityDetailItem(detailDescription: 'ริปเปอร์ระเบิดดินดาน'),
                    ReportActivityDetailItem(detailDescription: 'ค่าจ้างรถไถ 1,000 บาท'),
                    ReportActivityDetailItem(detailDescription: 'ค่าจ้างแรงงาน 1,000 บาท'),
                    ReportActivityDetailItem(detailDescription: 'ปริมาณใช้เชื้อเพลิง 10 ลิตร'),
                    ReportActivityDetailItem(detailDescription: 'ราคาเชื้อเพลิง 500 บาท'),
                  ],
                ),
            ),
          ),
      ),
      ReportActivityDateItem(
        activityDateTime: DateTime(2021, 12, 7, 9, 0),
        activityList: ReportActivityList()
          ..activityItems.addAll(
            [
              ReportActivityItem(
                label: 'ไถ พรวนดินครั้งที่ 2',
                detailList: ReportActivityDetailList()
                  ..detailItems.addAll(
                    [
                      ReportActivityDetailItem(detailDescription: 'ค่าจ้างรถไถ 1,000 บาท'),
                      ReportActivityDetailItem(detailDescription: 'ค่าจ้างแรงงาน 1,000 บาท'),
                      ReportActivityDetailItem(detailDescription: 'ปริมาณใช้เชื้อเพลิง 15 ลิตร'),
                      ReportActivityDetailItem(detailDescription: 'ราคาเชื้อเพลิง 1,500 บาท'),
                    ],
                  ),
              ),
              ReportActivityItem(
                label: 'ปลูกอ้อยใหม่',
                detailList: ReportActivityDetailList()
                  ..detailItems.addAll(
                    [
                      ReportActivityDetailItem(detailDescription: 'ค่าตัดท่อนพันธุ์ 100 บาท'),
                      ReportActivityDetailItem(detailDescription: 'ราคาท่อนพันธุ์ 1,000 บาท'),
                      ReportActivityDetailItem(detailDescription: 'ค่าจ้างรถชักร่อง 2,000 บาท'),
                      ReportActivityDetailItem(detailDescription: 'ค่าปุ๋ยรองพื้น 2,000 บาท'),
                      ReportActivityDetailItem(detailDescription: 'ค่าจ้างรถปลูกอ้อย 3,000 บาท'),
                      ReportActivityDetailItem(detailDescription: 'ค่าปุ๋ยรองพื้น 2,000 บาท'),
                      ReportActivityDetailItem(detailDescription: 'ค่าจ้างแรงงาน 13,000 บาท'),
                      ReportActivityDetailItem(detailDescription: 'ราคาเชื้อเพลิง 300 บาท'),
                    ],
                  ),
              ),
            ],
          ),
      ),
      ReportActivityDateItem(
        activityDateTime: DateTime(2021, 12, 20, 12, 0),
        activityList: ReportActivityList()
          ..activityItems.add(
            ReportActivityItem(
              label: 'แหล่งน้ำ น้ำฝน',
              detailList: ReportActivityDetailList()
                ..detailItems.addAll(
                  [
                    ReportActivityDetailItem(detailDescription: 'ระบบน้ำหยด'),
                    ReportActivityDetailItem(detailDescription: 'ค่าจ้างแรงงาน 2,000 บาท'),
                    ReportActivityDetailItem(detailDescription: 'ราคาเชื้อเพลิง 300 บาท'),
                  ],
                ),
            ),
          ),
      ),
      ReportActivityDateItem(
        activityDateTime: DateTime(2022, 1, 8, 7, 0),
        activityList: ReportActivityList()
          ..activityItems.add(
            ReportActivityItem(
              label: 'ฉีดน้ำหมักปุ๋ยยูเรียครั้งที่ 1',
              detailList: ReportActivityDetailList()
                ..detailItems.addAll(
                  [
                    ReportActivityDetailItem(detailDescription: 'ปริมาณน้ำหนักปุ๋ยยูเรีย 3 ลิตร'),
                    ReportActivityDetailItem(detailDescription: 'ปุ๋ยยูเรีย 40 กิโลกรัม'),
                    ReportActivityDetailItem(detailDescription: 'น้ำ 15 ลิตร'),
                    ReportActivityDetailItem(detailDescription: 'ค่าปุ๋ยยูเรีย กระสอบละ 75 บาท'),
                    ReportActivityDetailItem(detailDescription: 'ค่าจ้างรถฉีดพ่น 1,500 บาท'),
                    ReportActivityDetailItem(detailDescription: 'ค่าแรงงาน 2,000 บาท'),
                  ],
                ),
            ),
          ),
      ),
    ],
  );
