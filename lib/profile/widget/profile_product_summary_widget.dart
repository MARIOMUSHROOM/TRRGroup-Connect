import '../models/profile_product_year_agriculture.dart';
import 'package:flutter/material.dart';
import '../../basic/pages/trr_basic_page.dart';
import '../models/profile_product_year_summary_model.dart';
import '../../basic/models/trr_object.dart';
import '../../global_const.dart' as cons;
import '../../global_utils.dart' as util;
import '../quantity_product_page.dart';

/* ================================================================================================================ */

class ProfileProductSummaryWidget extends TrrBasicPageStatefulWidget {
  final ProfileProductYearAgricultureList tabYears;

  ProfileProductSummaryWidget({
    Key key,
    @required TrrData dataObj,
    @required this.tabYears,
  }) : super(key: key, dataObj: dataObj);

  @override
  _ProfileProductSummaryWidgetState createState() => _ProfileProductSummaryWidgetState();
}

class _ProfileProductSummaryWidgetState extends TrrBasicPageState<ProfileProductSummaryWidget> with SingleTickerProviderStateMixin {
  ProfileProductYearSummaryItemModel _currentYearSummary = ProfileProductYearSummaryItemModel();

  int _tabIndex = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: ProfileProductYearAgricultureList.dummyYear.items.length, vsync: this);
    samplingYearSummary(widget.tabYears.cultureYears[0], _currentYearSummary);
  }

  @override
  Widget internalBuild(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('ปริมาณผลผลิตอ้อย', style: TextStyle(fontSize: 26, color: cons.kGoldColor)),
                GestureDetector(
                  child: Text('ดูเพิ่มเติม', style: TextStyle(fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                        pageContext,
                        MaterialPageRoute(
                          builder: (ctx) => QuantityProductPage(),
                        ));
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: DefaultTabController(
              length: widget.tabYears.cultureYears.length,
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: false,
                      onTap: (index) {
                        _tabIndex = index;
                        setState(() {
                          samplingYearSummary(widget.tabYears.cultureYears[index], _currentYearSummary);
                        });
                      },
                      tabs: widget.tabYears.cultureYears.map((yearItem) {
                        return Text(yearItem.cultureYearLabel);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: widget.tabYears.cultureYears.map((yearItem) {
                return ProfileProductYearSummaryItemWidget(
                  dataObj: widget.dataObj,
                  productYearSumItem: _currentYearSummary,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

/* ================================================================================================================ */
// ignore: must_be_immutable
class ProfileProductYearSummaryItemWidget extends TrrBasicPageStatelessWidget {
  final ProfileProductYearSummaryItemModel productYearSumItem;

  ProfileProductYearSummaryItemWidget({
    Key key,
    @required TrrData dataObj,
    @required this.productYearSumItem,
  }) : super(key: key, dataObj: dataObj);

  @override
  Widget internalBuild(BuildContext context) {
    return Container(
      // height: dvHeight * 0.3,
      color: cons.kPageBackgroundColor,
      child: ListView(
        children: [
          _headerDetailRow(),
          Container(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            color: cons.kPageBackgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                util.horizontalAnimation(
                  _cardDetailRow(
                    '${productYearSumItem.productRef} ตัน',
                    'สัญญาอ้อย',
                    '${productYearSumItem.plotAmount} แปลง',
                    'จำนวนแปลง',
                    '${productYearSumItem.areaTotal} ไร่',
                    'พื้นที่ทั้งหมด',
                  ),
                  aStartPosition: 100,
                  aMilliseconds: 700,
                ),
                util.horizontalAnimation(
                  _cardDetailRow(
                    '${productYearSumItem.areaGets} ไร่',
                    'พื้นที่เข้าร่วมโครงการ\nGETS FARMING',
                    '${productYearSumItem.areaBonsucro} ไร่',
                    'พื้นที่เข้าร่วมโครงการ\nBONSUCRO',
                    '${productYearSumItem.cssMean}',
                    'ค่า CCS เฉลี่ย',
                  ),
                  aStartPosition: 100,
                  aMilliseconds: 1000,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowDivider() {
    return SizedBox(height: 40, child: VerticalDivider(color: Colors.grey, thickness: 0.5));
  }

  Widget _headerDetailRow() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _headerColumnElement('${productYearSumItem.estimateProduct} ตัน/ไร่', 'ประมาณการณ์ผลผลิตอ้อย'),
          _rowDivider(),
          _headerColumnElement('${productYearSumItem.productReal} ตัน', 'ผลผลิตอ้อย'),
        ],
      ),
    );
  }

  Widget _headerColumnElement(String aValue, String aCaption) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(aValue, style: TextStyle(color: cons.kBlueColor, fontSize: 48, height: 0.5)),
          Text(aCaption, style: TextStyle(fontSize: 20, color: cons.kBlueGreyColor)),
        ],
      ),
    );
  }

  Widget _cardDetailRow(String aValue1, String aCaption1, String aValue2, String aCaption2, String aValue3, String aCaption3) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cardDetailColumnElement(aValue1, aCaption1),
            _rowDivider(),
            _cardDetailColumnElement(aValue2, aCaption2),
            _rowDivider(),
            _cardDetailColumnElement(aValue3, aCaption3),
          ],
        ),
      ),
    );
  }

  Widget _cardDetailColumnElement(String aValue, String aCaption) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(aValue, style: TextStyle(color: cons.kBlueColor, fontWeight: FontWeight.bold, height: 0.8), textAlign: TextAlign.center),
        Text(aCaption, style: TextStyle(fontSize: 14, color: cons.kBlueGreyColor), textAlign: TextAlign.center),
      ],
    );
  }
}
