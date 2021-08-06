import 'package:ai_flutter/home/activity/detail/chemicalspray_plant_page.dart';
import 'package:ai_flutter/home/activity/detail/cut_plant_page.dart';
import 'package:ai_flutter/home/activity/detail/manure_plant_page.dart';
import 'package:ai_flutter/home/activity/detail/seed_plant_page.dart';
import 'package:ai_flutter/home/activity/detail/set_plant_page.dart';
import 'package:ai_flutter/home/activity/detail/ship_plant_page.dart';
import 'package:ai_flutter/home/activity/detail/success_plant_page.dart';
import 'package:ai_flutter/home/activity/detail/water_plant_page.dart';
import 'package:ai_flutter/home/activity/detail/waterspray_plant_page.dart';
import 'package:ai_flutter/home/activity/model/local_model.dart';
import 'package:ai_flutter/home/activity/utils/tab_data.dart';
import 'package:ai_flutter/home/activity/widget/app_bar_widget.dart';
import 'package:ai_flutter/home/activity/widget/tab_with_icon_widget.dart';
import 'package:ai_flutter/home/activity/widget/tab_with_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MixPlantInfoPage extends StatefulWidget {
  MixPlantInfoPage(this._inputActivityForm);
  InputActivityForm _inputActivityForm;
  @override
  _MixPlantInfoPageState createState() =>
      _MixPlantInfoPageState(this._inputActivityForm);
}

class _MixPlantInfoPageState extends State<MixPlantInfoPage> {
  _MixPlantInfoPageState(this._inputActivityForm);
  InputActivityForm _inputActivityForm;

  // SelectActivity actionInfarm = new SelectActivity();
  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        appBar: AppBar(),
        titleText: _inputActivityForm.activity_type,
        actionOn: false,
        // onPressed: () async {
        //   await submitData();
        // },
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
            }
          });
          return Column(
            children: <Widget>[
              Container(
                // color: Colors.green,
                constraints: BoxConstraints.expand(height: 120),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: TabBar(
                  isScrollable: true,
                  controller: tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  labelPadding: EdgeInsets.all(4),
                  tabs: [
                    TabbarWithImageWidget(
                      index: 0,
                      indexSelected: indexSelected,
                      imageActivePath: "assets/images/activity/set_2.png",
                      imageNonActivePath: "assets/images/activity/set_1.png",
                    ),
                    TabbarWithImageWidget(
                      index: 1,
                      indexSelected: indexSelected,
                      imageActivePath: "assets/images/activity/seed_2.png",
                      imageNonActivePath: "assets/images/activity/seed_1.png",
                    ),
                    TabbarWithImageWidget(
                      index: 2,
                      indexSelected: indexSelected,
                      imageActivePath: "assets/images/activity/water_2.png",
                      imageNonActivePath: "assets/images/activity/water_1.png",
                    ),
                    TabbarWithImageWidget(
                      index: 3,
                      indexSelected: indexSelected,
                      imageActivePath:
                          "assets/images/activity/water_spray_2.png",
                      imageNonActivePath:
                          "assets/images/activity/water_spray_1.png",
                    ),
                    TabbarWithImageWidget(
                      index: 4,
                      indexSelected: indexSelected,
                      imageActivePath: "assets/images/activity/chemical_2.png",
                      imageNonActivePath:
                          "assets/images/activity/chemical_1.png",
                    ),
                    TabbarWithImageWidget(
                      index: 5,
                      indexSelected: indexSelected,
                      imageActivePath: "assets/images/activity/manure_2.png",
                      imageNonActivePath: "assets/images/activity/manure_1.png",
                    ),
                    TabbarWithImageWidget(
                      index: 6,
                      indexSelected: indexSelected,
                      imageActivePath: "assets/images/activity/cut_2.png",
                      imageNonActivePath: "assets/images/activity/cut_1.png",
                    ),
                    TabbarWithImageWidget(
                      index: 7,
                      indexSelected: indexSelected,
                      imageActivePath: "assets/images/activity/ship_2.png",
                      imageNonActivePath: "assets/images/activity/ship_1.png",
                    ),
                    TabbarWithImageWidget(
                      index: 8,
                      indexSelected: indexSelected,
                      imageActivePath: "assets/images/activity/success_2.png",
                      imageNonActivePath:
                          "assets/images/activity/success_1.png",
                    ),
                    // TabCustomWithIcon(
                    //   text: tabs[0],
                    //   imagePath: "assets/images/landing/tractor.png",
                    //   index: 0,
                    //   indexSelected: indexSelected,
                    // ),
                    // TabCustomWithIcon(
                    //   text: tabs[1],
                    //   imagePath: "assets/images/landing/plant.png",
                    //   index: 1,
                    //   indexSelected: indexSelected,
                    // ),
                    // TabCustomWithIcon(
                    //   text: tabs[2],
                    //   imagePath: null,
                    //   index: 2,
                    //   indexSelected: indexSelected,
                    // ),
                    // TabCustomWithIcon(
                    //   text: tabs[3],
                    //   imagePath: null,
                    //   index: 3,
                    //   indexSelected: indexSelected,
                    // ),
                    // TabCustomWithIcon(
                    //   text: tabs[4],
                    //   imagePath: null,
                    //   index: 4,
                    //   indexSelected: indexSelected,
                    // ),
                    // TabCustomWithIcon(
                    //   text: tabs[5],
                    //   imagePath: null,
                    //   index: 5,
                    //   indexSelected: indexSelected,
                    // ),
                    // TabCustomWithIcon(
                    //   text: tabs[6],
                    //   imagePath: null,
                    //   index: 6,
                    //   indexSelected: indexSelected,
                    // ),
                    // TabCustomWithIcon(
                    //   text: tabs[7],
                    //   imagePath: null,
                    //   index: 7,
                    //   indexSelected: indexSelected,
                    // ),
                    // TabCustomWithIcon(
                    //   text: tabs[8],
                    //   imagePath: null,
                    //   index: 8,
                    //   indexSelected: indexSelected,
                    // ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(
                    children: [
                      SetPlantPage(_inputActivityForm, tabs[0]),
                      SeedPlantPage(_inputActivityForm, tabs[1]),
                      WaterPlantPage(_inputActivityForm, tabs[2]),
                      WaterSprayPlantPage(_inputActivityForm, tabs[3]),
                      ChemicalSprayPlantPage(_inputActivityForm, tabs[4]),
                      ManurePlantPage(_inputActivityForm, tabs[5]),
                      CutPlantPage(_inputActivityForm, tabs[6]),
                      ShipPlantPage(_inputActivityForm, tabs[7]),
                      SuccessPlantPage(_inputActivityForm, tabs[8]),

                      // Text("data"),
                      // Text("data"),
                      // Text("data"),
                      // Text("data"),
                      // Text("data"),
                      // Text("data"),
                      // Text("data"),
                      // Text("data"),
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
      // body: ListView.builder(
      //   // physics: NeverScrollableScrollPhysics(),
      //   // padding: EdgeInsets.all(10),
      //   shrinkWrap: true,
      //   itemCount: _inputActivityForm.length,
      //   itemBuilder: (context, index) {
      //     return Row(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(_inputActivityForm[index].farmName),
      //       ],
      //     );
      //   },
      // ),
    );
  }
}
