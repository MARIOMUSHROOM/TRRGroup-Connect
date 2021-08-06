import 'package:flutter/material.dart';
import '../models/rainfall_plot_model.dart';
import '../../../global_utils.dart' as util;
import '../../../global_const.dart' as cons;

typedef NotifyOnPlotItemTapCallBack = void Function(RainfallPlotItem tappedPlotItem);

// ignore: must_be_immutable
class RainfallPlotItemWidget extends StatefulWidget {
  final RainfallPlotItem plotItem;
  final NotifyOnPlotItemTapCallBack onPlotTapped;
  final int animDuration;

  RainfallPlotItemWidget({Key key, @required this.plotItem, @required this.onPlotTapped, this.animDuration = 0}) : super(key: key);

  @override
  _RainfallPlotItemWidgetState createState() => _RainfallPlotItemWidgetState();
}

class _RainfallPlotItemWidgetState extends State<RainfallPlotItemWidget> {
  static bool isAlreadyBuild = false;
  bool isAlreadyBuilded = false;

  _doOnPlotItemTap(RainfallPlotItem selectPlot) {
    if (selectPlot != null && widget.onPlotTapped != null) widget.onPlotTapped(selectPlot);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _RainfallPlotItemWidgetState.isAlreadyBuild = true;
      this.isAlreadyBuilded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return !(_RainfallPlotItemWidgetState.isAlreadyBuild)
    return !(this.isAlreadyBuilded)
        ? util.zoomInAnimation(
            _rainfallPlotItem(),
            aStartSize: 0,
            aIsFadeWhenDone: false,
            aMilliseconds: widget.animDuration,
            aCurve: Curves.elasticInOut,
          )
        : _rainfallPlotItem();
  }

  Widget _rainfallPlotItem() {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(offset: Offset(0, 2), color: Colors.grey[500], blurRadius: 6),
        ],
      ),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            _doOnPlotItemTap(widget.plotItem);
          },
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder: AssetImage(widget.plotItem.placeHolderPlotImage),
                image: NetworkImage(widget.plotItem.plotImageUrl),
                fit: BoxFit.cover,
                imageErrorBuilder: (_, __, ___) {
                  return Image(image: AssetImage(widget.plotItem.placeHolderPlotImage), fit: BoxFit.cover);
                },
              ),
            ),
          ),
        ),
        footer: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: cons.kGoldColor),
            width: 90,
            child: Text(
              'แปลงที่ ${widget.plotItem.plotNumber}',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
