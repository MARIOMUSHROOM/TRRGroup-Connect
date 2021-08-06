import 'dart:convert';
import 'dart:io';

import 'package:ai_flutter/bloc/activity_state/cut_plant/bloc/cut_plant_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/function/change_sugar_cane_to_int.dart';
import 'package:ai_flutter/home/activity/model/cut_plant_model.dart';
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

class InputCutPlantPage extends StatefulWidget {
  InputCutPlantPage(
      this._inputActivityForm, this._inputActivityStep, this.editData);
  InputActivityForm _inputActivityForm;
  String _inputActivityStep;
  CutPlantModel editData;
  @override
  _InputCutPlantPageState createState() =>
      _InputCutPlantPageState(this._inputActivityForm);
}

class _InputCutPlantPageState extends State<InputCutPlantPage> {
  _InputCutPlantPageState(this._inputActivityForm);
  InputActivityForm _inputActivityForm;

  DateTime _focusedDay = DateTime.now();
  DateTime _dateNow = DateTime.now();

  List<String> warp1 = [
    "คนตัดอ้อย",
    "รถตัดอ้อย",
  ];
  String warp1Selected = "";
  List<String> warp2 = [
    "ไว้ใบ",
    "ไม่ไว้ใบ",
  ];
  String warp2Selected = "";
  List<String> warp3 = [
    "25 %",
    "50 %",
    "75 %",
    "100 %",
  ];
  String warp3Selected = "";
  List<String> warp4 = [
    "อ้อยสด",
    "อ้อยไฟไหม้",
  ];
  String warp4Selected = "";

  String requireText = "ระบุเป็นตัวหนังสือ";
  String requireNumberText = "ระบุเป็นตัวเลข";

  TextEditingController cutVolumeController = TextEditingController();
  TextEditingController tractorCutPaymentController = TextEditingController();
  TextEditingController tractorPullPaymentController = TextEditingController();
  TextEditingController laborPaymentController = TextEditingController();
  TextEditingController fuelPaymentController = TextEditingController();

  String validateTextField(String value) {
    if (value.isEmpty) {
      return 'กรุณาระบุ';
    }
    return null;
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
        var response = await ActivityAPI().saveLeaveData(
          plot: station,
          year: "63/64",
          idSugarcraneType: sugarcraneIndex,
          idActivity: activityIndex,
          date: _focusedDay.toString(),
          idHybrid: mixInputId,
          idCutOffType: indexSelectedInList(warp1, warp1Selected) + 1,
          cutOffAmount: cutVolumeController.text,
          idPercentLeaves: indexSelectedInList(warp2, warp2Selected) + 1,
          leaves: indexSelectedInList(warp3, warp3Selected) + 1,
          idSugarcraneCat: indexSelectedInList(warp4, warp4Selected) + 1,
          //
          havestCost: tractorCutPaymentController.text,
          grabCost: tractorPullPaymentController.text,
          laborCost: laborPaymentController.text,
          fuelPrice: fuelPaymentController.text,
          billPath: imagePath,
        );
        print("response");
        var res = json.decode(response.body);
        print(res);
        BlocProvider.of<CutPlantBloc>(context).add(LoadCutPlantInitial());
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

  checkEditData() {
    if (widget.editData != null) {
      CutPlantModel data = widget.editData;
      _focusedDay = data.date;
      warp1Selected = indexSelectedInListString(
          new List.from(warp1), data.idCutOffType - 1);
      warp2Selected =
          indexSelectedInListString(new List.from(warp2), data.leaves - 1);
      warp3Selected = indexSelectedInListString(
          new List.from(warp3), data.idPercentLeaves - 1);
      warp3Selected = indexSelectedInListString(
          new List.from(warp3), data.idSugarcraneCat - 1);
      cutVolumeController =
          TextEditingController(text: checkNull(data.cutOffAmount));
      tractorCutPaymentController =
          TextEditingController(text: checkNull(data.harvestCost));
      tractorPullPaymentController =
          TextEditingController(text: checkNull(data.grabCost));
      laborPaymentController =
          TextEditingController(text: checkNull(data.laborCost));
      fuelPaymentController =
          TextEditingController(text: checkNull(data.fuelPrice));
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
                  selectPlantType(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormFieldStyle.inputTitleTextStyle(
                          labelTextStr: "วิธีการตัดอ้อย"),
                      WarpCustomPick(
                        typeList: warp1,
                        typeSelected: warp1Selected,
                        selected: (value) {
                          setState(() {
                            warp1Selected = value;
                          });
                        },
                      ),
                      InputFormWidget(
                        textEditingController: cutVolumeController,
                        requireText: requireNumberText,
                        keyboardType: TextInputType.number,
                        title: "ปริมาณอ้อย",
                        bit: "ตัน",
                        validator: (value) {
                          return validateTextField(value);
                        },
                      ),
                      CustomTextFormFieldStyle.inputSubTitleTextStyle(
                          labelTextStr: "การไว้อ้อยหลังตัด"),
                      WarpCustomPick(
                        typeList: warp2,
                        typeSelected: warp2Selected,
                        selected: (value) {
                          setState(() {
                            warp2Selected = value;
                          });
                          if (warp2Selected != "ไว้ใบ") {
                            setState(() {
                              warp3Selected = null;
                            });
                          }
                        },
                      ),
                      warp2Selected == "ไว้ใบ"
                          ? WarpCustomPick(
                              typeList: warp3,
                              typeSelected: warp3Selected,
                              selected: (value) {
                                setState(() {
                                  warp3Selected = value;
                                });
                              },
                            )
                          : SizedBox(),
                      CustomTextFormFieldStyle.inputSubTitleTextStyle(
                          labelTextStr: "ประเภทของอ้อย"),
                      WarpCustomPick(
                        typeList: warp4,
                        typeSelected: warp4Selected,
                        selected: (value) {
                          setState(() {
                            warp4Selected = value;
                          });
                        },
                      ),
                      CustomTextFormFieldStyle.inputTitleTextStyle(
                          labelTextStr: "บันทึกค่าใช้จ่าย"),
                      InputFormWidget(
                        textEditingController: tractorCutPaymentController,
                        requireText: requireNumberText,
                        keyboardType: TextInputType.number,
                        title: "ค่าจ้างรถตัดอ้อย",
                        bit: "บาท",
                        validator: (value) {
                          return validateTextField(value);
                        },
                      ),
                      InputFormWidget(
                        textEditingController: tractorPullPaymentController,
                        requireText: requireNumberText,
                        keyboardType: TextInputType.number,
                        title: "ค่าจ้างรถคีบอ้อย",
                        bit: "บาท",
                        validator: (value) {
                          return validateTextField(value);
                        },
                      ),
                      InputFormWidget(
                        textEditingController: laborPaymentController,
                        requireText: requireNumberText,
                        keyboardType: TextInputType.number,
                        title: "ค่าแรงงาน",
                        bit: "บาท",
                        validator: (value) {
                          return validateTextField(value);
                        },
                      ),
                      InputFormWidget(
                        textEditingController: fuelPaymentController,
                        requireText: requireNumberText,
                        keyboardType: TextInputType.number,
                        title: "ค่าเชื้อเพลิง",
                        bit: "บาท",
                        validator: (value) {
                          return validateTextField(value);
                        },
                      ),
                    ],
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

  bool selectedNewPlantType = true;
  bool selectedOldPlantType = true;
  Widget selectPlantType() {
    return _inputActivityForm.activity_type == "แปลงผสม"
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
                                selectedNewPlantType = !selectedNewPlantType;
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
                              selectedOldPlantType = !selectedOldPlantType;
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
        : SizedBox();
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
