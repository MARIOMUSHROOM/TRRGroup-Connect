import 'package:ai_flutter/home/income_expense/income_expense_tab_page.dart';
import 'package:ai_flutter/home/report/pages/report_plot_list_page.dart';
import 'package:ai_flutter/home/station/plot_info_tab_page.dart';
import 'package:ai_flutter/home/test_bloc/test_bloc_page.dart';
import 'package:ai_flutter/notify/notify.dart';

import 'package:flutter/material.dart';
import 'package:ai_flutter/home/activity/type_page.dart';
import 'package:ai_flutter/home/company/info.dart';
import 'package:ai_flutter/home/journal/journal_page.dart';
import '../models/home_icon_model.dart';

import '../../../basic/models/trr_object.dart';
import '../../queue/pages/queue_home_page.dart';
// import '../../report/pages/report_home_page.dart';
import '../../rainfall/pages/rainfall_home_page.dart';
import '../../company/info.dart';
import '../../ccs/pages/ccs_home_page.dart';
import '../../contractor/pages/contractor_home_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_util.dart' as homeUtil;

// Test Bloc
import '../../../test_nav_bloc/test_chat_notification_bloc/bloc/test_chat_notification_bloc.dart';
// import '../../../test_nav_bloc/test_notification_bloc/bloc/test_notification_bloc.dart';
// import '../../../bloc/weather/bloc/global_weather_bloc.dart';

class HomeMenuNavigateController {
  final BuildContext context;
  final TrrData globalTrrDataObj = TrrData.instance;
  homeUtil.OnControllerVerifiedPermission onVerifiedPermission;

  HomeMenuNavigateController({this.context, this.onVerifiedPermission});

  void onHomeMenuIconTap(HomeIconIdent iconIdent) {
    // var allow = onVerifiedPermission ?? globalTrrDataObj.userDataObj.menuPermission.isActionAllow(iconIdent);
    // onVerifiedPermission ?? onVerifiedPermission(allow);
    // if (!allow) return;

    if (!globalTrrDataObj.userDataObj.menuPermission.isActionAllow(iconIdent)) {
      if (onVerifiedPermission != null) onVerifiedPermission(false);
      return;
    }

    Widget page;
    switch (iconIdent) {
      case HomeIconIdent.CompanyInfo:
        page = CompanyInfo();
        break;
      case HomeIconIdent.MyPlot:
        page = PlotInfoTabPage();
        break;
      case HomeIconIdent.Activity:
        page = TypePage();
        break;
      case HomeIconIdent.Report:
        page = ReportPlotListPage();
        break;
      case HomeIconIdent.Queue:
        page = QueueHomePage();
        break;
      case HomeIconIdent.Ccs:
        page = CcsHomePage(dataObj: globalTrrDataObj);
        break;
      case HomeIconIdent.Rain:
        page = RainfallHomePage(dataObj: globalTrrDataObj);
        break;
      case HomeIconIdent.Contractor:
        page = ContractorHomePage(dataObj: globalTrrDataObj);
        break;
      case HomeIconIdent.Account:
        page = IncomeExpenseTabPage();
        break;
      case HomeIconIdent.Magazine:
        page = JournalPage();
        break;
      case HomeIconIdent.Notification:
        page = NotifyPage();
        break;
      case HomeIconIdent.Radio:
        // TestNotificationBloc notifyBloc = BlocProvider.of<TestNotificationBloc>(context);
        // notifyBloc.add(TestNoficationNewAlertEvent());
        TestChatNotificationBloc chatBloc =
            BlocProvider.of<TestChatNotificationBloc>(context);
        chatBloc.add(TestChatNotificationSendMessageEvent());
        break;
      default:
        break;
    }
    if (page != null) navigateToPage(this.context, page);
  }

  void navigateToPage(BuildContext aContext, Widget aPage) {
    Navigator.of(aContext).push(MaterialPageRoute(builder: (_) => aPage));
  }
}
