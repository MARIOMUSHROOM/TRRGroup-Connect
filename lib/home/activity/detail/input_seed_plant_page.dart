import 'dart:convert';
import 'dart:io';

import 'package:ai_flutter/bloc/activity_state/function/change_sugar_cane_to_int.dart';
import 'package:ai_flutter/bloc/activity_state/seed_plant/bloc/seed_plant_bloc.dart';
import 'package:ai_flutter/home/activity/model/seed_plant_model.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:table_calendar/table_calendar.dart';

class InputSeedPlantPage extends StatefulWidget {
  InputSeedPlantPage(
      this._inputActivityForm, this._inputActivityStep, this.editData);
  InputActivityForm _inputActivityForm;
  String _inputActivityStep;
  SeedPlantModel editData;
  @override
  _InputSeedPlantPageState createState() =>
      _InputSeedPlantPageState(this._inputActivityForm);
}

class _InputSeedPlantPageState extends State<InputSeedPlantPage> {
  _InputSeedPlantPageState(this._inputActivityForm);
  InputActivityForm _inputActivityForm;
  String activityText;
  DateTime _focusedDay = DateTime.now();
  DateTime _dateNow = DateTime.now();

  List<String> seedType = [
    "ขอนแก่น 3",
    "อู่ทอง",
    "CSB 08-108",
    "LK92-11",
    "K84-200",
    "KPK98-51",
    "กำแพงแสน",
  ];
  List<String> fertilizerChoice = [
    "มี",
    "ไม่มี",
  ];

  String selectedSeed = "";
  String selectedFertilizer = "";

  TextEditingController otherSugarCaneController = TextEditingController();
  TextEditingController betweenAreaController = TextEditingController();
  TextEditingController fertilizeTechnicalController = TextEditingController();
  TextEditingController fertilizeVolumeController = TextEditingController();
  TextEditingController sugarcaneCutPaymentController = TextEditingController();
  TextEditingController sugarcaneVolumeController = TextEditingController();
  TextEditingController sugarcaneCutPriceController = TextEditingController();
  TextEditingController tractorForBetweenAreaPaymentController =
      TextEditingController();
  TextEditingController fertilizePaymentController = TextEditingController();
  TextEditingController tractorForSeedPaymentController =
      TextEditingController();
  TextEditingController laborPaymentController = TextEditingController();
  TextEditingController fuelPaymentController = TextEditingController();

  bool selectedNewPlantType = true;
  bool selectedOldPlantType = false;

  checkEditData() {
    if (widget.editData != null) {
      SeedPlantModel data = widget.editData;
      _focusedDay = data.date;
      selectedSeed =
          indexSelectedInListString(new List.from(seedType), data.idGenre - 1);
      selectedFertilizer = indexSelectedInListString(
          new List.from(fertilizerChoice), data.fdFertilizer - 1);
      otherSugarCaneController =
          TextEditingController(text: checkNull(data.genreDesc));
      betweenAreaController =
          TextEditingController(text: checkNull(data.grooveSpace));
      fertilizeTechnicalController =
          TextEditingController(text: checkNull(data.recipe));
      fertilizeVolumeController =
          TextEditingController(text: checkNull(data.recipeAmount));
      sugarcaneCutPaymentController =
          TextEditingController(text: checkNull(data.cutOffCost));
      sugarcaneVolumeController =
          TextEditingController(text: checkNull(data.cutOffAmount));
      sugarcaneCutPriceController =
          TextEditingController(text: checkNull(data.price));
      tractorForBetweenAreaPaymentController =
          TextEditingController(text: checkNull(data.gougeCost));
      fertilizePaymentController =
          TextEditingController(text: checkNull(data.foundationCost));
      tractorForSeedPaymentController =
          TextEditingController(text: checkNull(data.growerCost));
      laborPaymentController =
          TextEditingController(text: checkNull(data.laborCost));
      fuelPaymentController =
          TextEditingController(text: checkNull(data.fuelPrice));
      selectedNewPlantType = true;
      selectedOldPlantType = false;
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

  Future<void> submitData(BuildContext context) async {
    int mixInputId = 0;
    print(_inputActivityForm.activity_type);

    if (_inputActivityForm.activity_type == "แปลงผสม") {
      mixInputId = selectInputActivityType(selectedNewPlantType, false);
    }
    if (validate()) {
      try {
        String station =
            stationSelectedtoString(_inputActivityForm.plot_detail);
        int sugarcraneIndex =
            sugarCaneTypeChange(_inputActivityForm.activity_type);
        int activityIndex = sugarCaneStepChange(widget._inputActivityStep);
        var response = await ActivityAPI().saveGrowData(
          plot: station,
          year: "63/64",
          idSugarcraneType: sugarcraneIndex,
          idActivity: activityIndex,
          date: _focusedDay.toString(),
          idHybrid: mixInputId,
          idGenre: indexSelectedInList(seedType, selectedSeed) + 1,
          genreDesc: otherSugarCaneController.text,
          grooveSpace: betweenAreaController.text,
          fdFertilizer:
              indexSelectedInList(fertilizerChoice, selectedFertilizer) + 1,
          recipe: fertilizeTechnicalController.text,
          recipeAmount: int.tryParse(fertilizeVolumeController.text),
          cutOffCost: int.tryParse(sugarcaneCutPaymentController.text),
          cutOffAmount: int.tryParse(sugarcaneVolumeController.text),
          price: int.tryParse(sugarcaneCutPriceController.text),
          gougeCost: int.tryParse(tractorForBetweenAreaPaymentController.text),
          foundationCost: int.tryParse(fertilizePaymentController.text),
          growerCost: int.tryParse(tractorForSeedPaymentController.text),
          laborCost: double.tryParse(laborPaymentController.text),
          fuelPrice: double.tryParse(fuelPaymentController.text),
          billPath: imagePath,
        );
        print("response");
        var res = json.decode(response.body);
        print(res);
        BlocProvider.of<SeedPlantBloc>(context).add(LoadSeedPlantInitial());
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
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Colors.black),
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     _inputActivityForm.activity_step,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 15,
                            width: 5,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("พันธุ์อ้อย"),
                        ],
                      ),
                      // Wrap(
                      //   children: seedType
                      //       .map((textStyle) {
                      //         return Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: GestureDetector(
                      //             onTap: () {
                      //               setState(() {
                      //                 selectedSeed = textStyle;
                      //               });
                      //             },
                      //             child: Container(
                      //               padding: EdgeInsets.only(
                      //                   top: 5, bottom: 5, left: 20, right: 20),
                      //               decoration: BoxDecoration(
                      //                 color: selectedSeed == textStyle
                      //                     ? Colors.blue
                      //                     : Colors.white,
                      //                 border: Border.all(
                      //                   color: selectedSeed == textStyle
                      //                       ? Colors.blue
                      //                       : Colors.grey,
                      //                   width: 3,
                      //                 ),
                      //                 borderRadius: BorderRadius.circular(5),
                      //               ),
                      //               child: Text(
                      //                 textStyle,
                      //                 style: TextStyle(
                      //                   color: selectedSeed == textStyle
                      //                       ? Colors.white
                      //                       : Colors.black,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         );
                      //       })
                      //       .toList()
                      //       .cast<Widget>(),
                      // ),

                      WarpCustomPick(
                        typeList: seedType,
                        typeSelected: selectedSeed,
                        selected: (value) {
                          setState(() {
                            selectedSeed = value;
                          });
                        },
                      ),
                      InputFormWidget(
                        textEditingController: otherSugarCaneController,
                        requireText: CustomTextValidate.requireNumberText(),
                        keyboardType: TextInputType.text,
                        title: "อื่นๆ",
                        validator: (value) {
                          return validateTextField(value);
                        },
                      ),
                      InputFormWidget(
                        textEditingController: betweenAreaController,
                        requireText: CustomTextValidate.requireNumberText(),
                        keyboardType: TextInputType.number,
                        title: "ระยะห่างระหว่างร่อง",
                        bit: "เมตร",
                        validator: (value) {
                          return validateTextField(value);
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 15,
                        width: 5,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("การใช้ปุ๋ยรองพื้น"),
                    ],
                  ),
                  WarpCustomPick(
                    typeList: fertilizerChoice,
                    typeSelected: selectedFertilizer,
                    selected: (value) {
                      setState(() {
                        selectedFertilizer = value;
                      });
                    },
                  ),
                  selectedFertilizer == "มี"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputFormWidget(
                              textEditingController:
                                  fertilizeTechnicalController,
                              requireText: CustomTextValidate.requireText(),
                              keyboardType: TextInputType.text,
                              title: "สูตรปุ๋ย",
                              validator: (value) {
                                return validateTextField(value);
                              },
                            ),
                            InputFormWidget(
                              textEditingController: fertilizeVolumeController,
                              requireText:
                                  CustomTextValidate.requireNumberText(),
                              keyboardType: TextInputType.number,
                              title: "ปริมาณที่ใช้",
                              bit: "กิโลกรัม",
                              validator: (value) {
                                return validateTextField(value);
                              },
                            ),
                          ],
                        )
                      : SizedBox(),
                  CustomTextFormFieldStyle.inputTitleTextStyle(
                    labelTextStr: "บักทึกค่าใช้จ่าย / เก็บใบเสร็จ",
                  ),
                  InputFormWidget(
                    textEditingController: sugarcaneCutPaymentController,
                    requireText: CustomTextValidate.requireNumberText(),
                    keyboardType: TextInputType.number,
                    title: "ค่าตัดทอนพันธุ์",
                    bit: "บาท",
                    validator: (value) {
                      return validateTextField(value);
                    },
                  ),
                  InputFormWidget(
                    textEditingController: sugarcaneVolumeController,
                    requireText: CustomTextValidate.requireNumberText(),
                    keyboardType: TextInputType.number,
                    title: "ปริมาณที่ใช้",
                    bit: "ตัน",
                    validator: (value) {
                      return validateTextField(value);
                    },
                  ),
                  InputFormWidget(
                    textEditingController: sugarcaneCutPriceController,
                    requireText: CustomTextValidate.requireNumberText(),
                    keyboardType: TextInputType.number,
                    title: "ราคาท่อนพันธุ์",
                    bit: "บาท",
                    validator: (value) {
                      return validateTextField(value);
                    },
                  ),
                  InputFormWidget(
                    textEditingController:
                        tractorForBetweenAreaPaymentController,
                    requireText: CustomTextValidate.requireNumberText(),
                    keyboardType: TextInputType.number,
                    title: "ค่าชักร่อง",
                    bit: "บาท",
                    validator: (value) {
                      return validateTextField(value);
                    },
                  ),
                  InputFormWidget(
                    textEditingController: fertilizePaymentController,
                    requireText: CustomTextValidate.requireNumberText(),
                    keyboardType: TextInputType.number,
                    title: "ค่าปุ๋ยรองพื้น",
                    bit: "บาท",
                    validator: (value) {
                      return validateTextField(value);
                    },
                  ),
                  InputFormWidget(
                    textEditingController: tractorForSeedPaymentController,
                    requireText: CustomTextValidate.requireNumberText(),
                    keyboardType: TextInputType.number,
                    title: "ค่าจ้างรถปลูกอ้อย",
                    bit: "บาท",
                    validator: (value) {
                      return validateTextField(value);
                    },
                  ),
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
