// To parse this JSON data, do
//
//     final journalModel = journalModelFromJson(jsonString);

import 'dart:convert';

JournalModel journalModelFromJson(String str) =>
    JournalModel.fromJson(json.decode(str));

String journalModelToJson(JournalModel data) => json.encode(data.toJson());

class JournalModel {
  JournalModel({
    this.data,
    this.hasMore,
  });

  List<JournalData> data;
  bool hasMore;

  factory JournalModel.fromJson(Map<String, dynamic> json) => JournalModel(
        data: json["data"] == null
            ? null
            : List<JournalData>.from(
                json["data"].map((x) => JournalData.fromJson(x))),
        hasMore: json["hasMore"] == null ? null : json["hasMore"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "hasMore": hasMore == null ? null : hasMore,
      };
}

class JournalData {
  JournalData({
    this.idJournal,
    this.title,
    this.image,
    this.journalFile,
    this.date,
  });

  int idJournal;
  String title;
  String image;
  String journalFile;
  String date;

  factory JournalData.fromJson(Map<String, dynamic> json) => JournalData(
        idJournal: json["idJournal"] == null ? null : json["idJournal"],
        title: json["title"] == null ? null : json["title"],
        image: json["image"] == null ? null : json["image"],
        journalFile: json["journal_file"] == null ? null : json["journal_file"],
        date: json["date"] == null ? null : json["date"],
      );

  Map<String, dynamic> toJson() => {
        "idJournal": idJournal == null ? null : idJournal,
        "title": title == null ? null : title,
        "image": image == null ? null : image,
        "journal_file": journalFile == null ? null : journalFile,
        "date": date == null ? null : date,
      };
}
