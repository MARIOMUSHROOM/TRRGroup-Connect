import 'dart:io';
import 'package:ai_flutter/user/models/trr_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:ai_flutter/profile/quantity_product_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../base_class/models/ai_base_model.dart';
import '../basic/pages/trr_basic_page.dart';
import '../basic/models/trr_object.dart';
import '../global_const.dart' as cons;
import './models/profile_product_year_summary_model.dart';
import './models/profile_product_year_agriculture.dart';
import './widget/profile_product_summary_widget.dart';
import '../user/models/trr_user_model.dart';

class UserProfilePage extends TrrBasicPageStatefulWidget {
  UserProfilePage({Key key, @required TrrData dataObj}) : super(key: key, dataObj: dataObj);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends TrrBasicPageState<UserProfilePage> {
  ImagePicker _imgPicker = ImagePicker();
  File _displayPhoto;
  bool _isUserEditPhoto = false;
  bool _canShowProfile = false;
  TrrGeneralUser _userObj;

  @override
  void initState() {
    super.initState();
    _canShowProfile = (widget.dataObj.userDataObj.userType == TrrUserType.General || widget.dataObj.userDataObj.userType == TrrUserType.Special);
    // Pointing to correct user object
    if (_canShowProfile) _userObj = widget.dataObj.userDataObj as TrrGeneralUser;
  }

  @override
  Widget internalBuild(BuildContext context) {
    // checking for available photo
    // _isUserEditPhoto = (widget.dataObj != null && widget.dataObj.user.photoUrl.isNotEmpty);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cons.kSolidBlueColor,
        title: Text('ข้อมูลส่วนตัว', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 26)),
        centerTitle: true,
        elevation: 0,
      ),
      body: _profilePageUI(),
    );
  }

  Widget _profilePageUI() {
    return Container(
      color: cons.kPageBackgroundColor,
      child: Column(
        children: [
          _userInfo(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              color: cons.kPageBackgroundColor,
              child: ProfileProductSummaryWidget(
                dataObj: widget.dataObj,
                tabYears: ProfileProductYearAgricultureList.dummyYear,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userInfo() {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, bottom: 10),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_userAvatar(), SizedBox(width: 20), _userDetail()], // user's photo and detail
          ),
          _userContact(), // user's contact information
        ],
      ),
    );
  }

  _doTakePhoto() async {
    PickedFile img = await _imgPicker.getImage(source: ImageSource.gallery);
    if (img != null && img.path != null) {
      File imgFile = await FlutterExifRotation.rotateImage(path: img.path);
      setState(() {
        _displayPhoto = imgFile;
        _isUserEditPhoto = _displayPhoto != null;
      });
    } else {
      // _imgPicker = ImagePicker();
      return;
    }
  }

  Widget _userAvatar() {
    return CircleAvatar(
      radius: 55,
      child: ClipOval(
        child: Stack(
          children: [
            !(_isUserEditPhoto)
                ? Image.network(
                    '',
                    // widget.dataObj.user.photoUrl,
                    fit: BoxFit.fill,
                    errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/profile/default_avatar.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  )
                // : Image(image: FileImage(_displayPhoto), fit: BoxFit.fill),
                : Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: FileImage(_displayPhoto), fit: BoxFit.cover),
                    ),
                  ),
            // : Image.file(_displayPhoto, fit: BoxFit.fill),

            GestureDetector(
              onTap: _doTakePhoto,
              child: Container(
                padding: EdgeInsets.only(bottom: 14),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                    stops: [0.0, 1.0],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Icon(Icons.edit, color: Colors.grey[300], size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.dataObj.userDataObj.profileName == '' ? 'ไม่มีข้อมูลผู้ใช้' : widget.dataObj.userDataObj.profileName,
          style: TextStyle(color: cons.kSolidBlueColor, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        _userDetailElement('เลขบัตรประชาชน', (_canShowProfile) ? (_userObj.profileObj.idNumber) : ''),
        _userDetailElement('เลขที่สัญญา', (_canShowProfile) ? '${_userObj.profileObj.idReference}' : ''),
        _userDetailElement('เลขที่ สอน.', (_canShowProfile) ? (_userObj.profileObj.officeSugarcaneId) : ''),
      ],
    );
  }

  Widget _userDetailElement(String aTitle, [String aValue = '']) {
    return Row(children: [
      Container(width: 90, child: Text(aTitle, style: TextStyle(fontSize: 19))),
      Text(aValue == '' ? 'ไม่มีข้อมูล' : aValue, style: TextStyle(fontSize: 19)),
    ]);
  }

  Widget _userContact() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _userContactElement(Icons.phone, (_canShowProfile) ? _userObj.profileObj.phoneNumber : ''),
          _userContactElement(Icons.location_on_outlined, (_canShowProfile) ? _userObj.profileObj.address : ''),
        ],
      ),
    );
  }

  Widget _userContactElement(IconData aIconData, [String aValue = '']) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(aIconData, size: 18, color: Colors.grey),
        Container(
          width: dvWidth * 0.50,
          padding: EdgeInsets.only(left: 10),
          child: Text(
            (aValue == '') ? 'ไม่มีข้อมูล' : aValue,
            maxLines: 2,
            style: TextStyle(fontSize: 19),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/* ------------------------------------------------------------------------------------------------------------------ */

// ProfilePage bundle to UserProfilePage widget
// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.black),
//         backgroundColor: Colors.white,
//         title: Text(
//           'โปรไฟล์',
//           textAlign: TextAlign.center,
//           style: GoogleFonts.kanit(textStyle: TextStyle(color: Colors.black)),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               color: Colors.white,
//               padding: EdgeInsets.all(10),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: CircleAvatar(
//                           radius: 60,
//                           child: ClipOval(
//                             child: Image.network(
//                               "",
//                               errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
//                                 return Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey[400],
//                                     shape: BoxShape.circle,
//                                   ),
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     "No Image",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                     ),
//                                     maxLines: 2,
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 7,
//                         child: Container(
//                           padding: EdgeInsets.all(8),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("กฤษฏา สังขีด"),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text("เลขบัตรประชาชน"),
//                                   ),
//                                   Expanded(
//                                     child: Text("11 2222 333 44"),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text("เลขสัญญา"),
//                                   ),
//                                   Expanded(
//                                     child: Text("TRR 5678 91"),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text("เลขที่สอน"),
//                                   ),
//                                   Expanded(
//                                     child: Text("1111111"),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Icon(Icons.phone_outlined),
//                               Text("089 101 1213"),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Icon(Icons.pin_drop_outlined),
//                               Text("25 ถ. สาทรใต้ แขวง ทุ่งมหาเมฆ"),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               color: Colors.white,
//               padding: EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 8,
//                         child: Text("ปริมาณผลผลิตอ้อย"),
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => QuantityProductPage()));
//                           },
//                           child: Container(
//                             color: Colors.grey[200],
//                             child: Icon(Icons.keyboard_arrow_right),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             _tabSection(context),
//           ],
//         ),
//       ),
//     );
//   }

// _tabSection logic move to file profile_product_summary_widget.dart
//   Widget _tabSection(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Container(
//             child: TabBar(
//               isScrollable: true,
//               // controller: tabController,
//               labelColor: Colors.blue,
//               unselectedLabelColor: Colors.grey,
//               tabs: [
//                 Tab(text: "ปี 65/66"),
//                 Tab(text: "ปี 64/65"),
//                 Tab(text: "ปี 63/64"),
//               ],
//             ),
//           ),
//           Container(
//             //Add this to give height
//             height: MediaQuery.of(context).size.height * 0.4,
//             child: TabBarView(children: [
//               Container(
//                 color: Colors.grey[100],
//                 child: Column(
//                   children: [
//                     Container(
//                       color: Colors.white,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: Column(
//                               children: [
//                                 Text("10 ตัน/ไร่"),
//                                 Text("ประมาณการณ์"),
//                                 Text("ผลผลิตอ้อย"),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: 30,
//                             child: VerticalDivider(
//                               color: Colors.white,
//                             ),
//                           ),
//                           Expanded(
//                             child: Column(
//                               children: [
//                                 Text("60 ตัน"),
//                                 Text("ผลิตอ้อย"),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 children: [
//                                   Text("72 ตัน"),
//                                   Text("สัญญาอ้อย"),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               height: 30,
//                               child: VerticalDivider(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             Expanded(
//                               child: Column(
//                                 children: [
//                                   Text("50 แปลง"),
//                                   Text("จำนวนแปลง"),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               height: 30,
//                               child: VerticalDivider(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             Expanded(
//                               child: Column(
//                                 children: [
//                                   Text("30 ไร่"),
//                                   Text("พื้นที่ทั้งหมด"),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "15 ไร่",
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   Text(
//                                     "พื้นที่เข้าร่วมโครงการ",
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   Text(
//                                     "GETS FRAMING",
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               height: 30,
//                               child: VerticalDivider(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "10 ไร่",
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   Text(
//                                     "พื้นที่เข้าร่วมโครงการ",
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   Text(
//                                     "BONSUCRO",
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               height: 30,
//                               child: VerticalDivider(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text("10"),
//                                   Text("ค่า CSS เฉลี่ย"),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 child: Text("No Data"),
//               ),
//               Container(
//                 child: Text("No Data"),
//               ),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }
// }
