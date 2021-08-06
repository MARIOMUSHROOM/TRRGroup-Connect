import 'package:ai_flutter/data/network.dart';
import 'package:flutter/material.dart';

class ActivityNews extends StatefulWidget {
  @override
  _ActivityNewsState createState() => _ActivityNewsState();
}

class _ActivityNewsState extends State<ActivityNews> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: fetchNewsData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                // controller: _scrollController,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data[index].url),
                    ),
                    title: Text(snapshot.data[index].title),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text('Not Found Data'),
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
