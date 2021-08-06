import 'dart:convert';
import 'dart:io';

import 'package:ai_flutter/bloc/activity_state/function/change_sugar_cane_to_int.dart';
import 'package:ai_flutter/bloc/activity_state/manure_plant/bloc/manure_plant_bloc.dart';
import 'package:ai_flutter/home/activity/model/manure_plant.dart';
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

class InputManurePlantPage extends StatefulWidget {
  InputManurePlantPage(
      this._inputActivityForm, this._inputActivityStep, this.editData);
  InputActivityForm _inputActivityForm;
  String _inputActivityStep;
  ManurePlantModel editData;
  @override
  _InputManurePlantPageState createState() =>
      _InputManurePlantPageState(this._inputActivityForm);
}

class _InputManurePlantPageState extends State<InputManurePlantPage> {
  _InputManurePlantPageState(this._inputActivityForm);
  InputActivityForm _inputActivityForm;

  DateTime _focusedDay = DateTime.now();
  DateTime _dateNow = DateTime.now();
  DateTime _selectedDay;

  List<String> productType = [
    "ปุ๋ยเคมี",
    "ปุ๋ยอินทรีย์",
    "ปุ๋ยคอมโพส",
    "น้ำส่า",
  ];

  String selectedproductType = "";

  String requireText = "ระบุเป็นตัวหนังสือ";
  String requireNumberText = "ระบุเป็นตัวเลข";

  DateTime _selectedDate;
  TextEditingController manureTimeController = TextEditingController();
  TextEditingController manureTechnicalController = TextEditingController();
  TextEditingController manureVolumeController = TextEditingController();
  TextEditingController manurePaymentController = TextEditingController();
  TextEditingController laborPaymentController = TextEditingController();
  TextEditingController machinePaymentController = TextEditingController();
  TextEditingController fuelPaymentController = TextEditingController();

  checkEditData() {
    if (widget.editData != null) {
      ManurePlantModel data = widget.editData;
      _focusedDay = data.date;
      selectedproductType = indexSelectedInListString(
          new List.from(productType), data.idFertilizerType - 1);
      manureTimeController = TextEditingController(text: checkNull(data.no));
      manureTechnicalController =
          TextEditingController(text: checkNull(data.recipe));
      manureVolumeController =
          TextEditingController(text: checkNull(data.recipeAmount));
      manurePaymentController =
          TextEditingController(text: checkNull(data.sackPrice));
      laborPaymentController =
          TextEditingController(text: checkNull(data.laborCost));
      machinePaymentController =
          TextEditingController(text: checkNull(data.machineCost));
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
        var response = await ActivityAPI().saveFertilizerData(
          plot: station,
          year: "63/64",
          idSugarcraneType: sugarcraneIndex,
          idActivity: activityIndex,
          date: _focusedDay.toString(),
          idHybrid: mixInputId,
          no: manureTimeController.text,
          idFertilizerType:
              indexSelectedInList(productType, selectedproductType) + 1,
          recipe: manureTechnicalController.text,
          recipeAmount: manureVolumeController.text,
          sackPrice: manurePaymentController.text,
          laborCost: laborPaymentController.text,
          machineCost: machinePaymentController.text,
          fuelPrice: fuelPaymentController.text,
          billPath: imagePath,
        );
        print("response");
        var res = json.decode(response.body);
        print(res);
        BlocProvider.of<ManurePlantBloc>(context).add(LoadManurePlantInitial());
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
                          labelTextStr: "ประเภทของปุ๋ย"),
                      WarpCustomPick(
                        typeList: productType,
                        typeSelected: selectedproductType,
                        selected: (value) {
                          setState(() {
                            selectedproductType = value;
                          });
                        },
                      ),
                      CustomTextFormFieldStyle.inputTitleTextStyle(
                          labelTextStr: "ให้ปุ๋ยครั้งที่"),
                      InputFormWidget(
                        textEditingController: manureTimeController,
                        requireText: requireNumberText,
                        keyboardType: TextInputType.number,
                        bit: "ครั้ง",
                        validator: (value) {
                          return validateTextField(value);
                        },
                      ),
                      InputFormWidget(
                        textEditingController: manureTechnicalController,
                        requireText: requireText,
                        keyboardType: TextInputType.text,
                        title: "สูตรปุ๋ย",
                        validator: (value) {
                          return validateTextField(value);
                        },
                      ),
                      InputFormWidget(
                        textEditingController: manureVolumeController,
                        requireText: requireNumberText,
                        keyboardType: TextInputType.text,
                        title: "ปริมาณที่ใช้",
                        bit: "กิโลกรัม",
                        validator: (value) {
                          return validateTextField(value);
                        },
                      ),
                      CustomTextFormFieldStyle.inputTitleTextStyle(
                          labelTextStr: "บันทึกค่าใช้จ่าย"),
                      InputFormWidget(
                        textEditingController: manurePaymentController,
                        requireText: requireNumberText,
                        keyboardType: TextInputType.number,
                        title: "ค่าปุ๋ย กระสอบละ",
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
                        textEditingController: machinePaymentController,
                        requireText: requireNumberText,
                        keyboardType: TextInputType.number,
                        title: "ค่าเครื่องจักร",
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
