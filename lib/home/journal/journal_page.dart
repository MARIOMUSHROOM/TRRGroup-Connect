import 'package:ai_flutter/bloc/journal_state/bloc/journal_bloc.dart';
import 'package:ai_flutter/home/journal/journal_detail_page.dart';
import 'package:ai_flutter/home/journal/model/journal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ai_flutter/home/journal/test/test_data.dart';

class JournalPage extends StatelessWidget {
  JournalPage({Key key}) : super(key: key);
  TextEditingController searchController = TextEditingController();
  JournalModel journalList;
  JournalBloc _journalBloc;
  Widget widgetBox = Center(
    child: Container(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(),
    ),
  );
  double _height;
  double _width;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _journalBloc = BlocProvider.of<JournalBloc>(context);
    return BlocBuilder<JournalBloc, JournalState>(
      builder: (context, state) {
        if (state is JournalInitial) {
          _journalBloc.add(LoadJournalInitial());
        } else if (state is JournalLoaded) {
          journalList = _journalBloc.journalList;
          widgetBox = Container(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: journalList.data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    var route = MaterialPageRoute(
                        builder: (context) =>
                            JournalDetailPage(data: journalList.data[index]));
                    Navigator.push(context, route);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: Container(
                      height: 120,
                      width: _width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  // height: 80,
                                  // width: 80,
                                  decoration: new BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                    image: new DecorationImage(
                                      // image: new ExactAssetImage(
                                      //     'assets/images/cards/pastel_card_01.jpg'),
                                      // fit: BoxFit.cover,
                                      image: NetworkImage(
                                        journalList.data[index].image,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // child: Icon(
                                  //   Icons.image_outlined,
                                  //   size: 50,
                                  //   color: Colors.grey,
                                  // ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      journalList.data[index].title,
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                      maxLines: 2,
                                    ),
                                    Text(
                                      journalList.data[index].date,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'วารสาร',
                textAlign: TextAlign.center,
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(color: Colors.white)),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: _width,
                    color: Colors.grey[200],
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: TextFormField(
                        autofocus: false,
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                        keyboardType: TextInputType.text,
                        controller: searchController,
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.search),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onChanged: (value) {
                          // onSearchTextChanged(value);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'กรุณาระบุ';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  widgetBox
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
