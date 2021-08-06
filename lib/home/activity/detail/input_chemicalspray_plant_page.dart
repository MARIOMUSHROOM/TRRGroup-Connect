import 'dart:convert';
import 'dart:io';

import 'package:ai_flutter/bloc/activity_state/chemicalspray_plant/bloc/chemical_spray_plant_bloc.dart';
import 'package:ai_flutter/bloc/activity_state/function/change_sugar_cane_to_int.dart';
import 'package:ai_flutter/home/activity/model/chemical_spray_plant.dart';
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

class InputChemicalSprayPage extends StatefulWidget {
  InputChemicalSprayPage(
      this._inputActivityForm, this._inputActivityStep, this.editData);
  InputActivityForm _inputActivityForm;
  String _inputActivityStep;
  ChemicalSprayPlantModel editData;
  @override
  _InputChemicalSprayPageState createState() =>
      _InputChemicalSprayPageState(this._inputActivityForm);
}

class _InputChemicalSprayPageState extends State<InputChemicalSprayPage> {
  _InputChemicalSprayPageState(this._inputActivityForm);
  InputActivityForm _inputActivityForm;

  DateTime _focusedDay = DateTime.now();
  DateTime _dateNow = DateTime.now();
  DateTime _selectedDay;

  List<String> technicalStyle = [
    "วัชพืช",
    "แมลง",
    "โรคพืช",
  ];
  List<String> productType = [
    "อามารีน",
    "2,4-ดี",
    "ไดยูรอน",
    "พนดิเมทาลิน + อิมาชาพิค",
    "อันดาชิแฟม",
  ];

  String selectedtechnicalStyle = "";
  String selectedproductType = "";

  String requireText = "ระบุเป็นตัวหนังสือ";
  String requireNumberText = "ระบุเป็นตัวเลข";

  DateTime _selectedDate;
  TextEditingController otherController = TextEditingController();
  TextEditingController chemicalRateController = TextEditingController();
  TextEditingController chemicalVolumeController = TextEditingController();
  TextEditingController chemicalPaymentController = TextEditingController();
  TextEditingController hirePaymentController = TextEditingController();
  TextEditingController laborPaymentController = TextEditingController();
  TextEditingController fuelPaymentController = TextEditingController();

  checkEditData() {
    if (widget.editData != null) {
      ChemicalSprayPlantModel data = widget.editData;
      _focusedDay = data.date;
      selectedtechnicalStyle = indexSelectedInListString(
          new List.from(technicalStyle), data.idSprayType - 1);
      selectedproductType = indexSelectedInListString(
          new List.from(productType), data.idProductName - 1);
      otherController = TextEditingController(text: checkNull(data.laborCost));
      // chemicalRateController =
      //     TextEditingController(text: checkNull(data.laborCost));
      // chemicalVolumeController =
      //     TextEditingController(text: checkNull(data.laborCost));
      chemicalPaymentController =
          TextEditingController(text: checkNull(data.chemicalCost));
      hirePaymentController =
          TextEditingController(text: checkNull(data.contractCost));
      laborPaymentController =
          TextEditingController(text: checkNull(data.laborCost));
      fuelPaymentController =
          TextEditingController(text: checkNull(data.fuelPrice));
    }
  }

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
        var response = await ActivityAPI().saveSprayData(
          plot: station,
          year: "63/64",
          idSugarcraneType: sugarcraneIndex,
          idActivity: activityIndex,
          date: _focusedDay.toString(),
          idHybrid: mixInputId,
          idSprayType:
              indexSelectedInList(technicalStyle, selectedtechnicalStyle) + 1,
          idProductName:
              indexSelectedInList(productType, selectedproductType) + 1,
          productName: otherController.text,
          sprayRate: chemicalRateController.text,
          sprayQuantity: chemicalVolumeController.text,
          chemicalCost: chemicalPaymentController.text,
          contractCost: hirePaymentController.text,
          laborCost: laborPaymentController.text,
          fuelPrice: fuelPaymentController.text,
          billPath: imagePath,
        );
        print("response");
        var res = json.decode(response.body);
        print(res);
        BlocProvider.of<ChemicalSprayPlantBloc>(context)
            .add(LoadChemicalSprayPlantInitial());
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
                  selectPlantType(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormFieldStyle.inputTitleTextStyle(
                          labelTextStr: "ประเภทของการป้องกันจำกัด"),
                      WarpCustomPick(
                        typeList: technicalStyle,
                        typeSelected: selectedtechnicalStyle,
                        selected: (value) {
                          setState(() {
                            selectedtechnicalStyle = value;
                          });
                        },
                      ),
                      CustomTextFormFieldStyle.inputTitleTextStyle(
                          labelTextStr: "ชื่อผลิตภัณฑ์"),
                      WarpCustomPick(
                        typeList: productType,
                        typeSelected: selectedproductType,
                        selected: (value) {
                          setState(() {
                            selectedproductType = value;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("อื่นๆ"),
                            Row(
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: TextFormField(
                                    controller: otherController,
                                    keyboardType: TextInputType.text,
                                    decoration:
                                        CustomTextFormFieldStyle.textFieldStyle(
                                            labelTextStr: "",
                                            hintTextStr: requireText),
                                    validator: (String value) {
                                      if (value == null || value.isEmpty) {
                                        return requireText;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      CustomTextFormFieldStyle.inputTitleTextStyle(
                          labelTextStr: "ปริมาณการฉีดพ่น"),
                      InputFormWidget(
                        textEditingController: chemicalRateController,
                        requireText: requireText,
                        keyboardType: TextInputType.text,
                        title: "อัตราการใช้",
                        validator: (value) {
                          return validateTextField(value);
                        },
                      ),
                      InputFormWidget(
                        textEditingController: chemicalVolumeController,
                        requireText: requireNumberText,
                        keyboardType: TextInputType.number,
                        title: "ปริมาณที่ใช้ฉีดพ่น",
                        bit: "ลิตร",
                        validator: (value) {
                          return validateTextField(value);
                        },
                      ),
                      CustomTextFormFieldStyle.inputTitleTextStyle(
                          labelTextStr: "บันทึกค่าใช้จ่าย"),
                      InputFormWidget(
                        textEditingController: chemicalPaymentController,
                        requireText: requireNumberText,
                        keyboardType: TextInputType.number,
                        title: "ค่าใช้จ่ายสารเคมี",
                        bit: "บาท",
                        validator: (value) {
                          return validateTextField(value);
                        },
                      ),
                      InputFormWidget(
                        textEditingController: hirePaymentController,
                        requireText: requireNumberText,
                        keyboardType: TextInputType.number,
                        title: "ค่าจ้างเหมา",
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
