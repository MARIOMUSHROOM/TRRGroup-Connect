import 'package:ai_flutter/bloc/activity_state/chemicalspray_plant/bloc/chemical_spray_plant_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/cut_plant/bloc/cut_plant_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/manure_plant/bloc/manure_plant_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/set_plant/bloc/set_plant_bloc_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/ship_plant/bloc/ship_plant_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/success_plant/bloc/success_plant_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/test/bloc/test_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/water_plant/bloc/water_plant_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/waterspray_plant/bloc/water_spray_plant_bloc.dart';
import 'package:ai_flutter/bloc/chat_state/bloc/chat_bloc.dart';
import 'package:ai_flutter/bloc/income_expense_state/income_expense_info/bloc/income_expense_info_bloc.dart';
import 'package:ai_flutter/bloc/income_expense_state/receipt_cane_info/bloc/receipt_cane_info_bloc.dart';
import 'package:ai_flutter/bloc/journal_state/bloc/journal_bloc.dart';
import 'package:ai_flutter/bloc/notify_state/bloc/notify_bloc.dart';
import 'package:ai_flutter/bloc/report_state/report_detail/bloc/report_detail_bloc.dart';
import 'package:ai_flutter/bloc/report_state/report_list/bloc/report_list_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import './theme/theme.dart';
// import './nav_page.dart';
import './splash_screen.dart';

import './auth/pages/register_front_page.dart';
import 'bloc/activity_state/seed_plant/bloc/seed_plant_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'bloc/plot_state/plot_info/bloc/plot_bloc.dart';
import 'bloc/plot_state/plot_list/bloc/plot_list_bloc.dart';
import 'bloc/plot_state/plot_map/bloc/plot_map_bloc.dart';

/* Contractor Bloc */
import 'bloc/contractor/contractor_type/bloc/contractor_type_bloc.dart';
import 'bloc/contractor/contractor_list/bloc/contractor_list_bloc.dart';
import 'bloc/contractor/contractor_detail/bloc/contractor_detail_bloc.dart';

/* User Bloc */
import 'bloc/user/otp/bloc/otp_bloc.dart';
import 'bloc/user/validate_user/bloc/validate_user_bloc.dart';
import 'bloc/user/validate_otp/bloc/validate_otp_bloc.dart';
import 'bloc/user/update/bloc/update_user_bloc.dart';
import 'bloc/user/guest/bloc/validate_guest_user_bloc.dart';
import 'bloc/user/person/bloc/retrieve_person_data_bloc.dart';
import 'bloc/user/group_year/bloc/retrieve_group_year_bloc.dart';

/* Preference */
import 'bloc/user/shared_preference/bloc/user_preference_bloc.dart';

/* Global Weather */
import 'bloc/weather/bloc/global_weather_bloc.dart';

/* test */
import './test_nav_bloc/test_chat_notification_bloc/bloc/test_chat_notification_bloc.dart';
import './test_nav_bloc/test_notification_bloc/bloc/test_notification_bloc.dart';

import 'package:firebase_core/firebase_core.dart';

/// Custom [BlocObserver] which observes all bloc and cubit instances.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

//fcm
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

AndroidNotificationChannel channel;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//close fcm
void main() async {
  Paint.enableDithering = true;
  Bloc.observer = SimpleBlocObserver();

  //fcm notification
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  } //close fcm

  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SetPlantBlocBloc>(
          create: (BuildContext context) => SetPlantBlocBloc(),
        ),
        BlocProvider<SeedPlantBloc>(
          create: (BuildContext context) => SeedPlantBloc(),
        ),
        BlocProvider<WaterPlantBloc>(
          create: (BuildContext context) => WaterPlantBloc(),
        ),
        BlocProvider<WaterSprayPlantBloc>(
          create: (BuildContext context) => WaterSprayPlantBloc(),
        ),
        BlocProvider<ChemicalSprayPlantBloc>(
          create: (BuildContext context) => ChemicalSprayPlantBloc(),
        ),
        BlocProvider<ManurePlantBloc>(
          create: (BuildContext context) => ManurePlantBloc(),
        ),
        BlocProvider<CutPlantBloc>(
          create: (BuildContext context) => CutPlantBloc(),
        ),
        BlocProvider<ShipPlantBloc>(
          create: (BuildContext context) => ShipPlantBloc(),
        ),
        BlocProvider<SuccessPlantBloc>(
          create: (BuildContext context) => SuccessPlantBloc(),
        ),
        BlocProvider<TestBloc>(
          create: (BuildContext context) => TestBloc(),
        ),
        BlocProvider<PlotBloc>(
          create: (BuildContext context) => PlotBloc(),
        ),
        BlocProvider<PlotListBloc>(
          create: (BuildContext context) => PlotListBloc(),
        ),
        BlocProvider<PlotMapBloc>(
          create: (BuildContext context) => PlotMapBloc(),
        ),
        BlocProvider<IncomeExpenseInfoBloc>(
          create: (BuildContext context) => IncomeExpenseInfoBloc(),
        ),
        BlocProvider<NotifyBloc>(
          create: (BuildContext context) => NotifyBloc(),
        ),
        BlocProvider<ChatBloc>(
          create: (BuildContext context) => ChatBloc(),
        ),
        BlocProvider<ReportListBloc>(
          create: (BuildContext context) => ReportListBloc(),
        ),
        BlocProvider<ReportDetailBloc>(
          create: (BuildContext context) => ReportDetailBloc(),
        ),
        BlocProvider<JournalBloc>(
          create: (BuildContext context) => JournalBloc(),
        ),
        BlocProvider<ReceiptCaneInfoBloc>(
          create: (BuildContext context) => ReceiptCaneInfoBloc(),
        ),
        BlocProvider<ContractorTypeBloc>(
          create: (BuildContext context) => ContractorTypeBloc(),
        ),
        BlocProvider<ContractorListBloc>(
          create: (BuildContext context) => ContractorListBloc(),
        ),
        BlocProvider<ContractorDetailBloc>(
          create: (BuildContext context) => ContractorDetailBloc(),
        ),
        BlocProvider<ValidateUserBloc>(
          create: (BuildContext context) => ValidateUserBloc(),
        ),
        BlocProvider<UserPreferenceBloc>(
          create: (BuildContext context) => UserPreferenceBloc(),
        ),
        BlocProvider<OtpBloc>(
          create: (BuildContext context) => OtpBloc(),
        ),
        BlocProvider<ValidateOtpBloc>(
          create: (BuildContext context) => ValidateOtpBloc(),
        ),
        BlocProvider<UpdateUserBloc>(
          create: (BuildContext context) => UpdateUserBloc(),
        ),
        BlocProvider<TestChatNotificationBloc>(
          create: (BuildContext context) => TestChatNotificationBloc(),
        ),
        BlocProvider<TestNotificationBloc>(
          create: (BuildContext context) => TestNotificationBloc(),
        ),
        BlocProvider<ValidateGuestUserBloc>(
          create: (BuildContext context) => ValidateGuestUserBloc(),
        ),
        BlocProvider<RetrievePersonDataBloc>(
          create: (BuildContext context) => RetrievePersonDataBloc(),
        ),
        BlocProvider<RetrieveGroupYearBloc>(
          create: (BuildContext context) => RetrieveGroupYearBloc(),
        ),
        BlocProvider<GlobalWeatherBloc>(
          create: (BuildContext context) => GlobalWeatherBloc(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('th', 'TH'),
        ],
        title: 'TRR Group',
        debugShowCheckedModeBanner: false,
        theme: trrAppTheme(),
        // routes: routeTable,
        // initialRoute: SplashScreen.pageName,

        home: SplashScreen(),

        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        //   textTheme: GoogleFonts.kanitTextTheme(
        //     Theme.of(context).textTheme,
        //   ),
        // ),
        // home: LoginPage(),
        // home: TabsPage(),
        // home: NavPage(),
        // home: _decideMainPage(),
      ),
    );
  }

  // _decideMainPage() {
  //   const isVerify = 0;
  //   if (isVerify == 1) {
  //     return NavPage();
  //   } else {
  //     // return RegisterFrontPage();
  //     return SplashScreen();
  //   }
  // }
}

// Map<String, WidgetBuilder> routeTable = {
//   SplashScreen.pageName: (context) => SplashScreen(),
// };

// class MainPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'หน้าหลัก',
//         home: DefaultTabController(
//             length: 4,
//             child: Scaffold(
//               appBar: AppBar(
//                 leading: Icon(Icons.home),
//                 title: Text('Home'),
//                 bottom: TabBar(
//                   tabs: <Widget>[
//                     Tab(text: "Home"),
//                     Tab(text: "Chat"),
//                     Tab(text: "Notify"),
//                     Tab(text: "Profile"),
//                   ],
//                 ),
//               ),
//               body: TabBarView(
//                 children: <Widget>[
//                   HomeScreen(),
//                   ChatScreen(),
//                   NotifyScreen(),
//                   ProfileScreen(),
//                 ],
//               ),
//             )));
//   }
// }

// class Condition extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'เงื่อนไขการใช้งาน',
//         home: Scaffold(
//             appBar: AppBar(
//               title: new Center(
//                   child: new Text('เงื่อนไขการใช้งาน',
//                       textAlign: TextAlign.center)),
//             ),
//             body: ListView(
//               padding: EdgeInsets.all(10),
//               // alignment: FractionalOffset(),
//               children: <Widget>[
//                 Text('เงื่อนไขการให้บริการ TrueMoney Wallet \n',
//                     style:
//                         TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
//                 Text(
//                     'เงื่อนไขการให้บริการ TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “เงื่อนไขการให้บริการ”) นี้เป็นข้อตกลงระหว่าง บริษัท ทรู มันนี่ จํากัด ซึ่งมีสำนักงานใหญ่ตั้งอยู่เลขที่ 89 อาคารเอไอเอ แคปปิตอล เซ็นเตอร์ ชั้น 18-19 ถนนรัชดาภิเษก แขวงดินแดง เขตดินแดง กรุงเทพมหานคร (ซึ่งต่อไปนี้จะเรียกว่า “บริษัท”) ฝ่ายหนึ่ง กับ ผู้ใช้บริการ TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “ผู้ใช้บริการ”) อีกฝ่ายหนึ่ง เพื่อใช้บริการ TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “บริการ”) โดยผู้ใช้บริการสามารถทําธุรกรรมการเงินด้วยเงินอิเล็กทรอนิกส์ของบริษัท (ซึ่งต่อไปนี้จะเรียกว่า “เงิน”) บัตรเครดิต บัตรเดบิต หรือบัตรอิเล็กทรอนิกส์ที่ผูกกับบัญชีของผู้ใช้บริการ ทั้งการเติม-จ่าย-โอน-ถอน ได้อย่างสะดวก ผ่านแอปพลิเคชัน TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “แอปพลิเคชัน”) หรือผ่านทาง Prepaid Card ของบริษัท เช่น WeCard หรือบัตรอื่นใดที่บริษัทออกร่วมกับนิติบุคคลอื่น ผู้ใช้บริการมีหน้าที่ทําความเข้าใจอย่างละเอียดก่อนการใช้บริการ และคอยตรวจสอบเงื่อนไขการให้บริการนี้อย่างสม่ำเสมอ หากมีข้อสงสัยเกี่ยวกับบริการ ผู้ใช้บริการสามารถติดต่อสอบถามได้ผ่านช่องทาง TrueMoney Customer Care 1240 หรือช่องทางอื่นตามที่บริษัทกำหนด \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 Text('1. ข้อกําหนดทั่วไป',
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                 Text(
//                     '1.1 ผู้ใช้บริการตกลงที่จะปฏิบัติและผูกพันตามเงื่อนไขการให้บริการ ซึ่งการใช้บริการของผู้ใช้บริการถือเป็นการยอมรับเงื่อนไขการให้บริการนี้ โดยบริษัทอาจแก้ไข หรือเพิ่มเติมเงื่อนไขการให้บริการได้ ไม่ว่าในเวลาใด โดยบริษัทจะแจ้งให้ผู้ใช้บริการทราบ และการที่ผู้ใช้บริการใช้บริการต่อไปภายหลังจากที่มีการแก้ไข หรือเพิ่มเติมดังกล่าว ย่อมถือเป็นการยอมรับการแก้ไข หรือเพิ่มเติมในแต่ละครั้ง\n'
//                     '1.2 เว้นแต่จะได้มีการแจ้ง หรือกําหนดไว้เป็นอย่างอื่น คุณลักษณะใหม่ ๆ ที่ได้แก้ไข เพิ่มเติม หรือปรับปรุงในบริการให้ถือว่าอยู่ภายใต้เงื่อนไขการให้บริการฉบับนี้ทั้งสิ้น \n'
//                     '1.3 บริษัทสงวนสิทธิในการปรับปรุงหรือยกเลิกการบริการ หรือส่วนใดส่วนหนึ่งของบริการ ไม่ว่าจะเป็นการชั่วคราว หรือตลอดไปได้ตลอดเวลา โดยบริษัทจะแจ้งให้ทราบล่วงหน้า \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 Text('2. การใช้บริการ',
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                 Text(
//                     '2.1 ในการสมัครใช้บริการ ผู้ใช้บริการจะต้องเปิดบัญชี TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “บัญชี”) เพื่อใช้ในการทํารายการต่าง ๆ อันเกี่ยวเนื่องกับการใช้บริการ โดยผู้ใช้บริการต้องดำเนินการดังต่อไปนี้ \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 ListTile(
//                   title: Text(
//                       '2.1.1 ผู้ใช้บริการที่มีสัญชาติไทย ต้องกรอกชื่อ-นามสกุล อีเมล หมายเลขโทรศัพท์เคลื่อนที่ ที่อยู่ อาชีพ สถานที่ทำงาน วันเดือนปีเกิด และหมายเลขบัตรประจําตัวประชาชนของตนเอง รวมทั้งข้อมูลอื่น ๆ ตามที่บริษัทกำหนด หรือจะกำหนดต่อไป เพื่อให้เป็นไปตามวัตถุประสงค์ในการให้บริการของบริษัทและ/หรือกฎหมายที่เกี่ยวข้อง \n'),
//                 ),
//                 ListTile(
//                   title: Text(
//                       '2.1.2 ผู้ใช้บริการที่ถือสัญชาติอื่นนอกจากสัญชาติไทย (ซึ่งต่อไปนี้จะเรียกว่า “ชาวต่างชาติ”) ต้องกรอก ประเภทวีซ่าเพื่อการพำนักในประเทศไทย สถานที่พำนักในประเทศไทย รูปถ่ายหนังสือเดินทางที่มีอายุใช้งานเหลือมากกว่า 6 (หก) เดือน รวมทั้งข้อมูลอื่น ๆ ตามที่บริษัทกำหนด หรือจะกำหนดต่อไป เพื่อให้เป็นไปตามวัตถุประสงค์ในการให้บริการของบริษัทและ/หรือกฎหมายที่เกี่ยวข้อง \n'),
//                 ),
//                 Text(
//                     'เมื่อผู้ใช้บริการกรอกข้อมูลข้างต้นแล้ว ผู้ใช้บริการจะต้องกําหนดตัวอักษร อักขระ ตัวเลข สัญลักษณ์ รวมถึงข้อมูลทางชีวภาพ ตามที่บริษัทกำหนด (ซึ่งต่อไปนี้จะเรียกว่า “รหัสผ่าน”) โดยสามารถแก้ไขเปลี่ยนแปลงรหัสผ่านนี้ได้เองในภายหลังตามข้อกําหนดและเงื่อนไขของบริษัท \n\n'
//                     'ทั้งนี้ บริษัทขอสงวนสิทธิในการปฏิเสธการเปิดใช้บริการ ให้บริการ และ/หรือทำธุรกรรมกับผู้ใช้บริการที่ปกปิดชื่อจริง หรือ ใช้นามแฝง หรือเมื่อบริษัทตรวจพบว่าชื่อที่ผู้ใช้บริการลงทะเบียนไว้เป็นชื่อที่ไม่ถูกต้อง แท้จริงและเป็นปัจจุบัน ทั้งนี้ ในกรณีที่ผู้ใช้บริการเป็นชาวต่างชาติ บริษัทขอสงวนสิทธิปฏิเสธการเปิดใช้บริการ ให้บริการ และ/หรือทำธุรกรรมกับผู้ใช้บริการที่มีสัญชาติ ถิ่นที่อยู่ หรืออาชีพบางประเภทตามที่บริษัทกำหนด ทั้งนี้ ผู้ใช้บริการตกลงและยอมรับว่าการพิจารณาอนุมัติการสมัครใช้บริการขึ้นอยู่กับดุลยพินิจของบริษัทแต่เพียงฝ่ายเดียวเท่านั้น \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 Text(
//                     '2.2 ผู้ใช้บริการจะต้องเก็บรักษารหัสผ่าน และข้อมูลที่ใช้ในการสมัครใช้บริการไว้เป็นความลับเฉพาะตัวของผู้ใช้บริการเท่านั้น และไม่เปิดเผย หรือกระทำการใด ๆ ที่อาจทำให้ผู้อื่นทราบรหัสผ่าน และ/หรือข้อมูลดังกล่าว ผู้ใช้บริการยอมรับว่าหากมีการทํารายการใด ๆ โดยใช้รหัสผ่านของผู้ใช้บริการ ให้ถือว่าเป็นการกระทําโดยตัวของผู้ใช้บริการเองทุกประการ โดยบริษัทไม่ต้องรับผิดชอบในความเสียหายที่เกิดขึ้นจากการทํารายการใด ๆ ภายใต้บัญชีของผู้ใช้บริการ จากการใช้รหัสผ่านดังกล่าว \n'
//                     '2.3 ในกรณีที่ผู้ใช้บริการใช้รหัสผ่านทํารายการใด ๆ อันเกี่ยวเนื่องกับการใช้บริการเสร็จสิ้นสมบูรณ์แล้ว ผู้ใช้บริการยอมรับว่าไม่สามารถยกเลิก เพิกถอน เปลี่ยนแปลง หรือแก้ไขรายการดังกล่าวได้ และผู้ใช้บริการต้องผูกพันตามรายการดังกล่าวทุกประการ',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//               ],
//             )));
//   }
// }

// class HomeScreen extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'เงื่อนไขการใช้งาน',
//         home: Scaffold(
//             appBar: AppBar(
//               title: new Center(
//                   child: new Text('เงื่อนไขการใช้งาน',
//                       textAlign: TextAlign.center)),
//             ),
//             body: ListView(
//               padding: EdgeInsets.all(10),
//               // alignment: FractionalOffset(),
//               children: <Widget>[
//                 Text('เงื่อนไขการให้บริการ TrueMoney Wallet \n',
//                     style:
//                         TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
//                 Text(
//                     'เงื่อนไขการให้บริการ TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “เงื่อนไขการให้บริการ”) นี้เป็นข้อตกลงระหว่าง บริษัท ทรู มันนี่ จํากัด ซึ่งมีสำนักงานใหญ่ตั้งอยู่เลขที่ 89 อาคารเอไอเอ แคปปิตอล เซ็นเตอร์ ชั้น 18-19 ถนนรัชดาภิเษก แขวงดินแดง เขตดินแดง กรุงเทพมหานคร (ซึ่งต่อไปนี้จะเรียกว่า “บริษัท”) ฝ่ายหนึ่ง กับ ผู้ใช้บริการ TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “ผู้ใช้บริการ”) อีกฝ่ายหนึ่ง เพื่อใช้บริการ TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “บริการ”) โดยผู้ใช้บริการสามารถทําธุรกรรมการเงินด้วยเงินอิเล็กทรอนิกส์ของบริษัท (ซึ่งต่อไปนี้จะเรียกว่า “เงิน”) บัตรเครดิต บัตรเดบิต หรือบัตรอิเล็กทรอนิกส์ที่ผูกกับบัญชีของผู้ใช้บริการ ทั้งการเติม-จ่าย-โอน-ถอน ได้อย่างสะดวก ผ่านแอปพลิเคชัน TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “แอปพลิเคชัน”) หรือผ่านทาง Prepaid Card ของบริษัท เช่น WeCard หรือบัตรอื่นใดที่บริษัทออกร่วมกับนิติบุคคลอื่น ผู้ใช้บริการมีหน้าที่ทําความเข้าใจอย่างละเอียดก่อนการใช้บริการ และคอยตรวจสอบเงื่อนไขการให้บริการนี้อย่างสม่ำเสมอ หากมีข้อสงสัยเกี่ยวกับบริการ ผู้ใช้บริการสามารถติดต่อสอบถามได้ผ่านช่องทาง TrueMoney Customer Care 1240 หรือช่องทางอื่นตามที่บริษัทกำหนด \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 Text('1. ข้อกําหนดทั่วไป',
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                 Text(
//                     '1.1 ผู้ใช้บริการตกลงที่จะปฏิบัติและผูกพันตามเงื่อนไขการให้บริการ ซึ่งการใช้บริการของผู้ใช้บริการถือเป็นการยอมรับเงื่อนไขการให้บริการนี้ โดยบริษัทอาจแก้ไข หรือเพิ่มเติมเงื่อนไขการให้บริการได้ ไม่ว่าในเวลาใด โดยบริษัทจะแจ้งให้ผู้ใช้บริการทราบ และการที่ผู้ใช้บริการใช้บริการต่อไปภายหลังจากที่มีการแก้ไข หรือเพิ่มเติมดังกล่าว ย่อมถือเป็นการยอมรับการแก้ไข หรือเพิ่มเติมในแต่ละครั้ง\n'
//                     '1.2 เว้นแต่จะได้มีการแจ้ง หรือกําหนดไว้เป็นอย่างอื่น คุณลักษณะใหม่ ๆ ที่ได้แก้ไข เพิ่มเติม หรือปรับปรุงในบริการให้ถือว่าอยู่ภายใต้เงื่อนไขการให้บริการฉบับนี้ทั้งสิ้น \n'
//                     '1.3 บริษัทสงวนสิทธิในการปรับปรุงหรือยกเลิกการบริการ หรือส่วนใดส่วนหนึ่งของบริการ ไม่ว่าจะเป็นการชั่วคราว หรือตลอดไปได้ตลอดเวลา โดยบริษัทจะแจ้งให้ทราบล่วงหน้า \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 Text('2. การใช้บริการ',
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                 Text(
//                     '2.1 ในการสมัครใช้บริการ ผู้ใช้บริการจะต้องเปิดบัญชี TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “บัญชี”) เพื่อใช้ในการทํารายการต่าง ๆ อันเกี่ยวเนื่องกับการใช้บริการ โดยผู้ใช้บริการต้องดำเนินการดังต่อไปนี้ \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 ListTile(
//                   title: Text(
//                       '2.1.1 ผู้ใช้บริการที่มีสัญชาติไทย ต้องกรอกชื่อ-นามสกุล อีเมล หมายเลขโทรศัพท์เคลื่อนที่ ที่อยู่ อาชีพ สถานที่ทำงาน วันเดือนปีเกิด และหมายเลขบัตรประจําตัวประชาชนของตนเอง รวมทั้งข้อมูลอื่น ๆ ตามที่บริษัทกำหนด หรือจะกำหนดต่อไป เพื่อให้เป็นไปตามวัตถุประสงค์ในการให้บริการของบริษัทและ/หรือกฎหมายที่เกี่ยวข้อง \n'),
//                 ),
//                 ListTile(
//                   title: Text(
//                       '2.1.2 ผู้ใช้บริการที่ถือสัญชาติอื่นนอกจากสัญชาติไทย (ซึ่งต่อไปนี้จะเรียกว่า “ชาวต่างชาติ”) ต้องกรอก ประเภทวีซ่าเพื่อการพำนักในประเทศไทย สถานที่พำนักในประเทศไทย รูปถ่ายหนังสือเดินทางที่มีอายุใช้งานเหลือมากกว่า 6 (หก) เดือน รวมทั้งข้อมูลอื่น ๆ ตามที่บริษัทกำหนด หรือจะกำหนดต่อไป เพื่อให้เป็นไปตามวัตถุประสงค์ในการให้บริการของบริษัทและ/หรือกฎหมายที่เกี่ยวข้อง \n'),
//                 ),
//                 Text(
//                     'เมื่อผู้ใช้บริการกรอกข้อมูลข้างต้นแล้ว ผู้ใช้บริการจะต้องกําหนดตัวอักษร อักขระ ตัวเลข สัญลักษณ์ รวมถึงข้อมูลทางชีวภาพ ตามที่บริษัทกำหนด (ซึ่งต่อไปนี้จะเรียกว่า “รหัสผ่าน”) โดยสามารถแก้ไขเปลี่ยนแปลงรหัสผ่านนี้ได้เองในภายหลังตามข้อกําหนดและเงื่อนไขของบริษัท \n\n'
//                     'ทั้งนี้ บริษัทขอสงวนสิทธิในการปฏิเสธการเปิดใช้บริการ ให้บริการ และ/หรือทำธุรกรรมกับผู้ใช้บริการที่ปกปิดชื่อจริง หรือ ใช้นามแฝง หรือเมื่อบริษัทตรวจพบว่าชื่อที่ผู้ใช้บริการลงทะเบียนไว้เป็นชื่อที่ไม่ถูกต้อง แท้จริงและเป็นปัจจุบัน ทั้งนี้ ในกรณีที่ผู้ใช้บริการเป็นชาวต่างชาติ บริษัทขอสงวนสิทธิปฏิเสธการเปิดใช้บริการ ให้บริการ และ/หรือทำธุรกรรมกับผู้ใช้บริการที่มีสัญชาติ ถิ่นที่อยู่ หรืออาชีพบางประเภทตามที่บริษัทกำหนด ทั้งนี้ ผู้ใช้บริการตกลงและยอมรับว่าการพิจารณาอนุมัติการสมัครใช้บริการขึ้นอยู่กับดุลยพินิจของบริษัทแต่เพียงฝ่ายเดียวเท่านั้น \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 Text(
//                     '2.2 ผู้ใช้บริการจะต้องเก็บรักษารหัสผ่าน และข้อมูลที่ใช้ในการสมัครใช้บริการไว้เป็นความลับเฉพาะตัวของผู้ใช้บริการเท่านั้น และไม่เปิดเผย หรือกระทำการใด ๆ ที่อาจทำให้ผู้อื่นทราบรหัสผ่าน และ/หรือข้อมูลดังกล่าว ผู้ใช้บริการยอมรับว่าหากมีการทํารายการใด ๆ โดยใช้รหัสผ่านของผู้ใช้บริการ ให้ถือว่าเป็นการกระทําโดยตัวของผู้ใช้บริการเองทุกประการ โดยบริษัทไม่ต้องรับผิดชอบในความเสียหายที่เกิดขึ้นจากการทํารายการใด ๆ ภายใต้บัญชีของผู้ใช้บริการ จากการใช้รหัสผ่านดังกล่าว \n'
//                     '2.3 ในกรณีที่ผู้ใช้บริการใช้รหัสผ่านทํารายการใด ๆ อันเกี่ยวเนื่องกับการใช้บริการเสร็จสิ้นสมบูรณ์แล้ว ผู้ใช้บริการยอมรับว่าไม่สามารถยกเลิก เพิกถอน เปลี่ยนแปลง หรือแก้ไขรายการดังกล่าวได้ และผู้ใช้บริการต้องผูกพันตามรายการดังกล่าวทุกประการ',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//               ],
//             )));
//   }
// }

// class ChatScreen extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'เงื่อนไขการใช้งาน',
//         home: Scaffold(
//             appBar: AppBar(
//               title: new Center(
//                   child: new Text('เงื่อนไขการใช้งาน',
//                       textAlign: TextAlign.center)),
//             ),
//             body: ListView(
//               padding: EdgeInsets.all(10),
//               // alignment: FractionalOffset(),
//               children: <Widget>[
//                 Text('เงื่อนไขการให้บริการ TrueMoney Wallet \n',
//                     style:
//                         TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
//                 Text(
//                     'เงื่อนไขการให้บริการ TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “เงื่อนไขการให้บริการ”) นี้เป็นข้อตกลงระหว่าง บริษัท ทรู มันนี่ จํากัด ซึ่งมีสำนักงานใหญ่ตั้งอยู่เลขที่ 89 อาคารเอไอเอ แคปปิตอล เซ็นเตอร์ ชั้น 18-19 ถนนรัชดาภิเษก แขวงดินแดง เขตดินแดง กรุงเทพมหานคร (ซึ่งต่อไปนี้จะเรียกว่า “บริษัท”) ฝ่ายหนึ่ง กับ ผู้ใช้บริการ TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “ผู้ใช้บริการ”) อีกฝ่ายหนึ่ง เพื่อใช้บริการ TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “บริการ”) โดยผู้ใช้บริการสามารถทําธุรกรรมการเงินด้วยเงินอิเล็กทรอนิกส์ของบริษัท (ซึ่งต่อไปนี้จะเรียกว่า “เงิน”) บัตรเครดิต บัตรเดบิต หรือบัตรอิเล็กทรอนิกส์ที่ผูกกับบัญชีของผู้ใช้บริการ ทั้งการเติม-จ่าย-โอน-ถอน ได้อย่างสะดวก ผ่านแอปพลิเคชัน TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “แอปพลิเคชัน”) หรือผ่านทาง Prepaid Card ของบริษัท เช่น WeCard หรือบัตรอื่นใดที่บริษัทออกร่วมกับนิติบุคคลอื่น ผู้ใช้บริการมีหน้าที่ทําความเข้าใจอย่างละเอียดก่อนการใช้บริการ และคอยตรวจสอบเงื่อนไขการให้บริการนี้อย่างสม่ำเสมอ หากมีข้อสงสัยเกี่ยวกับบริการ ผู้ใช้บริการสามารถติดต่อสอบถามได้ผ่านช่องทาง TrueMoney Customer Care 1240 หรือช่องทางอื่นตามที่บริษัทกำหนด \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 Text('1. ข้อกําหนดทั่วไป',
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                 Text(
//                     '1.1 ผู้ใช้บริการตกลงที่จะปฏิบัติและผูกพันตามเงื่อนไขการให้บริการ ซึ่งการใช้บริการของผู้ใช้บริการถือเป็นการยอมรับเงื่อนไขการให้บริการนี้ โดยบริษัทอาจแก้ไข หรือเพิ่มเติมเงื่อนไขการให้บริการได้ ไม่ว่าในเวลาใด โดยบริษัทจะแจ้งให้ผู้ใช้บริการทราบ และการที่ผู้ใช้บริการใช้บริการต่อไปภายหลังจากที่มีการแก้ไข หรือเพิ่มเติมดังกล่าว ย่อมถือเป็นการยอมรับการแก้ไข หรือเพิ่มเติมในแต่ละครั้ง\n'
//                     '1.2 เว้นแต่จะได้มีการแจ้ง หรือกําหนดไว้เป็นอย่างอื่น คุณลักษณะใหม่ ๆ ที่ได้แก้ไข เพิ่มเติม หรือปรับปรุงในบริการให้ถือว่าอยู่ภายใต้เงื่อนไขการให้บริการฉบับนี้ทั้งสิ้น \n'
//                     '1.3 บริษัทสงวนสิทธิในการปรับปรุงหรือยกเลิกการบริการ หรือส่วนใดส่วนหนึ่งของบริการ ไม่ว่าจะเป็นการชั่วคราว หรือตลอดไปได้ตลอดเวลา โดยบริษัทจะแจ้งให้ทราบล่วงหน้า \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 Text('2. การใช้บริการ',
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                 Text(
//                     '2.1 ในการสมัครใช้บริการ ผู้ใช้บริการจะต้องเปิดบัญชี TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “บัญชี”) เพื่อใช้ในการทํารายการต่าง ๆ อันเกี่ยวเนื่องกับการใช้บริการ โดยผู้ใช้บริการต้องดำเนินการดังต่อไปนี้ \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 ListTile(
//                   title: Text(
//                       '2.1.1 ผู้ใช้บริการที่มีสัญชาติไทย ต้องกรอกชื่อ-นามสกุล อีเมล หมายเลขโทรศัพท์เคลื่อนที่ ที่อยู่ อาชีพ สถานที่ทำงาน วันเดือนปีเกิด และหมายเลขบัตรประจําตัวประชาชนของตนเอง รวมทั้งข้อมูลอื่น ๆ ตามที่บริษัทกำหนด หรือจะกำหนดต่อไป เพื่อให้เป็นไปตามวัตถุประสงค์ในการให้บริการของบริษัทและ/หรือกฎหมายที่เกี่ยวข้อง \n'),
//                 ),
//                 ListTile(
//                   title: Text(
//                       '2.1.2 ผู้ใช้บริการที่ถือสัญชาติอื่นนอกจากสัญชาติไทย (ซึ่งต่อไปนี้จะเรียกว่า “ชาวต่างชาติ”) ต้องกรอก ประเภทวีซ่าเพื่อการพำนักในประเทศไทย สถานที่พำนักในประเทศไทย รูปถ่ายหนังสือเดินทางที่มีอายุใช้งานเหลือมากกว่า 6 (หก) เดือน รวมทั้งข้อมูลอื่น ๆ ตามที่บริษัทกำหนด หรือจะกำหนดต่อไป เพื่อให้เป็นไปตามวัตถุประสงค์ในการให้บริการของบริษัทและ/หรือกฎหมายที่เกี่ยวข้อง \n'),
//                 ),
//                 Text(
//                     'เมื่อผู้ใช้บริการกรอกข้อมูลข้างต้นแล้ว ผู้ใช้บริการจะต้องกําหนดตัวอักษร อักขระ ตัวเลข สัญลักษณ์ รวมถึงข้อมูลทางชีวภาพ ตามที่บริษัทกำหนด (ซึ่งต่อไปนี้จะเรียกว่า “รหัสผ่าน”) โดยสามารถแก้ไขเปลี่ยนแปลงรหัสผ่านนี้ได้เองในภายหลังตามข้อกําหนดและเงื่อนไขของบริษัท \n\n'
//                     'ทั้งนี้ บริษัทขอสงวนสิทธิในการปฏิเสธการเปิดใช้บริการ ให้บริการ และ/หรือทำธุรกรรมกับผู้ใช้บริการที่ปกปิดชื่อจริง หรือ ใช้นามแฝง หรือเมื่อบริษัทตรวจพบว่าชื่อที่ผู้ใช้บริการลงทะเบียนไว้เป็นชื่อที่ไม่ถูกต้อง แท้จริงและเป็นปัจจุบัน ทั้งนี้ ในกรณีที่ผู้ใช้บริการเป็นชาวต่างชาติ บริษัทขอสงวนสิทธิปฏิเสธการเปิดใช้บริการ ให้บริการ และ/หรือทำธุรกรรมกับผู้ใช้บริการที่มีสัญชาติ ถิ่นที่อยู่ หรืออาชีพบางประเภทตามที่บริษัทกำหนด ทั้งนี้ ผู้ใช้บริการตกลงและยอมรับว่าการพิจารณาอนุมัติการสมัครใช้บริการขึ้นอยู่กับดุลยพินิจของบริษัทแต่เพียงฝ่ายเดียวเท่านั้น \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 Text(
//                     '2.2 ผู้ใช้บริการจะต้องเก็บรักษารหัสผ่าน และข้อมูลที่ใช้ในการสมัครใช้บริการไว้เป็นความลับเฉพาะตัวของผู้ใช้บริการเท่านั้น และไม่เปิดเผย หรือกระทำการใด ๆ ที่อาจทำให้ผู้อื่นทราบรหัสผ่าน และ/หรือข้อมูลดังกล่าว ผู้ใช้บริการยอมรับว่าหากมีการทํารายการใด ๆ โดยใช้รหัสผ่านของผู้ใช้บริการ ให้ถือว่าเป็นการกระทําโดยตัวของผู้ใช้บริการเองทุกประการ โดยบริษัทไม่ต้องรับผิดชอบในความเสียหายที่เกิดขึ้นจากการทํารายการใด ๆ ภายใต้บัญชีของผู้ใช้บริการ จากการใช้รหัสผ่านดังกล่าว \n'
//                     '2.3 ในกรณีที่ผู้ใช้บริการใช้รหัสผ่านทํารายการใด ๆ อันเกี่ยวเนื่องกับการใช้บริการเสร็จสิ้นสมบูรณ์แล้ว ผู้ใช้บริการยอมรับว่าไม่สามารถยกเลิก เพิกถอน เปลี่ยนแปลง หรือแก้ไขรายการดังกล่าวได้ และผู้ใช้บริการต้องผูกพันตามรายการดังกล่าวทุกประการ',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//               ],
//             )));
//   }
// }

// class NotifyScreen extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'เงื่อนไขการใช้งาน',
//         home: Scaffold(
//             appBar: AppBar(
//               title: new Center(
//                   child: new Text('เงื่อนไขการใช้งาน',
//                       textAlign: TextAlign.center)),
//             ),
//             body: ListView(
//               padding: EdgeInsets.all(10),
//               // alignment: FractionalOffset(),
//               children: <Widget>[
//                 Text('เงื่อนไขการให้บริการ TrueMoney Wallet \n',
//                     style:
//                         TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
//                 Text(
//                     'เงื่อนไขการให้บริการ TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “เงื่อนไขการให้บริการ”) นี้เป็นข้อตกลงระหว่าง บริษัท ทรู มันนี่ จํากัด ซึ่งมีสำนักงานใหญ่ตั้งอยู่เลขที่ 89 อาคารเอไอเอ แคปปิตอล เซ็นเตอร์ ชั้น 18-19 ถนนรัชดาภิเษก แขวงดินแดง เขตดินแดง กรุงเทพมหานคร (ซึ่งต่อไปนี้จะเรียกว่า “บริษัท”) ฝ่ายหนึ่ง กับ ผู้ใช้บริการ TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “ผู้ใช้บริการ”) อีกฝ่ายหนึ่ง เพื่อใช้บริการ TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “บริการ”) โดยผู้ใช้บริการสามารถทําธุรกรรมการเงินด้วยเงินอิเล็กทรอนิกส์ของบริษัท (ซึ่งต่อไปนี้จะเรียกว่า “เงิน”) บัตรเครดิต บัตรเดบิต หรือบัตรอิเล็กทรอนิกส์ที่ผูกกับบัญชีของผู้ใช้บริการ ทั้งการเติม-จ่าย-โอน-ถอน ได้อย่างสะดวก ผ่านแอปพลิเคชัน TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “แอปพลิเคชัน”) หรือผ่านทาง Prepaid Card ของบริษัท เช่น WeCard หรือบัตรอื่นใดที่บริษัทออกร่วมกับนิติบุคคลอื่น ผู้ใช้บริการมีหน้าที่ทําความเข้าใจอย่างละเอียดก่อนการใช้บริการ และคอยตรวจสอบเงื่อนไขการให้บริการนี้อย่างสม่ำเสมอ หากมีข้อสงสัยเกี่ยวกับบริการ ผู้ใช้บริการสามารถติดต่อสอบถามได้ผ่านช่องทาง TrueMoney Customer Care 1240 หรือช่องทางอื่นตามที่บริษัทกำหนด \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 Text('1. ข้อกําหนดทั่วไป',
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                 Text(
//                     '1.1 ผู้ใช้บริการตกลงที่จะปฏิบัติและผูกพันตามเงื่อนไขการให้บริการ ซึ่งการใช้บริการของผู้ใช้บริการถือเป็นการยอมรับเงื่อนไขการให้บริการนี้ โดยบริษัทอาจแก้ไข หรือเพิ่มเติมเงื่อนไขการให้บริการได้ ไม่ว่าในเวลาใด โดยบริษัทจะแจ้งให้ผู้ใช้บริการทราบ และการที่ผู้ใช้บริการใช้บริการต่อไปภายหลังจากที่มีการแก้ไข หรือเพิ่มเติมดังกล่าว ย่อมถือเป็นการยอมรับการแก้ไข หรือเพิ่มเติมในแต่ละครั้ง\n'
//                     '1.2 เว้นแต่จะได้มีการแจ้ง หรือกําหนดไว้เป็นอย่างอื่น คุณลักษณะใหม่ ๆ ที่ได้แก้ไข เพิ่มเติม หรือปรับปรุงในบริการให้ถือว่าอยู่ภายใต้เงื่อนไขการให้บริการฉบับนี้ทั้งสิ้น \n'
//                     '1.3 บริษัทสงวนสิทธิในการปรับปรุงหรือยกเลิกการบริการ หรือส่วนใดส่วนหนึ่งของบริการ ไม่ว่าจะเป็นการชั่วคราว หรือตลอดไปได้ตลอดเวลา โดยบริษัทจะแจ้งให้ทราบล่วงหน้า \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 Text('2. การใช้บริการ',
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                 Text(
//                     '2.1 ในการสมัครใช้บริการ ผู้ใช้บริการจะต้องเปิดบัญชี TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “บัญชี”) เพื่อใช้ในการทํารายการต่าง ๆ อันเกี่ยวเนื่องกับการใช้บริการ โดยผู้ใช้บริการต้องดำเนินการดังต่อไปนี้ \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 ListTile(
//                   title: Text(
//                       '2.1.1 ผู้ใช้บริการที่มีสัญชาติไทย ต้องกรอกชื่อ-นามสกุล อีเมล หมายเลขโทรศัพท์เคลื่อนที่ ที่อยู่ อาชีพ สถานที่ทำงาน วันเดือนปีเกิด และหมายเลขบัตรประจําตัวประชาชนของตนเอง รวมทั้งข้อมูลอื่น ๆ ตามที่บริษัทกำหนด หรือจะกำหนดต่อไป เพื่อให้เป็นไปตามวัตถุประสงค์ในการให้บริการของบริษัทและ/หรือกฎหมายที่เกี่ยวข้อง \n'),
//                 ),
//                 ListTile(
//                   title: Text(
//                       '2.1.2 ผู้ใช้บริการที่ถือสัญชาติอื่นนอกจากสัญชาติไทย (ซึ่งต่อไปนี้จะเรียกว่า “ชาวต่างชาติ”) ต้องกรอก ประเภทวีซ่าเพื่อการพำนักในประเทศไทย สถานที่พำนักในประเทศไทย รูปถ่ายหนังสือเดินทางที่มีอายุใช้งานเหลือมากกว่า 6 (หก) เดือน รวมทั้งข้อมูลอื่น ๆ ตามที่บริษัทกำหนด หรือจะกำหนดต่อไป เพื่อให้เป็นไปตามวัตถุประสงค์ในการให้บริการของบริษัทและ/หรือกฎหมายที่เกี่ยวข้อง \n'),
//                 ),
//                 Text(
//                     'เมื่อผู้ใช้บริการกรอกข้อมูลข้างต้นแล้ว ผู้ใช้บริการจะต้องกําหนดตัวอักษร อักขระ ตัวเลข สัญลักษณ์ รวมถึงข้อมูลทางชีวภาพ ตามที่บริษัทกำหนด (ซึ่งต่อไปนี้จะเรียกว่า “รหัสผ่าน”) โดยสามารถแก้ไขเปลี่ยนแปลงรหัสผ่านนี้ได้เองในภายหลังตามข้อกําหนดและเงื่อนไขของบริษัท \n\n'
//                     'ทั้งนี้ บริษัทขอสงวนสิทธิในการปฏิเสธการเปิดใช้บริการ ให้บริการ และ/หรือทำธุรกรรมกับผู้ใช้บริการที่ปกปิดชื่อจริง หรือ ใช้นามแฝง หรือเมื่อบริษัทตรวจพบว่าชื่อที่ผู้ใช้บริการลงทะเบียนไว้เป็นชื่อที่ไม่ถูกต้อง แท้จริงและเป็นปัจจุบัน ทั้งนี้ ในกรณีที่ผู้ใช้บริการเป็นชาวต่างชาติ บริษัทขอสงวนสิทธิปฏิเสธการเปิดใช้บริการ ให้บริการ และ/หรือทำธุรกรรมกับผู้ใช้บริการที่มีสัญชาติ ถิ่นที่อยู่ หรืออาชีพบางประเภทตามที่บริษัทกำหนด ทั้งนี้ ผู้ใช้บริการตกลงและยอมรับว่าการพิจารณาอนุมัติการสมัครใช้บริการขึ้นอยู่กับดุลยพินิจของบริษัทแต่เพียงฝ่ายเดียวเท่านั้น \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 Text(
//                     '2.2 ผู้ใช้บริการจะต้องเก็บรักษารหัสผ่าน และข้อมูลที่ใช้ในการสมัครใช้บริการไว้เป็นความลับเฉพาะตัวของผู้ใช้บริการเท่านั้น และไม่เปิดเผย หรือกระทำการใด ๆ ที่อาจทำให้ผู้อื่นทราบรหัสผ่าน และ/หรือข้อมูลดังกล่าว ผู้ใช้บริการยอมรับว่าหากมีการทํารายการใด ๆ โดยใช้รหัสผ่านของผู้ใช้บริการ ให้ถือว่าเป็นการกระทําโดยตัวของผู้ใช้บริการเองทุกประการ โดยบริษัทไม่ต้องรับผิดชอบในความเสียหายที่เกิดขึ้นจากการทํารายการใด ๆ ภายใต้บัญชีของผู้ใช้บริการ จากการใช้รหัสผ่านดังกล่าว \n'
//                     '2.3 ในกรณีที่ผู้ใช้บริการใช้รหัสผ่านทํารายการใด ๆ อันเกี่ยวเนื่องกับการใช้บริการเสร็จสิ้นสมบูรณ์แล้ว ผู้ใช้บริการยอมรับว่าไม่สามารถยกเลิก เพิกถอน เปลี่ยนแปลง หรือแก้ไขรายการดังกล่าวได้ และผู้ใช้บริการต้องผูกพันตามรายการดังกล่าวทุกประการ',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//               ],
//             )));
//   }
// }

// class ProfileScreen extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'เงื่อนไขการใช้งาน',
//         home: Scaffold(
//             appBar: AppBar(
//               title: new Center(
//                   child: new Text('เงื่อนไขการใช้งาน',
//                       textAlign: TextAlign.center)),
//             ),
//             body: ListView(
//               padding: EdgeInsets.all(10),
//               // alignment: FractionalOffset(),
//               children: <Widget>[
//                 Text('เงื่อนไขการให้บริการ TrueMoney Wallet \n',
//                     style:
//                         TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
//                 Text(
//                     'เงื่อนไขการให้บริการ TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “เงื่อนไขการให้บริการ”) นี้เป็นข้อตกลงระหว่าง บริษัท ทรู มันนี่ จํากัด ซึ่งมีสำนักงานใหญ่ตั้งอยู่เลขที่ 89 อาคารเอไอเอ แคปปิตอล เซ็นเตอร์ ชั้น 18-19 ถนนรัชดาภิเษก แขวงดินแดง เขตดินแดง กรุงเทพมหานคร (ซึ่งต่อไปนี้จะเรียกว่า “บริษัท”) ฝ่ายหนึ่ง กับ ผู้ใช้บริการ TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “ผู้ใช้บริการ”) อีกฝ่ายหนึ่ง เพื่อใช้บริการ TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “บริการ”) โดยผู้ใช้บริการสามารถทําธุรกรรมการเงินด้วยเงินอิเล็กทรอนิกส์ของบริษัท (ซึ่งต่อไปนี้จะเรียกว่า “เงิน”) บัตรเครดิต บัตรเดบิต หรือบัตรอิเล็กทรอนิกส์ที่ผูกกับบัญชีของผู้ใช้บริการ ทั้งการเติม-จ่าย-โอน-ถอน ได้อย่างสะดวก ผ่านแอปพลิเคชัน TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “แอปพลิเคชัน”) หรือผ่านทาง Prepaid Card ของบริษัท เช่น WeCard หรือบัตรอื่นใดที่บริษัทออกร่วมกับนิติบุคคลอื่น ผู้ใช้บริการมีหน้าที่ทําความเข้าใจอย่างละเอียดก่อนการใช้บริการ และคอยตรวจสอบเงื่อนไขการให้บริการนี้อย่างสม่ำเสมอ หากมีข้อสงสัยเกี่ยวกับบริการ ผู้ใช้บริการสามารถติดต่อสอบถามได้ผ่านช่องทาง TrueMoney Customer Care 1240 หรือช่องทางอื่นตามที่บริษัทกำหนด \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 Text('1. ข้อกําหนดทั่วไป',
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                 Text(
//                     '1.1 ผู้ใช้บริการตกลงที่จะปฏิบัติและผูกพันตามเงื่อนไขการให้บริการ ซึ่งการใช้บริการของผู้ใช้บริการถือเป็นการยอมรับเงื่อนไขการให้บริการนี้ โดยบริษัทอาจแก้ไข หรือเพิ่มเติมเงื่อนไขการให้บริการได้ ไม่ว่าในเวลาใด โดยบริษัทจะแจ้งให้ผู้ใช้บริการทราบ และการที่ผู้ใช้บริการใช้บริการต่อไปภายหลังจากที่มีการแก้ไข หรือเพิ่มเติมดังกล่าว ย่อมถือเป็นการยอมรับการแก้ไข หรือเพิ่มเติมในแต่ละครั้ง\n'
//                     '1.2 เว้นแต่จะได้มีการแจ้ง หรือกําหนดไว้เป็นอย่างอื่น คุณลักษณะใหม่ ๆ ที่ได้แก้ไข เพิ่มเติม หรือปรับปรุงในบริการให้ถือว่าอยู่ภายใต้เงื่อนไขการให้บริการฉบับนี้ทั้งสิ้น \n'
//                     '1.3 บริษัทสงวนสิทธิในการปรับปรุงหรือยกเลิกการบริการ หรือส่วนใดส่วนหนึ่งของบริการ ไม่ว่าจะเป็นการชั่วคราว หรือตลอดไปได้ตลอดเวลา โดยบริษัทจะแจ้งให้ทราบล่วงหน้า \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 Text('2. การใช้บริการ',
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                 Text(
//                     '2.1 ในการสมัครใช้บริการ ผู้ใช้บริการจะต้องเปิดบัญชี TrueMoney Wallet (ซึ่งต่อไปนี้จะเรียกว่า “บัญชี”) เพื่อใช้ในการทํารายการต่าง ๆ อันเกี่ยวเนื่องกับการใช้บริการ โดยผู้ใช้บริการต้องดำเนินการดังต่อไปนี้ \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 ListTile(
//                   title: Text(
//                       '2.1.1 ผู้ใช้บริการที่มีสัญชาติไทย ต้องกรอกชื่อ-นามสกุล อีเมล หมายเลขโทรศัพท์เคลื่อนที่ ที่อยู่ อาชีพ สถานที่ทำงาน วันเดือนปีเกิด และหมายเลขบัตรประจําตัวประชาชนของตนเอง รวมทั้งข้อมูลอื่น ๆ ตามที่บริษัทกำหนด หรือจะกำหนดต่อไป เพื่อให้เป็นไปตามวัตถุประสงค์ในการให้บริการของบริษัทและ/หรือกฎหมายที่เกี่ยวข้อง \n'),
//                 ),
//                 ListTile(
//                   title: Text(
//                       '2.1.2 ผู้ใช้บริการที่ถือสัญชาติอื่นนอกจากสัญชาติไทย (ซึ่งต่อไปนี้จะเรียกว่า “ชาวต่างชาติ”) ต้องกรอก ประเภทวีซ่าเพื่อการพำนักในประเทศไทย สถานที่พำนักในประเทศไทย รูปถ่ายหนังสือเดินทางที่มีอายุใช้งานเหลือมากกว่า 6 (หก) เดือน รวมทั้งข้อมูลอื่น ๆ ตามที่บริษัทกำหนด หรือจะกำหนดต่อไป เพื่อให้เป็นไปตามวัตถุประสงค์ในการให้บริการของบริษัทและ/หรือกฎหมายที่เกี่ยวข้อง \n'),
//                 ),
//                 Text(
//                     'เมื่อผู้ใช้บริการกรอกข้อมูลข้างต้นแล้ว ผู้ใช้บริการจะต้องกําหนดตัวอักษร อักขระ ตัวเลข สัญลักษณ์ รวมถึงข้อมูลทางชีวภาพ ตามที่บริษัทกำหนด (ซึ่งต่อไปนี้จะเรียกว่า “รหัสผ่าน”) โดยสามารถแก้ไขเปลี่ยนแปลงรหัสผ่านนี้ได้เองในภายหลังตามข้อกําหนดและเงื่อนไขของบริษัท \n\n'
//                     'ทั้งนี้ บริษัทขอสงวนสิทธิในการปฏิเสธการเปิดใช้บริการ ให้บริการ และ/หรือทำธุรกรรมกับผู้ใช้บริการที่ปกปิดชื่อจริง หรือ ใช้นามแฝง หรือเมื่อบริษัทตรวจพบว่าชื่อที่ผู้ใช้บริการลงทะเบียนไว้เป็นชื่อที่ไม่ถูกต้อง แท้จริงและเป็นปัจจุบัน ทั้งนี้ ในกรณีที่ผู้ใช้บริการเป็นชาวต่างชาติ บริษัทขอสงวนสิทธิปฏิเสธการเปิดใช้บริการ ให้บริการ และ/หรือทำธุรกรรมกับผู้ใช้บริการที่มีสัญชาติ ถิ่นที่อยู่ หรืออาชีพบางประเภทตามที่บริษัทกำหนด ทั้งนี้ ผู้ใช้บริการตกลงและยอมรับว่าการพิจารณาอนุมัติการสมัครใช้บริการขึ้นอยู่กับดุลยพินิจของบริษัทแต่เพียงฝ่ายเดียวเท่านั้น \n',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//                 Text(
//                     '2.2 ผู้ใช้บริการจะต้องเก็บรักษารหัสผ่าน และข้อมูลที่ใช้ในการสมัครใช้บริการไว้เป็นความลับเฉพาะตัวของผู้ใช้บริการเท่านั้น และไม่เปิดเผย หรือกระทำการใด ๆ ที่อาจทำให้ผู้อื่นทราบรหัสผ่าน และ/หรือข้อมูลดังกล่าว ผู้ใช้บริการยอมรับว่าหากมีการทํารายการใด ๆ โดยใช้รหัสผ่านของผู้ใช้บริการ ให้ถือว่าเป็นการกระทําโดยตัวของผู้ใช้บริการเองทุกประการ โดยบริษัทไม่ต้องรับผิดชอบในความเสียหายที่เกิดขึ้นจากการทํารายการใด ๆ ภายใต้บัญชีของผู้ใช้บริการ จากการใช้รหัสผ่านดังกล่าว \n'
//                     '2.3 ในกรณีที่ผู้ใช้บริการใช้รหัสผ่านทํารายการใด ๆ อันเกี่ยวเนื่องกับการใช้บริการเสร็จสิ้นสมบูรณ์แล้ว ผู้ใช้บริการยอมรับว่าไม่สามารถยกเลิก เพิกถอน เปลี่ยนแปลง หรือแก้ไขรายการดังกล่าวได้ และผู้ใช้บริการต้องผูกพันตามรายการดังกล่าวทุกประการ',
//                     style:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
//               ],
//             )));
//   }
// }
