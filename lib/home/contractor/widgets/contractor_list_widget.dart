import 'package:flutter/material.dart';

import '../../../global_const.dart' as cons;
import '../models/contractor_model.dart';

// typedef NotifyOnContractorItemWidgetTap = void Function(ContractorDetailItem contractorItem);

typedef NotifyOnContractorItemWidgetTap = void Function(ContractorItem contractorItem);

class ContractorListWidget extends StatelessWidget {
  // final ContractorDetailList contractorList;
  final ContractorList contractorList;
  final NotifyOnContractorItemWidgetTap onContractorItemTapEvent;

  ContractorListWidget({Key key, @required this.contractorList, this.onContractorItemTapEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: this.contractorList.length,
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: [
                ContractorItemWidget(
                  // contractorItem: this.contractorList.contractors[index],
                  contractorItem: this.contractorList.contractorItems[index],
                  onContractorItemTapEvent: this.onContractorItemTapEvent,
                ),
                if (index != this.contractorList.count - 1) Divider(height: 1, thickness: 0.5, color: Colors.grey),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ContractorItemWidget extends StatelessWidget {
  // final ContractorDetailItem contractorItem;
  final ContractorItem contractorItem;
  final NotifyOnContractorItemWidgetTap onContractorItemTapEvent;

  ContractorItemWidget({Key key, @required this.contractorItem, this.onContractorItemTapEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (this.onContractorItemTapEvent != null) onContractorItemTapEvent(this.contractorItem);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
              height: 30,
              child: VerticalDivider(thickness: 5, color: cons.kGoldColor),
            ),
            Text(contractorItem.fullName, style: TextStyle(color: Colors.grey[600], fontSize: 24)),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
