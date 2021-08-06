import '../../base_class/models/ai_base_model.dart';
import './special_user_json_model.dart';
import './guest_user_json_model.dart';
import '../../profile/models/profile_json_model.dart';

class BasicPersonDataModel extends AiBasicItem {}

class NormalPersonDataModel extends BasicPersonDataModel {
  final profileJsonObj = ProfileJsonModel();

  @override
  void internalCopyFrom(aSource) {
    super.internalCopyFrom(aSource);
    NormalPersonDataModel s = aSource as NormalPersonDataModel;
    profileJsonObj.copyFrom(s.profileJsonObj);
  }
}

class SpecialPersonfDataModel extends NormalPersonDataModel {
  final specialJsonObj = SpecialUserJsonModel();

  @override
  void internalCopyFrom(aSource) {
    super.internalCopyFrom(aSource);
    SpecialPersonfDataModel s = aSource as SpecialPersonfDataModel;
    profileJsonObj.copyFrom(s.profileJsonObj);
    specialJsonObj.copyFrom(s.specialJsonObj);
  }
}

class GuestPersonDataModel extends BasicPersonDataModel {
  final guestJsonObj = GuestUserJsonModel();

  @override
  void internalCopyFrom(aSource) {
    super.internalCopyFrom(aSource);
    GuestPersonDataModel s = aSource as GuestPersonDataModel;
    guestJsonObj.copyFrom(s.guestJsonObj);
  }
}
