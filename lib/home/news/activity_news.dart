//import 'package:ai_flutter/data/network.dart';
import 'package:ai_flutter/home/news/news_models.dart';
import 'package:ai_flutter/home/news/news.dart';
import 'package:flutter/material.dart';

class ActivityNews extends StatefulWidget {


  @override
  _ActivityNewsState createState() => _ActivityNewsState();
}

class _ActivityNewsState extends State<ActivityNews> {
  final scrollController = ScrollController();
  PostsModel posts;

  @override
  void initState() {
    posts = PostsModel();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        posts.loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: posts.stream,
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if(!_snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(
            onRefresh: posts.refresh,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              controller: scrollController,
              separatorBuilder: (context, index) => Divider(),
              itemCount: _snapshot.data.length + 1,
              itemBuilder: (BuildContext _context, int index) {
                if(index < _snapshot.data.length){
                  return Post(post: _snapshot.data[index]);
                } else if(posts.hasMore){
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(child: Text('nothing more to load!')),
                  );
                }
              },
            ),
          );
        }
      },
    );
  }
}