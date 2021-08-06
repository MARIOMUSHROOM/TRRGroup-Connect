import 'package:ai_flutter/home/activity/model/local_model.dart';
import 'package:ai_flutter/home/activity/utils/colors.dart';
import 'package:flutter/material.dart';

class ActivityAddButtonWidget extends StatelessWidget {
  const ActivityAddButtonWidget(
      {Key key,
      @required InputActivityForm inputActivityForm,
      @required this.activityText,
      @required this.onPressed})
      : _inputActivityForm = inputActivityForm,
        super(key: key);

  final InputActivityForm _inputActivityForm;
  final String activityText;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      child: RawMaterialButton(
        shape: new CircleBorder(),
        fillColor: kGoldColor,
        elevation: 0.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: kWhiteColor,
            ),
            Text(
              "เริ่มบันทึก",
              style: TextStyle(
                color: kWhiteColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
        onPressed: onPressed,
        // onPressed: () {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) =>
        //               InputSetPlantPage(_inputActivityForm, activityText)));
        // },
      ),
    );
  }
}
