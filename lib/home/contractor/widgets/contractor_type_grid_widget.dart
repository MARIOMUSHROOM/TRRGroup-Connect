import 'package:flutter/material.dart';

import '../../../base_class/pages/ai_base_page.dart';
import '../../../global_const.dart' as cons;
import '../../../global_utils.dart' as util;
import '../models/contractor_type_model.dart';

typedef NotifyOnContractorTypeTapEvent = void Function(ContractorTypeGridItem typeItem);

// ignore: must_be_immutable
class ContractorTypeGridWidget extends AiBaseStatelessWidget {
  final ContractorTypeGridList contractorTypeList;
  final NotifyOnContractorTypeTapEvent onGridItemTapped;

  ContractorTypeGridWidget({Key key, @required this.contractorTypeList, this.onGridItemTapped}) : super(key: key);

  int itemAnimDuration = 300;

  _doOnItemTypeTap(ContractorTypeGridItem tapItem) {
    if (this.onGridItemTapped != null) this.onGridItemTapped(tapItem);
  }

  @override
  Widget internalBuild(BuildContext context) {
    var list = this.contractorTypeList;
    return Container(
      height: dvHeight,
      padding: EdgeInsets.all(20),
      child: GridView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          itemAnimDuration += 150;
          return ContractorTypeGridItemWidget(
            typeItem: list.typeItems[index],
            animDuration: itemAnimDuration,
            onItemTapped: _doOnItemTypeTap,
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ContractorTypeGridItemWidget extends AiBaseStatefulWidget {
  final ContractorTypeGridItem typeItem;
  final int animDuration;
  final NotifyOnContractorTypeTapEvent onItemTapped;

  ContractorTypeGridItemWidget({Key key, @required this.typeItem, this.onItemTapped, this.animDuration = 0}) : super(key: key);

  @override
  _ContractorTypeGridItemWidgetState createState() => _ContractorTypeGridItemWidgetState();
}

class _ContractorTypeGridItemWidgetState extends AiBaseState<ContractorTypeGridItemWidget> {
  @override
  Widget build(BuildContext context) {
    return util.zoomOutAnimation(
      _gridItem(),
      aCurve: Curves.elasticInOut,
      aStartSize: 0,
      aEndSize: 1,
      aIsFadeWhenDone: false,
      aMilliseconds: widget.animDuration,
    );
  }

  Widget _gridItem() {
    return GestureDetector(
      onTap: () {
        if (widget.onItemTapped != null) widget.onItemTapped(widget.typeItem);
      },
      child: Container(
        decoration: BoxDecoration(color: cons.kPageBackgroundColor, borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 4, child: Container(child: Image(image: NetworkImage(widget.typeItem.iconUrl)))),
              // Expanded(child: Text(widget.typeItem.label, style: TextStyle(color: cons.kSolidBlueColor))),
            ],
          ),
        ),
      ),
    );
  }
}
