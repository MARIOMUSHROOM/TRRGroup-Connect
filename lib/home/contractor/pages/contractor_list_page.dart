import 'package:flutter/material.dart';

// import '../../../base_class/pages/ai_base_page.dart';
import '../../../basic/pages/trr_basic_page.dart';
import '../../../basic/models/trr_object.dart';
import '../../../global_const.dart' as cons;
import '../../../global_utils.dart' as util;
import '../models/contractor_model.dart';
import '../widgets/contractor_list_widget.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/contractor/contractor_list/bloc/contractor_list_bloc.dart';

import '../../../home/contractor/models/contractor_model.dart';
import '../../../home/contractor/models/contractor_type_model.dart';
import '../../../home/contractor/pages/contractor_detail_page.dart';

// ignore: must_be_immutable
class ContractorListPage extends TrrBasicPageStatelessWidget {
  final ContractorTypeGridItem contractorTypeItem;

  ContractorListPage({Key key, @required TrrData dataObj, @required this.contractorTypeItem}) : super(key: key, dataObj: dataObj);

  _onContractorItemTap(ContractorItem contractorItem) {
    // open Contractor Detail Page
    if (contractorItem != null) {
      Navigator.push(
        pageContext,
        MaterialPageRoute(builder: (context) => ContractorDetailPage(findContractorItem: contractorItem)),
      );
    }
  }

  @override
  Widget internalBuild(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: cons.kSolidBlueColor,
          centerTitle: true,
          title: Text('รายชื่อผู้รับเหมา', style: TextStyle(fontSize: 26)),
        ),
        body: _contractorListPageUI(),
      ),
    );
  }

  Widget _contractorListPageUI() {
    ContractorListBloc contractorListBloc = BlocProvider.of<ContractorListBloc>(pageContext);
    contractorListBloc.add(ContractorListRequestDataEvent(this.contractorTypeItem.contractorTypeID, 1));

    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Text('${this.contractorTypeItem.label}', style: TextStyle(color: cons.kSolidBlueColor, fontSize: 24)),
          ),
          Divider(thickness: 1, color: cons.kSolidBlueColor, height: 2),
          Expanded(child: BlocBuilder<ContractorListBloc, ContractorListState>(
            builder: (context, state) {
              Widget result;
              if (state is ContractorListInitial || state is ContractorListLoading)
                result = _loadingView(); // initial or loading state
              else if (state is ContractorListLoadFinished) {
                // finish loading
                if (contractorListBloc.contractorList.isNotEmpty) // contractor list exist
                  result = _contractorListView(contractorListBloc.contractorList);
                else
                  result = _contractorListEmptyView(); // contractor list empty
              } else if (state is ContractorListEmpty) result = _contractorListEmptyView(); // contractor list empty
              return result;
            },
          )),
        ],
      ),
    );
  }

  Widget _loadingView() {
    return Container(
      child: Align(
        child: CircularProgressIndicator(strokeWidth: 5, backgroundColor: cons.kSolidBlueColor),
      ),
    );
  }

  Widget _contractorListEmptyView() {
    return util.verticalAnimation(
      Container(
        height: dvHeight * 0.8,
        child: Align(
          child: Text(
            'ขออภัยไม่พบรายการ\nผู้รับเหมา : ${this.contractorTypeItem.label}\nในเขตพื้นที่ของคุณ',
            style: TextStyle(fontSize: 22, color: cons.kSolidBlueColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _contractorListView(ContractorList aContractorList) {
    return util.horizontalAnimation(
      ContractorListWidget(
        contractorList: aContractorList,
        onContractorItemTapEvent: _onContractorItemTap,
      ),
    );
  }
}
