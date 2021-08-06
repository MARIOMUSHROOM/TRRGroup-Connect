import 'package:flutter/material.dart';

import '../../../base_class/pages/ai_base_page.dart';
import '../../../global_const.dart' as cons;
import '../models/contractor_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/contractor/contractor_detail/bloc/contractor_detail_bloc.dart';

// ignore: must_be_immutable
class ContractorDetailPage extends AiBaseStatelessWidget {
  // final ContractorDetailItem contractorItem;
  final errorText = 'ไม่สามารถดึงข้อมูล\nผู้รับเหมาได้ในขณะนี้';
  final noDataText = 'ไม่พบข้อมูลผู้รับเหมา';
  final ContractorItem findContractorItem;

  ContractorDetailPage({Key key, @required this.findContractorItem}) : super(key: key);

  ContractorDetailItem contractorObj;

  @override
  Widget internalBuild(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: cons.kSolidBlueColor,
          centerTitle: true,
          title: Text('ข้อมูลผู้รับเหมา', style: TextStyle(fontSize: 26)),
        ),
        body: _contractorDetailPageUI(),
      ),
    );
  }

  Widget _contractorDetailPageUI() {
    var contractorDetailBlocObj = BlocProvider.of<ContractorDetailBloc>(pageContext);
    contractorDetailBlocObj.add(ContractorDetailRequestDataEvent(this.findContractorItem.contractorID));

    return BlocBuilder<ContractorDetailBloc, ContractorDetailState>(
      builder: (context, state) {
        Widget result;

        if (state is ContractorDetailInitial || state is ContractorDetailLoading)
          result = _loadingDataView();
        else if (state is ContractorDetailLoadFinished) {
          contractorObj = contractorDetailBlocObj.contractorDetailObj;
          result = _contractorCard();
        }
        // result = _contractorCard(contractorDetailBlocObj.contractorDetailObj);
        else if (state is ContractorDetailEmpty) result = _infoView(noDataText);
        if (state is ContractorDetailError) result = _infoView(errorText);

        return result;
        // return Container(child: _contractorCard());
      },
    );
  }

  Widget _infoView(String aCaption) {
    return Container(
      child: Align(
        child: Text(aCaption, style: TextStyle(color: cons.kSolidBlueColor), textAlign: TextAlign.center),
      ),
    );
  }

  Widget _loadingDataView() {
    return Container(
      child: Align(
        child: CircularProgressIndicator(backgroundColor: cons.kSolidBlueColor, strokeWidth: 5),
      ),
    );
  }

  Widget _contractorCard() {
    return (this.contractorObj != null)
        ? SizedBox(
            height: dvHeight * 0.53,
            child: Card(
              elevation: 0,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              color: cons.kPageBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _contractorDetail(),
                  _contractorInfo(),
                  _callContractorButton(),
                ],
              ),
            ),
          )
        : SizedBox();
  }

  Widget _contractorDetail() {
    return Container(
      padding: EdgeInsets.only(top: 30),
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            child: ClipOval(
              child: Image.network(
                contractorObj.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Image(image: AssetImage('assets/images/contractor/contractor_avatar.png'));
                },
              ),
            ),
          ),
          SizedBox(width: 20),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contractorObj.fullName, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: cons.kSolidBlueColor)),
                Text(contractorObj.factoryObj.factoryName, style: TextStyle(fontSize: 20)),
                Text(contractorObj.contractorTypeObj.label, style: TextStyle(fontSize: 20, height: 1.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contractorInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text(contractorObj.information, style: TextStyle(fontSize: 20)),
    );
  }

  Widget _callContractorButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(elevation: 2, primary: cons.kGreenButtonColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(padding: EdgeInsets.only(right: 10), child: Icon(Icons.phone_outlined, color: Colors.white, size: 18)),
            Text(contractorObj.phoneNumber),
          ],
        ),
        onPressed: () {
          print('');
        },
      ),
    );
  }
}
