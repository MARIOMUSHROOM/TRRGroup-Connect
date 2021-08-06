import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../landing/models/home_activity_model.dart';
import '../../../basic/pages/trr_basic_page.dart';
import '../../../base_class/pages/ai_base_page.dart';
import '../../landing/home_const.dart' as homeCons;
import '../../../global_utils.dart' as util;

// ignore: must_be_immutable
class HomeActivityListWidget extends TrrBasicPageStatefulWidget {
  final HomeActivityModelList activities;

  HomeActivityListWidget({Key key, @required this.activities}) : super(key: key);

  @override
  _HomeActivityListWidgetState createState() => _HomeActivityListWidgetState();
}

class _HomeActivityListWidgetState extends TrrBasicPageState<HomeActivityListWidget> {
  var delay = 0;
  static bool isAlreadyBuilded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Mark widget as builded
      _HomeActivityListWidgetState.isAlreadyBuilded = true;
    });
  }

  @override
  Widget internalBuild(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('กิจกรรม', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: homeCons.kGoldColor)),
          Container(
            color: Colors.white,
            height: dvHeight * 0.39,
            child: SingleChildScrollView(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.activities.activityItems.length,
                itemBuilder: (ctx, id) {
                  delay += 100;
                  return Container(
                    child: Column(
                      children: [
                        (!_HomeActivityListWidgetState.isAlreadyBuilded) // Show animation once
                            ? util.horizontalAnimation(
                                _activityItem(id),
                                aMilliseconds: 1000 + delay,
                              )
                            : _activityItem(id),

                        // Devider
                        if (id < widget.activities.activityItems.length - 1)
                          Container(
                            child: Divider(thickness: 0.15, color: Colors.grey),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityItem(int aActivityIndex) => HomeActivityItemWidget(activityItem: widget.activities.activityItems[aActivityIndex]);
}

// ignore: must_be_immutable
class HomeActivityItemWidget extends AiBaseStatelessWidget {
  final HomeActivityModelItem activityItem;

  HomeActivityItemWidget({Key key, this.activityItem}) : super(key: key);

  @override
  Widget internalBuild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: 90,
        width: dvWidth,
        child: Container(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                  child: Container(
                    height: 90,
                    // width: 100,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                      // image: DecorationImage(image: AssetImage(activityItem.activityImage), fit: BoxFit.contain),
                    ),
                    child: Image(image: AssetImage(activityItem.activityImage), fit: BoxFit.fitWidth, width: 30),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(activityItem.content, maxLines: 2, style: TextStyle(height: 1.05)),
                      Spacer(),
                      Text('${DateFormat('dd MMM yyyy', 'th').format(activityItem.activityDate)}',
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
