import 'package:ai_flutter/home/activity/widget/app_bar_widget.dart';
import 'package:ai_flutter/home/station/plot_list_page.dart';
import 'package:ai_flutter/home/station/plot_map_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ai_flutter/home/station/test/test_data.dart';

class PlotInfoTabPage extends StatefulWidget {
  @override
  _PlotInfoTabPageState createState() => _PlotInfoTabPageState();
}

class _PlotInfoTabPageState extends State<PlotInfoTabPage> {
  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        appBar: AppBar(),
        titleText: 'แปลงของฉัน',
        actionOn: false,
      ),
      body: DefaultTabController(
        length: tabs.length,
        child: Builder(builder: (context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              setState(() {
                indexSelected = tabController.index;
              });
              print(indexSelected);
            }
          });
          return Column(
            children: <Widget>[
              Container(
                // color: Colors.green,
                constraints: BoxConstraints.expand(height: 120),
                color: Colors.transparent,
                // decoration: BoxDecoration(
                //   color: Colors.transparent,
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.grey.withOpacity(0.5),
                //       spreadRadius: 5,
                //       blurRadius: 7,
                //       offset: Offset(0, 3), // changes position of shadow
                //     ),
                //   ],
                // ),
                child: TabBar(
                  // isScrollable: true,
                  // controller: tabController,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  // tabs: tabs,
                  tabs: [
                    TabbarWithImageWidget(
                      index: 0,
                      indexSelected: indexSelected,
                      imageActivePath: "assets/images/station/Artboard_67.png",
                      imageNonActivePath:
                          "assets/images/station/Artboard_70.png",
                    ),
                    TabbarWithImageWidget(
                      index: 1,
                      indexSelected: indexSelected,
                      imageActivePath: "assets/images/station/Artboard_69.png",
                      imageNonActivePath:
                          "assets/images/station/Artboard_68.png",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      PlotListPage(),
                      // Text("data"),
                      PlotMapPage(),
                      // Text("data"), Text("data"),
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

const List<TabCustomWithIcon> tabs = <TabCustomWithIcon>[
  TabCustomWithIcon(
    text: 'แปลงอ้อย',
    icon: null,
  ),
  TabCustomWithIcon(
    text: 'แปลงอ้อยทั้งหมด',
    icon: null,
  ),
];

class TabCustomWithIcon extends StatelessWidget {
  const TabCustomWithIcon({
    Key key,
    @required this.text,
    @required this.icon,
  }) : super(key: key);
  final String text;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // constraints: BoxConstraints.expand(width: 70),
      child: Column(
        children: [
          Tab(
            // text: text,
            icon: icon == null
                ? Icon(
                    Icons.image_outlined,
                    size: 40,
                  )
                : icon,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: GoogleFonts.kanit(),
          ),
        ],
      ),
    );
  }
}

class TabbarWithImageWidget extends StatelessWidget {
  TabbarWithImageWidget({
    Key key,
    @required this.imageActivePath,
    @required this.imageNonActivePath,
    @required this.index,
    @required this.indexSelected,
  }) : super(key: key);
  final String imageActivePath;
  final String imageNonActivePath;
  final int index;
  final int indexSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints.expand(width: 200),
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: new DecorationImage(
          image: new ExactAssetImage(
            indexSelected == index ? imageActivePath : imageNonActivePath,
          ),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
