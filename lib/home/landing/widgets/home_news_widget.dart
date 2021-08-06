import 'package:flutter/material.dart';
import '../../../base_class/pages/ai_base_page.dart';
import '../home_const.dart' as homeCons;
import '../models/home_news_model.dart';
import '../../../global_utils.dart' as util;

// ignore: must_be_immutable
class HomeNewsFeedWidget extends AiBaseStatelessWidget {
  final HomeNewsModelList newsList;

  HomeNewsFeedWidget({@required this.newsList});

  var delay = 0;

  @override
  Widget internalBuild(BuildContext context) {
    final latestNews = (newsList != null) && (newsList.newsItems.isNotEmpty) ? newsList.newsItems.first : null;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('NEWS', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: homeCons.kGoldColor)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(color: Colors.grey[400]),
                ),
              ),
              Text('ดูเพิ่มเติม', style: TextStyle(fontSize: 18, color: Colors.grey)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('ข่าวล่าสุด', style: TextStyle(color: Colors.grey, fontSize: 18)),
          ),

          // Show latest news
          if (latestNews != null)
            HomeNewsContentItemWidget(
              height: dvHeight * 0.34,
              width: dvWidth,
              newsItem: latestNews,
              isEnablePadding: false,
            ),

          // Show list of news
          Container(
            // padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ข่าวทั้งหมด'),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  height: dvHeight * 0.22,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: newsList.newsItems.length,
                    itemBuilder: (ctx, id) {
                      delay += 20;
                      return util.verticalAnimation(
                        HomeNewsContentItemWidget(height: 200, width: 200, newsItem: newsList.newsItems[id]),
                        aMilliseconds: 200 + delay,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeNewsContentItemWidget extends StatelessWidget {
  final double height;
  final double width;
  // final String title;
  // final String subtitle;

  final HomeNewsModelItem newsItem;
  final bool isEnablePadding;

  HomeNewsContentItemWidget({
    @required this.height,
    @required this.width,
    // @required this.title,
    // @required this.subtitle,
    @required this.newsItem,
    this.isEnablePadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: (isEnablePadding) ? const EdgeInsets.only(right: 16) : const EdgeInsets.all(0),
        // padding: EdgeInsets.only(top: 0),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(offset: Offset(3, 3), blurRadius: 6.0, color: Colors.grey.withOpacity(0.4))],
                    image: DecorationImage(image: AssetImage(newsItem.newsImage), fit: BoxFit.cover),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(newsItem.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(height: 1.05, fontSize: 26)),
                      Text(
                        newsItem.subTitle.toString(),
                        // subtitle.toString(),
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
