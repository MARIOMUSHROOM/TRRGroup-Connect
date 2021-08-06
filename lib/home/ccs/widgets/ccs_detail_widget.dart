import 'package:flutter/material.dart';
import '../../../global_const.dart' as cons;
import '../../../global_utils.dart' as util;
import '../models/ccs_detail_model.dart';

class CcsDetailItemWidget extends StatelessWidget {
  final CcsDetailItem ccsData;

  const CcsDetailItemWidget({Key key, this.ccsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 3,
        shadowColor: cons.kBlueGreyColor.withOpacity(0.4),
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('${util.getThaiDateFormat(ccsData.ccsDate)}', style: TextStyle(fontSize: 18)),
                  Text('ทะเบียนรถ: ${ccsData.truckRegistration}', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            _lineDivider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('บิลอ้อย : ${ccsData.sugarcaneBill}', style: TextStyle(color: cons.kBlueColor, fontSize: 20)),
                        _lineDivider(),
                        Text('ประเภทอ้อย : ${ccsData.sugarcaneType}', style: TextStyle(color: cons.kBlueColor, fontSize: 20)),
                        _lineDivider(),
                        Text('เลขที่ตัวอย่าง : ${ccsData.sampleNumber}', style: TextStyle(color: cons.kBlueColor, fontSize: 20)),
                        _lineDivider(),
                        Text('น้ำหนักสุทธิ : ${ccsData.netWeight} ตัน', style: TextStyle(color: cons.kBlueColor, fontSize: 20)),
                      ],
                    ),
                  ),
                  Container(height: 50, child: VerticalDivider(thickness: 0.5, color: Colors.grey[500])),
                  Expanded(
                      child: Text(
                    'ค่า CCS \n${ccsData.ccsValue}',
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.bold, color: cons.kBlueColor, height: 0.9),
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lineDivider() {
    return Container(
      height: 0.5,
      child: Divider(color: Colors.grey[400], thickness: 0.3, indent: 2, endIndent: 2),
    );
  }
}
