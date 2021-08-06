import 'package:ai_flutter/data/network.dart';
import 'package:flutter/material.dart';

class KnowledgeNews extends StatefulWidget {
  @override
  _KnowledgeNewsState createState() => _KnowledgeNewsState();
}

class _KnowledgeNewsState extends State<KnowledgeNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: fetchNewsData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  print(snapshot);
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
