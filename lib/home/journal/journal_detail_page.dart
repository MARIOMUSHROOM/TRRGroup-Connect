import 'package:ai_flutter/home/journal/model/journal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';

class JournalDetailPage extends StatefulWidget {
  JournalDetailPage({Key key, @required this.data}) : super(key: key);
  JournalData data;
  @override
  _JournalDetailPageState createState() => _JournalDetailPageState(this.data);
}

class _JournalDetailPageState extends State<JournalDetailPage> {
  _JournalDetailPageState(this.data);
  JournalData data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            data.title.toString(),
            textAlign: TextAlign.center,
            style: GoogleFonts.kanit(textStyle: TextStyle(color: Colors.white)),
          ),
          centerTitle: true,
        ),
        body: const PDF().fromUrl(
          data.journalFile,
          placeholder: (double progress) => Center(child: Text('$progress %')),
          errorWidget: (dynamic error) => Center(child: Text(error.toString())),
        ));
  }
}
