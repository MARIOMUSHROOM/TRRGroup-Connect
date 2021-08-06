// import '../queue_utils.dart' as qutil;
import 'package:flutter/material.dart';
import 'sugarcane_queue_page.dart';
import 'truck_queue_page.dart';
import '../queue_const.dart' as qcons;
import '../../../global_const.dart' as cons;
import '../models/sugarcane_queue_model.dart';
import '../models/truck_queue_model.dart';

class QueueHomePage extends StatefulWidget {
  @override
  _QueueHomePageState createState() => _QueueHomePageState();
}

class _QueueHomePageState extends State<QueueHomePage> with SingleTickerProviderStateMixin {
  double _dvHeight;
  double _dvWidth;

  qcons.QueuePageType currentPage = qcons.QueuePageType.Sugarcane;

  _showSugarcaneQueuePage() {
    setState(() {
      currentPage = qcons.QueuePageType.Sugarcane;
    });
  }

  _showTruckQueuePage() {
    setState(() {
      currentPage = qcons.QueuePageType.Truck;
    });
  }

  @override
  Widget build(BuildContext context) {
    _dvHeight = MediaQuery.of(context).size.height;
    _dvWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: qcons.kAppBarColor,
          centerTitle: true,
          title: Text('คิวอ้อย', style: TextStyle(fontSize: 26)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: cons.kPageBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  QueuePageButton(
                    deviceHeight: _dvHeight,
                    deviceWidth: _dvWidth,
                    imageAsset: 'assets/images/queue/sugarcane_queue.png',
                    label: 'คิวอ้อย',
                    onTap: _showSugarcaneQueuePage,
                    isPageActive: currentPage == qcons.QueuePageType.Sugarcane,
                  ),
                  QueuePageButton(
                    deviceHeight: _dvHeight,
                    deviceWidth: _dvWidth,
                    imageAsset: 'assets/images/queue/truck.png',
                    label: 'รถบรรทุก',
                    onTap: _showTruckQueuePage,
                    isPageActive: currentPage == qcons.QueuePageType.Truck,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: cons.kPageBackgroundColor,
                child: (currentPage == qcons.QueuePageType.Sugarcane)
                    ? SugarcaneQueuePage(sugarcaneQueue: SugarcaneQueueModel.instance)
                    : TruckQueuePage(truckQueueList: dummyTruckQueueList),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QueuePageButton extends StatelessWidget {
  final double deviceWidth;
  final double deviceHeight;
  final String imageAsset;
  final String label;
  final Function onTap;
  final bool isPageActive;

  QueuePageButton({
    this.deviceHeight,
    this.deviceWidth,
    this.imageAsset,
    this.label,
    this.onTap,
    this.isPageActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth * 0.44,
      // height: deviceHeight * 0.11,
      margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 7),
      child: ElevatedButton(
        onPressed: this.onTap,
        style: ElevatedButton.styleFrom(
          primary: isPageActive ? qcons.kGoldColor : Colors.white,
          onPrimary: qcons.kGoldColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  imageAsset,
                  color: isPageActive ? Colors.white : qcons.kGoldColor,
                  width: 60,
                  height: 60,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: isPageActive ? Colors.white : qcons.kGoldColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
