import 'package:ai_flutter/home/contractor/models/contractor_type_model.dart';

import 'package:flutter/material.dart';
import '../../../basic/pages/trr_basic_page.dart';
import '../../../basic/models/trr_object.dart';
import '../../../global_const.dart' as cons;
import '../widgets/contractor_type_grid_widget.dart';
import '../models/contractor_type_model.dart';
// import '../models/contractor_detail_model.dart';
import './contractor_list_page.dart';

// import './test_contractor_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/contractor/contractor_type/bloc/contractor_type_bloc.dart';

// ignore: must_be_immutable
class ContractorHomePage extends TrrBasicPageStatelessWidget {
  // Constructor
  ContractorHomePage({Key key, @required TrrData dataObj}) : super(key: key, dataObj: dataObj);

  _onContractorTypeTapped(ContractorTypeGridItem tapItem) {
    if (tapItem != null) {
      /*
      Now send request to API with dataObj.user.quotaID and tapItem.contractorType
      to get specific list of contrators relate to user affiliate factory
      */

      // - Send request to API
      // - Send contractor list that retrieve from API to ContractorListPage

      Navigator.push(pageContext, MaterialPageRoute(
        builder: (ctx) {
          // return TestContractorPage();
          return ContractorListPage(dataObj: this.dataObj, contractorTypeItem: tapItem);
        },
      ));
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
          title: Text('ประเภทผู้รับเหมา', style: TextStyle(fontSize: 26)),
        ),
        body: _contractorHomePageUI(),
      ),
    );
  }

  Widget _contractorHomePageUI() {
    ContractorTypeBloc contractorTypeBlocObj = BlocProvider.of<ContractorTypeBloc>(pageContext);
    contractorTypeBlocObj.add(ContractorTypeRequestListEvent());

    return SingleChildScrollView(
      child: BlocBuilder<ContractorTypeBloc, ContractorTypeState>(
        builder: (context, state) {
          if (state is ContractorTypeInitial || state is ContractorTypeLoading)
            return _loadingView();
          else if (state is ContractorTypeNoData)
            return _contractorTypeEmptyView();
          else if (state is ContractorTypeLoaded) {
            if (contractorTypeBlocObj.contractorTypeList.isNotEmpty)
              return _contractorTypeGridView(contractorTypeBlocObj.contractorTypeList);
            else
              return _contractorTypeEmptyView();
          } else
            return _contractorTypeEmptyView();
        },
      ),
    );
  }

  Widget _loadingView() {
    return Container(
      height: dvHeight * 0.8,
      child: Align(
        child: CircularProgressIndicator(strokeWidth: 5, backgroundColor: cons.kSolidBlueColor),
      ),
    );
  }

  Widget _contractorTypeEmptyView() {
    return Container(
      height: dvHeight * 0.8,
      child: Align(
        child: Text('ไม่พบข้อมูลผู้รับเหมาแต่ละประเภท', style: TextStyle(fontSize: 24, color: cons.kSolidBlueColor)),
      ),
    );
  }

  Widget _contractorTypeGridView(ContractorTypeGridList aContractorTypeList) {
    return ContractorTypeGridWidget(
      contractorTypeList: aContractorTypeList,
      onGridItemTapped: _onContractorTypeTapped,
    );
  }
}
