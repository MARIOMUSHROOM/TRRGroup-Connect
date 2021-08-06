import 'dart:convert';

import 'package:ai_flutter/home/activity/mix_plant_info_page.dart';
import 'package:ai_flutter/home/activity/model/setting_mix_type_model.dart';
import 'package:ai_flutter/home/activity/model/local_model.dart';
import 'package:ai_flutter/home/activity/widget/app_bar_widget.dart';
import 'package:ai_flutter/home/activity/widget/custom_text_form_field_style.dart';
import 'package:ai_flutter/home/activity/widget/input_form_widget.dart';
import 'package:ai_flutter/provider/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class SettingMixTypePage extends StatefulWidget {
  SettingMixTypePage(this._inputActivityForm);
  InputActivityForm _inputActivityForm;
  @override
  _SettingMixTypePageState createState() =>
      _SettingMixTypePageState(this._inputActivityForm);
}

class _SettingMixTypePageState extends State<SettingMixTypePage> {
  _SettingMixTypePageState(this._inputActivityForm);
  InputActivityForm _inputActivityForm;
  List<TextEditingController> newPlantController = new List();
  List<TextEditingController> oldPlantController = new List();

  String validateTextField(String text, String vilidateText) {
    if (text == null || text.isEmpty) {
      return vilidateText;
    }
    return null;
  }

  final formKey = new GlobalKey<FormState>();
  bool _submit() {
    final isValid = formKey.currentState.validate();
    if (!isValid) {
      return isValid;
    }
    formKey.currentState.save();
    return isValid;
  }

  initData() {
    print(_inputActivityForm.plot_detail.length);
    for (var i = 0; i < _inputActivityForm.plot_detail.length; i++) {
      newPlantController.insert(i, new TextEditingController());
      oldPlantController.insert(i, new TextEditingController());
    }
  }

  Future<void> submitData() async {
    if (_submit()) {
      try {
        List<MixPlotDetail> dataList = [];
        for (var i = 0; i < newPlantController.length; i++) {
          MixPlotDetail only = new MixPlotDetail();
          only.idUserEnroll = 1;
          only.plot = _inputActivityForm.plot_detail[i].plot_id;
          only.year = "2563/2564";
          only.amountNew = double.parse(newPlantController[i].text);
          only.amountTor = double.parse(oldPlantController[i].text);

          // datamap[i.toString()] = only;
          dataList.add(only);
        }
        // stationSelected.data = datamap;
        print(dataList);
        SettingMixTypeModel data = new SettingMixTypeModel();
        data.data = dataList;
        Response response = await ActivityAPI().saveFarmData(data);
        print("response");
        print(response.statusCode);
        if (response.statusCode == 200) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                Future.delayed(Duration(seconds: 1)).then((_) {
                  Navigator.pop(context);
                });
                return AlertDialog(
                  content: Container(
                    width: 200,
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text("ทำรายการสำเร็จ"),
                      ],
                    ),
                  ),
                );
              });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MixPlantInfoPage(_inputActivityForm)));
        } else {}
      } catch (e) {
        print("error: $e");
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              Future.delayed(Duration(seconds: 1)).then((_) {
                Navigator.pop(context);
              });
              return AlertDialog(
                content: Container(
                  width: 180,
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("ทำรายการไม่สำเร็จ"),
                      Text("กรุณาลองใหม่อีกครั้ง..."),
                    ],
                  ),
                ),
              );
            });
      }
    }
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        appBar: AppBar(),
        titleText: 'ตั้งค่าแปลงผสม',
        actionOn: true,
        onPressed: () async {
          if (_submit()) {
            for (var i = 0; i < _inputActivityForm.plot_detail.length; i++) {
              _inputActivityForm.plot_detail[i].new_plant_area =
                  double.parse(newPlantController[i].text);
              _inputActivityForm.plot_detail[i].old_plant_area =
                  double.parse(oldPlantController[i].text);
            }
            await submitData();
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             MixPlantInfoPage(_inputActivityForm)));
          }
        },
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  CustomTextFormFieldStyle.inputTitleTextStyle(
                    labelTextStr: "กำหนดประเภทอ้อยและจำนวนไร่",
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: newPlantController.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CustomTextFormFieldStyle.inputTitleTextStyle(
                              labelTextStr: _inputActivityForm
                                  .plot_detail[index].plot_name,
                            ),
                            InputFormWidget(
                              textEditingController: newPlantController[index],
                              requireText:
                                  CustomTextValidate.requireNumberText(),
                              keyboardType: TextInputType.number,
                              leader: "อ้อยปลูกใหม่",
                              bit: "ไร่",
                              validator: (value) {
                                return validateTextField(
                                  value,
                                  CustomTextValidate.requireNumberText(),
                                );
                              },
                            ),
                            InputFormWidget(
                              textEditingController: oldPlantController[index],
                              requireText:
                                  CustomTextValidate.requireNumberText(),
                              keyboardType: TextInputType.number,
                              leader: "อ้อยตอ",
                              bit: "ไร่",
                              validator: (value) {
                                return validateTextField(
                                  value,
                                  CustomTextValidate.requireNumberText(),
                                );
                              },
                            ),
                          ],
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     children: [
      //       Column(
      //         children: [
      //           CustomTextFormFieldStyle.inputTitleTextStyle(
      //               labelTextStr: "แปลงที่ 1"),
      //           InputFormWidget(
      //             requireNumberText: CustomTextValidate.requireText(),
      //             keyboardType: TextInputType.text,
      //             leader: "อ้อยปลูกใหม่",
      //             bit: "ไร่",
      //             validator: (value) {
      //               // return validateTextField(value);
      //             },
      //           ),
      //           InputFormWidget(
      //             requireNumberText: CustomTextValidate.requireText(),
      //             keyboardType: TextInputType.text,
      //             leader: "อ้อยตอ",
      //             bit: "ไร่",
      //             validator: (value) {
      //               // return validateTextField(value);
      //             },
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
