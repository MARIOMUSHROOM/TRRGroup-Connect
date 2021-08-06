import 'package:ai_flutter/home/news/activity_news.dart';
import 'package:ai_flutter/home/news/knowledge_news.dart';
import 'package:ai_flutter/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'ข่าวสาร',
            style: GoogleFonts.kanit(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                textStyle: TextStyle(color: Colors.white)),
          ),
          backgroundColor: kPrimaryColor),
      body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorSize: TabBarIndicatorSize.label,
                      isScrollable: true,
                      indicatorColor: Colors.white,
                      tabs: [
                        Tab(
                          child: Text(
                            'กิจกรรม',
                            style: GoogleFonts.kanit(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'เกร็ดความรู้',
                            style: GoogleFonts.kanit(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ActivityNews(),
                KnowledgeNews(),
              ],
            ),
          )),
    );
  }
}
