import 'package:flutter/material.dart';
import '../../../base_class/pages/ai_base_page.dart';
import '../models/home_icon_model.dart';
import '../home_const.dart' as homeCons;
import '../home_util.dart' as homeUtil;
import '../../../global_utils.dart' as util;

// ignore: must_be_immutable
class HomeMenuGridWidget extends AiBaseStatelessWidget {
  final HomeIconModelList iconList;
  final homeUtil.OnMenuIconTap onIconTap;

  HomeMenuGridWidget({Key key, @required this.iconList, @required this.onIconTap}) : super(key: key);

  @override
  Widget internalBuild(BuildContext context) {
    int milliseconds = 0;
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          milliseconds += 400;
          return HomeMenuIconItemButtonWidget(
            iconItem: iconList.iconItems[index],
            onIconTap: this.onIconTap,
            animatedMilliSeconds: milliseconds,
          );
        },
        childCount: iconList.iconItems.length,
      ),
    );
  }
}

//ignore: must_be_immutable
class HomeMenuIconItemButtonWidget extends StatefulWidget {
  final HomeIconModelItem iconItem;
  final homeUtil.OnMenuIconTap onIconTap;
  final int animatedMilliSeconds;

  HomeMenuIconItemButtonWidget({
    Key key,
    @required this.iconItem,
    @required this.onIconTap,
    this.animatedMilliSeconds,
  }) : super(key: key);

  @override
  _HomeMenuIconItemButtonWidgetState createState() => _HomeMenuIconItemButtonWidgetState();
}

class _HomeMenuIconItemButtonWidgetState extends State<HomeMenuIconItemButtonWidget> {
  // Flag to check that widget was builded
  static bool isAlreadyBuilded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // set flag to true after widget builded
      _HomeMenuIconItemButtonWidgetState.isAlreadyBuilded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: () => widget.onIconTap(widget.iconItem.ident),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: homeCons.kIconBgColor,
          ),
          child: (!_HomeMenuIconItemButtonWidgetState.isAlreadyBuilded) // Show animation only once when build widget
              ? util.zoomOutAnimation(
                  _iconButton(),
                  aMilliseconds: widget.animatedMilliSeconds,
                  aStartSize: 0,
                  aEndSize: 1,
                  aCurve: Curves.elasticInOut,
                )
              : _iconButton(),
        ),
      ),
    );
  }

  Widget _iconButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(child: Image(image: AssetImage(widget.iconItem.image), fit: BoxFit.contain, height: 48, color: widget.iconItem.imageColor)),
        Text(widget.iconItem.caption, style: TextStyle(color: homeCons.kSolidBlueColor, fontSize: 19, height: 0.5), textAlign: TextAlign.center),
      ],
    );
  }
}
