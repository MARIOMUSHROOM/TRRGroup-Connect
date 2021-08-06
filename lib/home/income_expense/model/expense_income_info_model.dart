// To parse this JSON data, do
//
//     final expenseIncomeInfo = expenseIncomeInfoFromJson(jsonString);

import 'dart:convert';

List<ExpenseIncomeInfo> expenseIncomeInfoFromJson(String str) =>
    List<ExpenseIncomeInfo>.from(
        json.decode(str).map((x) => ExpenseIncomeInfo.fromJson(x)));

String expenseIncomeInfoToJson(List<ExpenseIncomeInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseIncomeInfo {
  ExpenseIncomeInfo({
    this.expensesCost,
    this.tractorTotal,
    this.laborTotal,
    this.fuelTotal,
    this.priceTotal,
    this.cutoffTotal,
    this.gougeTotal,
    this.foundationTotal,
    this.growerTotal,
    this.ureaTotal,
    this.sprayTotal,
    this.chemicalTotal,
    this.contractTotal,
    this.sackTotal,
    this.machineTotal,
    this.harvestTotal,
    this.grabTotal,
    this.transportTotal,
    this.graphData,
    this.totalIncomeCost,
    this.totalExpensesCost,
    this.totalBalance,
    this.plotSpace,
    this.averageCost,
    this.tractorPercent,
    this.laborPercent,
    this.fuelPercent,
    this.pricePercent,
    this.cutoffPercent,
    this.gougePercent,
    this.growerPercent,
    this.foundationPercent,
    this.ureaPercent,
    this.sprayPercent,
    this.chemicaPercent,
    this.contractPercent,
    this.sackPercent,
    this.machinePercent,
    this.harvestPercent,
    this.grabPercent,
    this.transportPercent,
    this.yearData,
  });

  double expensesCost;
  double tractorTotal;
  double laborTotal;
  double fuelTotal;
  double priceTotal;
  double cutoffTotal;
  double gougeTotal;
  double foundationTotal;
  double growerTotal;
  double ureaTotal;
  double sprayTotal;
  double chemicalTotal;
  double contractTotal;
  double sackTotal;
  double machineTotal;
  double harvestTotal;
  double grabTotal;
  double transportTotal;
  List<GraphDatum> graphData;
  double totalIncomeCost;
  double totalExpensesCost;
  double totalBalance;
  double plotSpace;
  double averageCost;
  double tractorPercent;
  double laborPercent;
  double fuelPercent;
  double pricePercent;
  double cutoffPercent;
  double gougePercent;
  double growerPercent;
  double foundationPercent;
  double ureaPercent;
  double sprayPercent;
  double chemicaPercent;
  double contractPercent;
  double sackPercent;
  double machinePercent;
  double harvestPercent;
  double grabPercent;
  double transportPercent;
  List<String> yearData;

  factory ExpenseIncomeInfo.fromJson(Map<String, dynamic> json) =>
      ExpenseIncomeInfo(
        expensesCost: json["expensesCost"] == null
            ? null
            : json["expensesCost"].toDouble(),
        tractorTotal: json["tractorTotal"] == null
            ? null
            : json["tractorTotal"].toDouble(),
        laborTotal:
            json["laborTotal"] == null ? null : json["laborTotal"].toDouble(),
        fuelTotal:
            json["fuelTotal"] == null ? null : json["fuelTotal"].toDouble(),
        priceTotal:
            json["priceTotal"] == null ? null : json["priceTotal"].toDouble(),
        cutoffTotal:
            json["cutoffTotal"] == null ? null : json["cutoffTotal"].toDouble(),
        gougeTotal:
            json["gougeTotal"] == null ? null : json["gougeTotal"].toDouble(),
        foundationTotal: json["foundationTotal"] == null
            ? null
            : json["foundationTotal"].toDouble(),
        growerTotal:
            json["growerTotal"] == null ? null : json["growerTotal"].toDouble(),
        ureaTotal:
            json["ureaTotal"] == null ? null : json["ureaTotal"].toDouble(),
        sprayTotal:
            json["sprayTotal"] == null ? null : json["sprayTotal"].toDouble(),
        chemicalTotal: json["chemicalTotal"] == null
            ? null
            : json["chemicalTotal"].toDouble(),
        contractTotal: json["contractTotal"] == null
            ? null
            : json["contractTotal"].toDouble(),
        sackTotal:
            json["sackTotal"] == null ? null : json["sackTotal"].toDouble(),
        machineTotal: json["machineTotal"] == null
            ? null
            : json["machineTotal"].toDouble(),
        harvestTotal: json["harvestTotal"] == null
            ? null
            : json["harvestTotal"].toDouble(),
        grabTotal:
            json["grabTotal"] == null ? null : json["grabTotal"].toDouble(),
        transportTotal: json["transportTotal"] == null
            ? null
            : json["transportTotal"].toDouble(),
        graphData: json["graphData"] == null
            ? null
            : List<GraphDatum>.from(
                json["graphData"].map((x) => GraphDatum.fromJson(x))),
        totalIncomeCost: json["totalIncomeCost"] == null
            ? null
            : json["totalIncomeCost"].toDouble(),
        totalExpensesCost: json["totalExpensesCost"] == null
            ? null
            : json["totalExpensesCost"].toDouble(),
        totalBalance: json["totalBalance"] == null
            ? null
            : json["totalBalance"].toDouble(),
        plotSpace:
            json["plotSpace"] == null ? null : json["plotSpace"].toDouble(),
        averageCost:
            json["averageCost"] == null ? null : json["averageCost"].toDouble(),
        tractorPercent: json["tractorPercent"] == null
            ? null
            : json["tractorPercent"].toDouble(),
        laborPercent: json["laborPercent"] == null
            ? null
            : json["laborPercent"].toDouble(),
        fuelPercent:
            json["fuelPercent"] == null ? null : json["fuelPercent"].toDouble(),
        pricePercent: json["pricePercent"] == null
            ? null
            : json["pricePercent"].toDouble(),
        cutoffPercent: json["cutoffPercent"] == null
            ? null
            : json["cutoffPercent"].toDouble(),
        gougePercent: json["gougePercent"] == null
            ? null
            : json["gougePercent"].toDouble(),
        growerPercent: json["growerPercent"] == null
            ? null
            : json["growerPercent"].toDouble(),
        foundationPercent: json["foundationPercent"] == null
            ? null
            : json["foundationPercent"].toDouble(),
        ureaPercent:
            json["ureaPercent"] == null ? null : json["ureaPercent"].toDouble(),
        sprayPercent: json["sprayPercent"] == null
            ? null
            : json["sprayPercent"].toDouble(),
        chemicaPercent: json["chemicaPercent"] == null
            ? null
            : json["chemicaPercent"].toDouble(),
        contractPercent: json["contractPercent"] == null
            ? null
            : json["contractPercent"].toDouble(),
        sackPercent:
            json["sackPercent"] == null ? null : json["sackPercent"].toDouble(),
        machinePercent: json["machinePercent"] == null
            ? null
            : json["machinePercent"].toDouble(),
        harvestPercent: json["harvestPercent"] == null
            ? null
            : json["harvestPercent"].toDouble(),
        grabPercent:
            json["grabPercent"] == null ? null : json["grabPercent"].toDouble(),
        transportPercent: json["transportPercent"] == null
            ? null
            : json["transportPercent"].toDouble(),
        yearData: json["yearData"] == null
            ? null
            : List<String>.from(json["yearData"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "expensesCost": expensesCost == null ? null : expensesCost,
        "tractorTotal": tractorTotal == null ? null : tractorTotal,
        "laborTotal": laborTotal == null ? null : laborTotal,
        "fuelTotal": fuelTotal == null ? null : fuelTotal,
        "priceTotal": priceTotal == null ? null : priceTotal,
        "cutoffTotal": cutoffTotal == null ? null : cutoffTotal,
        "gougeTotal": gougeTotal == null ? null : gougeTotal,
        "foundationTotal": foundationTotal == null ? null : foundationTotal,
        "growerTotal": growerTotal == null ? null : growerTotal,
        "ureaTotal": ureaTotal == null ? null : ureaTotal,
        "sprayTotal": sprayTotal == null ? null : sprayTotal,
        "chemicalTotal": chemicalTotal == null ? null : chemicalTotal,
        "contractTotal": contractTotal == null ? null : contractTotal,
        "sackTotal": sackTotal == null ? null : sackTotal,
        "machineTotal": machineTotal == null ? null : machineTotal,
        "harvestTotal": harvestTotal == null ? null : harvestTotal,
        "grabTotal": grabTotal == null ? null : grabTotal,
        "transportTotal": transportTotal == null ? null : transportTotal,
        "graphData": graphData == null
            ? null
            : List<dynamic>.from(graphData.map((x) => x.toJson())),
        "totalIncomeCost": totalIncomeCost == null ? null : totalIncomeCost,
        "totalExpensesCost":
            totalExpensesCost == null ? null : totalExpensesCost,
        "totalBalance": totalBalance == null ? null : totalBalance,
        "plotSpace": plotSpace == null ? null : plotSpace,
        "averageCost": averageCost == null ? null : averageCost,
        "tractorPercent": tractorPercent == null ? null : tractorPercent,
        "laborPercent": laborPercent == null ? null : laborPercent,
        "fuelPercent": fuelPercent == null ? null : fuelPercent,
        "pricePercent": pricePercent == null ? null : pricePercent,
        "cutoffPercent": cutoffPercent == null ? null : cutoffPercent,
        "gougePercent": gougePercent == null ? null : gougePercent,
        "growerPercent": growerPercent == null ? null : growerPercent,
        "foundationPercent":
            foundationPercent == null ? null : foundationPercent,
        "ureaPercent": ureaPercent == null ? null : ureaPercent,
        "sprayPercent": sprayPercent == null ? null : sprayPercent,
        "chemicaPercent": chemicaPercent == null ? null : chemicaPercent,
        "contractPercent": contractPercent == null ? null : contractPercent,
        "sackPercent": sackPercent == null ? null : sackPercent,
        "machinePercent": machinePercent == null ? null : machinePercent,
        "harvestPercent": harvestPercent == null ? null : harvestPercent,
        "grabPercent": grabPercent == null ? null : grabPercent,
        "transportPercent": transportPercent == null ? null : transportPercent,
        "yearData": yearData == null
            ? null
            : List<dynamic>.from(yearData.map((x) => x)),
      };
}

class GraphDatum {
  GraphDatum({
    this.year,
    this.expensesCost,
    this.inComeCost,
  });

  String year;
  double expensesCost;
  double inComeCost;

  factory GraphDatum.fromJson(Map<String, dynamic> json) => GraphDatum(
        year: json["year"] == null ? null : json["year"],
        expensesCost: json["expensesCost"] == null
            ? null
            : json["expensesCost"].toDouble(),
        inComeCost:
            json["inComeCost"] == null ? null : json["inComeCost"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "year": year == null ? null : year,
        "expensesCost": expensesCost == null ? null : expensesCost,
        "inComeCost": inComeCost == null ? null : inComeCost,
      };
}
