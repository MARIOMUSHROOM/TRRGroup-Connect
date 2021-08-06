import 'dart:convert';
import 'dart:io';

import 'package:ai_flutter/bloc/activity_state/function/change_sugar_cane_to_int.dart';
import 'package:ai_flutter/bloc/activity_state/water_plant/bloc/water_plant_bloc.dart';
import 'package:ai_flutter/home/activity/model/water_plant_model.dart';
import 'package:ai_flutter/home/activity/model/local_model.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:table_calendar/table_calendar.dart';

class InputWaterPlantPage extends StatefulWidget {
  InputWaterPlantPage(
      this._inputActivityForm, this._inputActivityStep, this.editData);
  InputActivityForm _inputActivityForm;
  String _inputActivityStep;
  WaterPlantModel editData;
  @override
  _InputWaterPlantPageState createState() =>
      _InputWaterPlantPageState(this._inputActivityForm);
}

class _InputWaterPlantPageState extends State<InputWaterPlantPage> {
  _InputWaterPlantPageState(this._inputActivityForm);
  InputActivityForm _inputActivityForm;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _dateNow = DateTime.now();
  DateTime _selectedDay;

  List<String> waterType = [
    "น้ำคลอง",
    "น้ำฝน",
    "สระน้ำ",
    "แม่น้ำ",
    "บ่อบาดาล",
  ];
  List<String> waterSystem = [
    "น้ำหยด",
    "น้ำราด",
    "แบบไพวอต",
    "สปริงเกอร์",
  ];

  String selectedWaterType = "";
  String selectedWaterSystem = "";

  TextEditingController otherSystemCaneController = TextEditingController();
  TextEditingController laborPaymentController = TextEditingController();
  TextEditingController fuelPaymentController = TextEditingController();

  bool selectedNewPlantType = true;
  bool selectedOldPlantType = true;
  checkEditData() {
    if (widget.editData != null) {
      WaterPlantModel data = widget.editData;
      _focusedDay = data.date;
      selectedWaterType = indexSelectedInListString(
          new List.from(waterType), data.idWaterResources - 1);
      selectedWaterSystem = indexSelectedInListString(
          new List.from(waterSystem), data.idWaterSystem - 1);
      otherSystemCaneController =
          TextEditingController(text: checkNull(data.waterSystemDesc));
      laborPaymentController =
          TextEditingController(text: checkNull(data.laborCost));
      fuelPaymentController =
          TextEditingController(text: checkNull(data.fuelPrice));
    }
  }

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

  Future<void> submitData() async {
    int mixInputId = 0;
    print(_inputActivityForm.activity_type);
    if (_inputActivityForm.activity_type == "แปลงผสม") {
      mixInputId =
          selectInputActivityType(selectedNewPlantType, selectedOldPlantType);
    }
    if (validate()) {
      try {
        String station =
            stationSelectedtoString(_inputActivityForm.plot_detail);
        int sugarcraneIndex =
            sugarCaneTypeChange(_inputActivityForm.activity_type);
        int activityIndex = sugarCaneStepChange(widget._inputActivityStep);
        var response = await ActivityAPI().saveWaterData(
          plot: station,
          year: "63/64",
          idSugarcraneType: sugarcraneIndex,
          idActivity: activityIndex,
          date: _focusedDay.toString(),
          idHybrid: mixInputId,
          idWaterResources:
              indexSelectedInList(waterType, selectedWaterType) + 1,
          idWaterSystem:
              indexSelectedInList(waterSystem, selectedWaterSystem) + 1,
          waterSystemDesc: otherSystemCaneController.text,
          laborCost: double.tryParse(laborPaymentController.text),
          fuelPrice: double.tryParse(fuelPaymentController.text),
          billPath: imagePath,
        );
        print("response");
        var res = json.decode(response.body);
        print(res);
        BlocProvider.of<WaterPlantBloc>(context).add(LoadWaterPlantInitial());
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

  @override
  void initState() {
    checkEditData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        appBar: AppBar(),
        titleText: widget._inputActivityStep,
        actionOn: true,
        onPressed: () async {
          await submitData();
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
                                            setState(() {
                                              selectedNewPlantType =
                                                  !selectedNewPlantType;
                                            });
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
                                          setState(() {
                                            selectedOldPlantType =
                                                !selectedOldPlantType;
                                          });
                                        },
                                        child: selectedOldPlantType
                                            ? Icon(
                                                Icons.check_box,
                                                color: Colors.black54,
                                              )
                                            : Icon(
                                                Icons.check_box_outline_blank,
                                                color: Colors.black54,
                                              ),
                                      ),
                                      Text(
                                        "อ้อยตอ",
                                        style: TextStyle(
                                            // color: Colors.grey,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormFieldStyle.inputTitleTextStyle(
                          labelTextStr: "แหล่งน้ำ"),
                      WarpCustomPick(
                        typeList: waterType,
                        typeSelected: selectedWaterType,
                        selected: (value) {
                          setState(() {
                            selectedWaterType = value;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("ระบบน้ำ"),
                          ],
                        ),
                      ),
                      WarpCustomPick(
                        typeList: waterSystem,
                        typeSelected: selectedWaterSystem,
                        selected: (value) {
                          setState(() {
                            selectedWaterSystem = value;
                          });
                        },
                      ),
                      InputFormWidget(
                        textEditingController: otherSystemCaneController,
                        requireText: CustomTextValidate.requireText(),
                        keyboardType: TextInputType.text,
                        title: "อื่นๆ",
                        validator: (value) {
                          return validateTextField(value);
                        },
                      ),
                    ],
                  ),
                  CustomTextFormFieldStyle.inputTitleTextStyle(
                      labelTextStr: "บันทึกค่าใช้จ่าย / เก็บใบเสร็จ"),
                  InputFormWidget(
                    textEditingController: laborPaymentController,
                    requireText: CustomTextValidate.requireNumberText(),
                    keyboardType: TextInputType.number,
                    title: "ค่าจ้างแรงงาน",
                    bit: "บาท",
                    validator: (value) {
                      return validateTextField(value);
                    },
                  ),
                  InputFormWidget(
                    textEditingController: fuelPaymentController,
                    requireText: CustomTextValidate.requireNumberText(),
                    keyboardType: TextInputType.number,
                    title: "ค่าเชื้อเพลิง",
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
