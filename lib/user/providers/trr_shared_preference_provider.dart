import '../../base_class/models/ai_base_model.dart';
import '../models/trr_shared_preference.dart';
import '../models/trr_preference_data.dart';

class TrrSharedPreferenceProvider extends AiBasicItem {
  // Create and initialized preference
  final TrrSharedPreference prefObj = TrrSharedPreference.instance..initial();

  Future<dynamic> loadPreference(TrrPreferenceData aPreferenceData) async {
    if (aPreferenceData != null) {
      aPreferenceData.retrieveDeviceToken(); // get device token
      bool result = await prefObj.exportDataTo(aPreferenceData);
      return result;
    }
    return false;
  }

  Future<dynamic> savePreference(TrrPreferenceData aPreferenceData) async {
    if (aPreferenceData != null) {
      bool result = await prefObj.saveToDeviceFrom(aPreferenceData);
      return result;
    } else
      return false;
  }

  Future<void> clearDevicePreference() async {
    return await prefObj.clearDevicePreference();
  }
}
