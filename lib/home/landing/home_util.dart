import './models/home_icon_model.dart';
import './home_const.dart';

typedef OnMenuIconTap = void Function(HomeIconIdent tappedIcon);
typedef OnControllerVerifiedPermission = void Function(bool actionAllow);

String weatherCaptionByID(int aWeatherID) {
  String result = '';
  if (kWeatherCodeLabelMap.containsKey(aWeatherID)) result = kWeatherCodeLabelMap[aWeatherID];
  return result;
}
