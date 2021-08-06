import 'package:flutter/material.dart';
import '../../../base_class/models/ai_base_model.dart';
import '../home_const.dart';

enum HomeIconIdent {
  CompanyInfo,
  MyPlot,
  Activity,
  Report,
  Queue,
  Ccs,
  Rain,
  Contractor,
  Account,
  Radio,
  Magazine,
  ContactUs,
  Notification,
}

class HomeIconModelItem extends AiBasicItem {
  final HomeIconIdent ident;
  final String caption;
  final String image;
  final Color imageColor;
  HomeIconModelItem({this.ident, this.caption = '', this.image = '', this.imageColor = kSolidBlueColor});
}

class HomeIconModelList extends AiBasicList {
  @override
  AiBaseItem getNewObjItem() => HomeIconModelItem();

  @override
  List<AiBaseItem> getObjList() => <HomeIconModelItem>[];

  List<HomeIconModelItem> get iconItems => super.items;

  // addHomeIcon(HomeIconModelItem aHomeIcon) {
  //   if (aHomeIcon != null) iconItems.add(aHomeIcon);
  // }

  // addHomeIcons(List<HomeIconModelItem> aHomeIcons) {
  //   if (aHomeIcons != null) {
  //     aHomeIcons.forEach((item) {
  //       addHomeIcon(item);
  //     });
  //   }
  // }

  static final HomeIconModelList instance = HomeIconModelList()
    ..iconItems.addAll(
      // ..addHomeIcons(
      [
        HomeIconModelItem(ident: HomeIconIdent.CompanyInfo, caption: 'ข้อมูลบริษัท', image: 'assets/images/landing/logo.png', imageColor: kGoldColor),
        HomeIconModelItem(ident: HomeIconIdent.MyPlot, caption: 'แปลงของฉัน', image: 'assets/images/landing/my_plot.png'),
        HomeIconModelItem(ident: HomeIconIdent.Activity, caption: 'บันทึกกิจกรรม', image: 'assets/images/landing/activity.png'),
        HomeIconModelItem(ident: HomeIconIdent.Report, caption: 'รายงาน', image: 'assets/images/landing/report.png'),
        HomeIconModelItem(ident: HomeIconIdent.Queue, caption: 'คิวอ้อย', image: 'assets/images/landing/queue.png'),
        HomeIconModelItem(ident: HomeIconIdent.Ccs, caption: 'ตรวจสอบ CCS', image: 'assets/images/landing/ccs.png'),
        HomeIconModelItem(ident: HomeIconIdent.Rain, caption: 'น้ำฝน', image: 'assets/images/landing/rain.png'),
        HomeIconModelItem(ident: HomeIconIdent.Contractor, caption: 'ผู้รับเหมา', image: 'assets/images/landing/contractor.png'),
        HomeIconModelItem(ident: HomeIconIdent.Account, caption: 'รายรับรายจ่าย', image: 'assets/images/landing/account.png'),
        HomeIconModelItem(ident: HomeIconIdent.Radio, caption: 'วิทยุชุมชน', image: 'assets/images/landing/radio.png', imageColor: Colors.green[700]),
        HomeIconModelItem(ident: HomeIconIdent.Magazine, caption: 'วารสาร', image: 'assets/images/landing/magazine.png'),
        HomeIconModelItem(ident: HomeIconIdent.ContactUs, caption: 'ติดต่อเรา', image: 'assets/images/landing/contact_us.png'),
      ],
    );
}
