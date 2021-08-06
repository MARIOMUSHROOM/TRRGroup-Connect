import 'dart:convert';
import 'dart:io';

import 'package:ai_flutter/bloc/activity_state/function/change_sugar_cane_to_int.dart';
import 'package:ai_flutter/bloc/activity_state/set_plant/bloc/set_plant_bloc_bloc.dart';
import 'package:ai_flutter/home/activity/model/set_plant_model.dart';
import 'package:ai_flutter/home/activity/model/local_model.dart';
import 'package:ai_flutter/home/activity/utils/border_warp.dart';
import 'package:ai_flutter/home/activity/utils/colors.dart';
import 'package:ai_flutter/home/activity/widget/app_bar_widget.dart';
import 'package:ai_flutter/home/activity/widget/could_upload_widget.dart';
import 'package:ai_flutter/home/activity/widget/custom_text_form_field_style.dart';
import 'package:ai_flutter/home/activity/widget/input_form_widget.dart';
import 'package:ai_flutter/home/activity/widget/pick_time_icon.dart';
import 'package:ai_flutter/home/activity/widget/warp_custom.dart';
import 'package:ai_flutter/provider/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:table_calendar/table_calendar.dart';

class InputSetPlantPage extends StatefulWidget {
  InputSetPlantPage(
      this._inputActivityForm, this._inputActivityStep, this.editData);
  InputActivityForm _inputActivityForm;
  String _inputActivityStep;
  SetPlantModel editData;
  @override
  _InputSetPlantPageState createState() =>
      _InputSetPlantPageState(this._inputActivityForm);
}

class _InputSetPlantPageState extends State<InputSetPlantPage> {
  _InputSetPlantPageState(this._inputActivityForm);
  InputActivityForm _inputActivityForm;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _dateNow = DateTime.now();
  // DateTime _selectedDay;

  List<String> plowType = ["ไถบุกเบิก", "ไถพรวน"];
  List<String> plowStyle1 = [
    "ริปเปอร์ระเบิดดินดาน",
    "ไถหัวหมู",
    "ผาน 2,3,4",
    "ผานสับใบ"
  ];
  List<String> plowStyle2 = [
    "ผาน 6,7,8,9",
    "ผานพรวน 22 จาน",
    "จอบหมุน",
    "โรดารี่",
    "โรดารี่ มินิคอมบาย",
    "พาวเวอร์แฮร์โรว"
  ];
  String selectedPlowType = "";
  String selectedPlowStyle = "";

  String requireText = "ระบุเป็นตัวหนังสือ";
  String requireNumberText = "ระบุเป็นตัวเลข";

  TextEditingController otherController = TextEditingController();
  TextEditingController setTimeController = TextEditingController();
  TextEditingController tractorPaymentController = TextEditingController();
  TextEditingController laborPaymentController = TextEditingController();
  TextEditingController fuelVolumeController = TextEditingController();
  TextEditingController fuelPaymentController = TextEditingController();
  bool selectedNewPlantType = true;
  bool selectedOldPlantType = false;

  final _formKey = GlobalKey<FormState>();
  bool validate() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  String validateTextField(String value) {
    if (value.isEmpty) {
      return 'กรุณาระบุ';
    }
    return null;
  }

  Future<void> submitData(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: 200,
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("กำลังบันทึกรายการ..."),
                ],
              ),
            ),
          );
        });
    int mixInputId = 0;
    print(_inputActivityForm.activity_type);
    if (_inputActivityForm.activity_type == "แปลงผสม") {
      mixInputId = selectInputActivityType(selectedNewPlantType, false);
    }
    if (validate()) {
      try {
        var response = await ActivityAPI().saveSoilData(
          plot: stationSelectedtoString(_inputActivityForm.plot_detail),
          year: "63/64",
          idSugarcraneType:
              sugarCaneTypeChange(_inputActivityForm.activity_type),
          idActivity: sugarCaneStepChange(widget._inputActivityStep),
          no: int.tryParse(setTimeController.text),
          date: _focusedDay.toString(),
          idSoilDetail: indexSelectedInList(plowType, selectedPlowType) + 1,
          idSoilType: indexSelectedInList(
                  new List.from(plowStyle1)..addAll(plowStyle2),
                  selectedPlowStyle) +
              1,
          idHybrid: mixInputId,
          soilDesc: otherController.text,
          laborCost: double.tryParse(laborPaymentController.text),
          tractorCost: double.tryParse(tractorPaymentController.text),
          fuelPrice: double.tryParse(fuelPaymentController.text),
          fuelAmount: double.tryParse(fuelVolumeController.text),
          billPath: imagePath,
        );
        print("response");
        var res = json.decode(response.body);
        print(res);
        BlocProvider.of<SetPlantBlocBloc>(context).add(LoadSetPlantInitial());
        Navigator.pop(context);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              Future.delayed(Duration(seconds: 1)).then((_) {
                Navigator.pop(context);
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
        Future.delayed(Duration(milliseconds: 1500)).then((_) {
          Navigator.pop(context);
        });
      } catch (e) {
        print("error: $e");
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              Future.delayed(Duration(seconds: 1)).then((_) {
                Navigator.pop(context);
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

  ImagePicker _imgPicker = ImagePicker();
  _doTakePhoto(BuildContext context) async {
    PickedFile img = await _imgPicker.getImage(source: ImageSource.gallery);
    if (img != null && img.path != null) {
      File imgFile = await FlutterExifRotation.rotateImage(path: img.path);
      await uploadFile(context, imgFile);
    } else {
      // _imgPicker = ImagePicker();
      return;
    }
  }

  String imagePath;
  Future<void> uploadFile(BuildContext context, File filePath) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: 200,
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("กำลังอัพโหลดไฟล์..."),
                ],
              ),
            ),
          );
        });

    try {
      var response = await ActivityAPI().uploadFile(imagePath: filePath);
      var res = json.decode(response);
      print(res);
      if (res['status'] == 200) {
        setState(() {
          imagePath = res['full_store_as'];
        });
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              Future.delayed(Duration(seconds: 1)).then((_) {
                Navigator.pop(context);
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
      }
    } catch (e) {
      print("error: $e");
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            Future.delayed(Duration(seconds: 1)).then((_) {
              Navigator.pop(context);
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

  checkEditData() {
    if (widget.editData != null) {
      SetPlantModel data = widget.editData;
      _focusedDay = data.date;

      // selectedPlowType = data.hasOneSoilType.name;
      selectedPlowType = indexSelectedInListString(
          new List.from(plowType), data.idSoilType - 1);
      selectedPlowStyle = indexSelectedInListString(
          new List.from(plowStyle1)..addAll(plowStyle2), data.idSoilDetail - 1);
      otherController = TextEditingController(text: checkNull(data.soilDesc));
      setTimeController = TextEditingController(text: checkNull(data.no));
      tractorPaymentController =
          TextEditingController(text: checkNull(data.tractorCost));
      laborPaymentController =
          TextEditingController(text: checkNull(data.laborCost));
      fuelVolumeController =
          TextEditingController(text: checkNull(data.fuelAmount));
      fuelPaymentController =
          TextEditingController(text: checkNull(data.fuelPrice));
      selectedNewPlantType = true;
      selectedOldPlantType = false;
    }
  }

  @override
  void initState() {
    checkEditData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Colors.black),
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     widget._inputActivityStep,
      //     textAlign: TextAlign.center,
      //     style: GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     FlatButton(
      //       onPressed: () async {
      //         await submitData();
      //       },
      //       child: Text(
      //         'บันทึก',
      //         style:
      //             GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
      //       ),
      //     ),
      //   ],
      // ),
      appBar: AppBarWidget(
        appBar: AppBar(),
        titleText: widget._inputActivityStep,
        actionOn: true,
        onPressed: () async {
          await submitData(context);
        },
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(8),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  calenderWidget(),
                  _inputActivityForm.activity_type == "แปลงผสม"
                      ? Column(
                          children: [
                            CustomTextFormFieldStyle.inputTitleTextStyle(
                                labelTextStr: "ประเภทของอ้อย"),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // setState(() {
                                            //   selectedNewPlantType =
                                            //       !selectedNewPlantType;
                                            // });
                                          },
                                          child: selectedNewPlantType
                                              ? Icon(
                                                  Icons.check_box,
                                                  color: Colors.black54,
                                                )
                                              : Icon(
                                                  Icons.check_box_outline_blank,
                                                  color: Colors.black54,
                                                ),
                                        ),
                                        Text("อ้อยปลูกใหม่"),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // setState(() {
                                          //   selectedOldPlantType =
                                          //       !selectedOldPlantType;
                                          // });
                                        },
                                        child: selectedOldPlantType
                                            ? Icon(
                                                Icons.check_box,
                                                color: Colors.grey,
                                              )
                                            : Icon(
                                                Icons.check_box_outline_blank,
                                                color: Colors.grey,
                                              ),
                                      ),
                                      Text(
                                        "อ้อยตอ",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : SizedBox(),
                  CustomTextFormFieldStyle.inputTitleTextStyle(
                      labelTextStr: "ประเภทการไถเตรียมดิน"),
                  WarpCustomPick(
                    typeList: plowType,
                    typeSelected: selectedPlowType,
                    selected: (value) {
                      setState(() {
                        selectedPlowType = value;
                      });
                    },
                  ),
                  InputFormWidget(
                    textEditingController: setTimeController,
                    requireText: requireNumberText,
                    keyboardType: TextInputType.number,
                    title: "ไถและเตรียมดินครั้งที่ ?*",
                    // bit: "ครั้ง",
                    validator: (value) {
                      return validateTextField(value);
                    },
                  ),
                  Text("ลักษณะการไถ"),
                  selectedPlowType == "ไถบุกเบิก"
                      ? WarpCustomPick(
                          typeList: plowStyle1,
                          typeSelected: selectedPlowStyle,
                          selected: (value) {
                            setState(() {
                              selectedPlowStyle = value;
                            });
                          },
                        )
                      : WarpCustomPick(
                          typeList: plowStyle2,
                          typeSelected: selectedPlowStyle,
                          selected: (value) {
                            setState(() {
                              selectedPlowStyle = value;
                            });
                          },
                        ),
                  InputFormWidget(
                    textEditingController: otherController,
                    requireText: "อื่นๆ",
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      return validateTextField(value);
                    },
                  ),
                  CustomTextFormFieldStyle.inputTitleTextStyle(
                      labelTextStr: "บักทึกค่าใช้จ่าย / เก็บใบเสร็จ"),
                  InputFormWidget(
                    textEditingController: tractorPaymentController,
                    requireText: requireNumberText,
                    keyboardType: TextInputType.number,
                    title: "ค่าจ้างรถไถ่",
                    bit: "บาท",
                    validator: (value) {
                      return validateTextField(value);
                    },
                  ),
                  InputFormWidget(
                    textEditingController: laborPaymentController,
                    requireText: requireNumberText,
                    keyboardType: TextInputType.number,
                    title: "ค่าจ้างแรงงาน",
                    bit: "บาท",
                    validator: (value) {
                      return validateTextField(value);
                    },
                  ),
                  InputFormWidget(
                    textEditingController: fuelVolumeController,
                    requireText: requireNumberText,
                    keyboardType: TextInputType.number,
                    title: "ปริมาณเชื้อเพลิง",
                    bit: "ลิตร",
                    validator: (value) {
                      return validateTextField(value);
                    },
                  ),
                  InputFormWidget(
                    textEditingController: fuelPaymentController,
                    requireText: requireNumberText,
                    keyboardType: TextInputType.number,
                    title: "ราคาเชื้อเพลิง",
                    bit: "บาท",
                    validator: (value) {
                      return validateTextField(value);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CouldUploadWidget(
                    onTap: () async {
                      await _doTakePhoto(context);
                    },
                    imagePath: imagePath,
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget calenderWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomTextFormFieldStyle.inputTitleTextStyle(
                labelTextStr: "เลือกวันที่"),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        PickTimeIcon(
          startDate: _focusedDay,
          focusedDay: (value) {
            setState(() {
              _focusedDay = value;
            });
          },
        ),
        TableCalendar(
          firstDay: DateTime(_dateNow.year - 20),
          lastDay: _dateNow,
          focusedDay: _focusedDay,
          calendarFormat: CalendarFormat.month,
          locale: 'th_TH',
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
          ),
          selectedDayPredicate: (day) {
            return isSameDay(_focusedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_focusedDay, selectedDay)) {
              setState(() {
                _focusedDay = focusedDay;
              });
            }
          },
        ),
      ],
    );
  }
}
