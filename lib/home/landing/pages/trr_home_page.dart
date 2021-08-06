import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../user/models/trr_user_model.dart';
import '../../../basic/models/trr_object.dart';
import '../../../basic/pages/trr_basic_page.dart';
import '../widgets/home_background_widget.dart';
import '../home_const.dart' as homeCons;
import '../../../global_utils.dart' as util;
import '../../../global_const.dart' as cons;
import '../widgets/home_weather_widget.dart';
import '../widgets/home_menu_grid_widget.dart';
import '../models/home_icon_model.dart';
import '../services/home_menu_navigate_controller.dart';
import '../models/home_weather_view_model.dart';
import '../../../profile/widget/custom_calendar_picker.dart';
import '../models/home_activity_model.dart';
import '../widgets/home_activity_widget.dart';
import '../widgets/home_news_widget.dart';
import '../models/home_news_model.dart';

// Weather bloc
import '../../../bloc/weather/bloc/global_weather_bloc.dart';

// Debugging class
import '../../../bloc/user/shared_preference/bloc/user_preference_bloc.dart';

const kUserImage = 'assets/images/landing/user.png';
const kAccessDeniedCaption = ' บัญชีผู้ใช้ของท่านไม่สามารถใช้งานเมนูนี้ได้';
const kCalendarCaption = 'ปฏิทินบันทึกกิจกรรม';

// ignore: must_be_immutable
class TrrHomePage extends TrrBasicPageStatefulWidget {
  TrrHomePage({Key key, TrrData dataObj}) : super(key: key, dataObj: dataObj);

  @override
  _TrrHomePageState createState() => _TrrHomePageState();
}

class _TrrHomePageState extends TrrBasicPageState<TrrHomePage> {
  HomeMenuNavigateController _navigateController;
  DateTime _focusDate;
  GlobalWeatherBloc _homeWeatherBloc;
  HomeWeatherViewSummary _homeWeatherSumObj = HomeWeatherViewSummary.instance;

  HomeMenuNavigateController get navigateController {
    if (_navigateController == null) {
      _navigateController = HomeMenuNavigateController(context: this.pageContext);
      _navigateController.onVerifiedPermission = _doOnNavigateControllerVerifiedAction;
    }
    return _navigateController;
  }

  bool isAlreadyBuild = false;

  Future<void> _doOnNavigateControllerVerifiedAction(bool aActionAllow) async {
    if (!aActionAllow) ScaffoldMessenger.of(pageContext).showSnackBar(_menuNotAllowSnackBar());
  }

  @override
  void initState() {
    super.initState();
    _homeWeatherBloc = BlocProvider.of<GlobalWeatherBloc>(context);
    // testing latitude and longitude
    //13.758919651850428, 100.51365381137792
    // _homeWeatherBloc.add(GlobalWeatherRetrieveDataEvent(13.758919651850428, 100.51365381137792));
    _refreshWeather();
  }

  void _refreshWeather() {
    _homeWeatherBloc.add(GlobalWeatherRetrieveDataEvent(13.758919651850428, 100.51365381137792));
  }

  @override
  Widget internalBuild(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _homePageUI(),
      ),
    );
  }

  Widget _homePageUI() {
    return Container(
      child: Stack(
        children: [
          HomePageBackgroundWidget(),
          _homeListView(),
        ],
      ),
    );
  }

  Widget _homeListView() {
    double topSpacing = dvHeight * 0.14;
    bool _isGuestUser = widget.dataObj.userDataObj.userType == TrrUserType.Guest;

    if (Platform.isIOS)
      topSpacing = dvHeight * 0.14;
    else if (Platform.isAndroid) topSpacing = dvHeight * 0.16;

    return util.verticalAnimation(
      CustomScrollView(
        slivers: [
          // Weather Widget
          BlocConsumer<GlobalWeatherBloc, GlobalWeatherState>(
            listener: (context, weatherState) {
              if (weatherState is GlobalWeatherLoadFinishState && _homeWeatherBloc.homeWeatherDataObj != null)
                _homeWeatherSumObj.generateFromWeatherData(_homeWeatherBloc.homeWeatherDataObj);
            },
            builder: (context, weatherState) {
              return SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: topSpacing), // top spacing
                    util.verticalAnimation(
                      Stack(
                        children: [
                          if (weatherState is GlobalWeatherLoadingState)
                            HomeWeatherWidget(_homeWeatherSumObj, true)
                          else
                            HomeWeatherWidget(_homeWeatherSumObj, false),
                          _userTag(), // User badge
                          _refreshWeatherButton(), // Refresh main weather button on the right
                        ],
                      ),
                      aStartPosition: 80,
                    ),
                  ],
                ),
              );
            },
          ),

          // // Grid Menu
          HomeMenuGridWidget(
            iconList: HomeIconModelList.instance,
            onIconTap: navigateController.onHomeMenuIconTap,
          ),

          // Activity List
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 10),
                  child: Divider(color: homeCons.kIconBgColor, thickness: 15),
                ),

                if (!_isGuestUser) _calendarActivity(),
                Container(
                  color: Colors.white,
                  child: Divider(color: homeCons.kIconBgColor, thickness: 5),
                ),
                HomeActivityListWidget(activities: dummyHomeActivityList()),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 10),
                  child: Divider(color: homeCons.kIconBgColor, thickness: 15),
                ),
                if (_isGuestUser) SizedBox(height: 0),

                // _calendarActivity(),
                // Container(
                //   color: Colors.white,
                //   child: Divider(color: homeCons.kIconBgColor, thickness: 5),
                // ),
                // HomeActivityListWidget(activities: dummyHomeActivityList()),
                // Container(
                //   color: Colors.white,
                //   padding: EdgeInsets.only(top: 10),
                //   child: Divider(color: homeCons.kIconBgColor, thickness: 15),
                // ),

                // !(_isGuestUser)
                //     ? {
                //         _calendarActivity(),
                //         Container(
                //           color: Colors.white,
                //           child: Divider(color: homeCons.kIconBgColor, thickness: 5),
                //         ),
                //         HomeActivityListWidget(activities: dummyHomeActivityList()),
                //         Container(
                //           color: Colors.white,
                //           padding: EdgeInsets.only(top: 10),
                //           child: Divider(color: homeCons.kIconBgColor, thickness: 15),
                //         ),
                //       }
                //     : SizedBox(height: 0),
              ],
            ),
          ),

          // // News
          SliverList(
            delegate: SliverChildListDelegate([HomeNewsFeedWidget(newsList: dummyNewsList())]),
          ),
        ],
      ),
      aMilliseconds: 2000,
      aStartPosition: 200,
    );
  }

  Widget _refreshWeatherButton() {
    return Positioned(
      right: 1,
      top: 0,
      child: Container(
        // width: 30,
        // height: 30,
        // color: Colors.red,
        child: IconButton(
          onPressed: () => _refreshWeather(),
          icon: Icon(Icons.replay_outlined, color: Colors.white),
        ),
        // color: Colors.red,
      ),
    );
  }

  Widget _userTag() {
    return util.verticalAnimation(
      Align(
        child: Container(
          height: dvHeight * 0.06,
          width: dvWidth * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () {
                  // Test clear device preference
                  UserPreferenceBloc _prefBloc = BlocProvider.of<UserPreferenceBloc>(pageContext);
                  _prefBloc.add(UserPreferenceClearDevicePreferenceEvent());
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: homeCons.kSolidBlueColor),
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Image(image: AssetImage(kUserImage), color: homeCons.kSolidBlueColor, height: 30),
                ),
              ),
              Text('สวัสดีคุณ ${widget.dataObj.userDataObj.displayName}', style: TextStyle(color: homeCons.kSolidBlueColor)),
            ],
          ),
        ),
      ),
      aMilliseconds: 2900,
      aStartPosition: 50,
    );
  }

  Widget _calendarActivity() {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kCalendarCaption,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: homeCons.kGoldColor),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomYearPickerWidget(
              focusedDay: (value) {
                setState(() {
                  _focusDate = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  SnackBar _menuNotAllowSnackBar() {
    final resultSnackBar = SnackBar(
      content: Container(
          padding: EdgeInsets.all(2),
          child: Row(
            children: [
              Icon(Icons.error, color: Colors.white, size: 24),
              Text(
                kAccessDeniedCaption,
                style: TextStyle(color: Colors.white, fontSize: 16, height: 1.0),
              ),
            ],
          )),
      backgroundColor: cons.kGoldColor,
      behavior: SnackBarBehavior.floating,
      elevation: 10.0,
      margin: EdgeInsets.all(6),
      duration: Duration(seconds: 3),
    );
    return resultSnackBar;
  }
}
