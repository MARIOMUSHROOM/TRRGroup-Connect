import '../queue_const.dart';

class SugarcaneTypeTruckModel {
  QueueSugarcaneType sugarcaneType = QueueSugarcaneType.FreshSugarcane;
  String sugarCaneTypeName;
  int truckCount;

  String _iconImage = '';

  String get iconImage {
    switch (sugarcaneType) {
      case QueueSugarcaneType.BurnedSugarcane:
        _iconImage = 'assets/images/queue/burned_sugarcane.png';
        break;
      case QueueSugarcaneType.SugarcanePiece:
        _iconImage = 'assets/images/queue/sugarcane_peice.png';
        break;
      case QueueSugarcaneType.FreshSugarcane:
        _iconImage = 'assets/images/queue/fresh_sugarcane.png';
        break;
      default:
        _iconImage = 'assets/images/queue/fresh_sugarcane.png';
    }
    return _iconImage;
  }

  SugarcaneTypeTruckModel({this.sugarCaneTypeName, this.sugarcaneType, this.truckCount});
}
