import 'package:flutter/material.dart';

import '../../base_class/models/ai_base_model.dart';
import '../../home/landing/models/home_icon_model.dart';

class BasicMenuActionPermissionModel extends AiBasicItem {
  BasicMenuActionPermissionModel() {
    internalPreparePermissionSet();
  }

  @protected
  Set<HomeIconIdent> allowActionSetObj;
  // Set<HomeIconIdent> get allowActionSet => allowActionSetObj;

  @protected
  void internalPreparePermissionSet() {}

  bool isActionAllow(HomeIconIdent aActionIdent) => allowActionSetObj.contains(aActionIdent);
}

class GeneralUserMenuActionPermissionModel extends BasicMenuActionPermissionModel {
  @override
  void internalPreparePermissionSet() {
    allowActionSetObj = {
      HomeIconIdent.CompanyInfo,
      HomeIconIdent.MyPlot,
      HomeIconIdent.Activity,
      HomeIconIdent.Report,
      HomeIconIdent.Queue,
      HomeIconIdent.Ccs,
      HomeIconIdent.Rain,
      HomeIconIdent.Contractor,
      HomeIconIdent.Account,
      HomeIconIdent.Radio,
      HomeIconIdent.Magazine,
      HomeIconIdent.ContactUs,
    };
  }
}

class GuestUserMenuActionPermissionModel extends BasicMenuActionPermissionModel {
  @override
  void internalPreparePermissionSet() {
    allowActionSetObj = {
      HomeIconIdent.CompanyInfo,
      HomeIconIdent.Radio,
      HomeIconIdent.Magazine,
      HomeIconIdent.ContactUs,
    };
  }
}
