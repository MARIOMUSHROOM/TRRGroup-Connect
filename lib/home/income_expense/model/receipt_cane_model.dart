// To parse this JSON data, do
//
//     final receiptCaneModel = receiptCaneModelFromJson(jsonString);

import 'dart:convert';

ReceiptCaneModel receiptCaneModelFromJson(String str) =>
    ReceiptCaneModel.fromJson(json.decode(str));

String receiptCaneModelToJson(ReceiptCaneModel data) =>
    json.encode(data.toJson());

class ReceiptCaneModel {
  ReceiptCaneModel({
    this.result,
    this.agricultureYear,
    this.installmentList,
  });

  int result;
  String agricultureYear;
  List<InstallmentList> installmentList;

  factory ReceiptCaneModel.fromJson(Map<String, dynamic> json) =>
      ReceiptCaneModel(
        result: json["result"] == null ? null : json["result"],
        agricultureYear:
            json["agriculture_year"] == null ? null : json["agriculture_year"],
        installmentList: json["installment_list"] == null
            ? null
            : List<InstallmentList>.from(json["installment_list"]
                .map((x) => InstallmentList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "agriculture_year": agricultureYear == null ? null : agricultureYear,
        "installment_list": installmentList == null
            ? null
            : List<dynamic>.from(installmentList.map((x) => x.toJson())),
      };
}

class InstallmentList {
  InstallmentList({
    this.installmentNo,
    this.beginDate,
    this.endDate,
    this.installmentDate,
    this.saleTo,
    this.branch,
    this.taxId,
    this.sugarcaneWeight,
    this.income,
    this.expenseSum,
    this.deptDecreaseSum,
    this.balance,
    this.cumulativeSugarcaneAmount,
    this.freshSugarcaneAmount,
    this.burnSugarcaneAmount,
    this.deptAmount,
    this.totalAmount,
    this.paymentList,
  });

  int installmentNo;
  DateTime beginDate;
  DateTime endDate;
  DateTime installmentDate;
  String saleTo;
  String branch;
  String taxId;
  double sugarcaneWeight;
  double income;
  double expenseSum;
  double deptDecreaseSum;
  double balance;
  dynamic cumulativeSugarcaneAmount;
  dynamic freshSugarcaneAmount;
  String burnSugarcaneAmount;
  int deptAmount;
  String totalAmount;
  List<PaymentList> paymentList;

  factory InstallmentList.fromJson(Map<String, dynamic> json) =>
      InstallmentList(
        installmentNo:
            json["installment_no"] == null ? null : json["installment_no"],
        beginDate: json["begin_date"] == null
            ? null
            : DateTime.parse(json["begin_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        installmentDate: json["installment_date"] == null
            ? null
            : DateTime.parse(json["installment_date"]),
        saleTo: json["Sale_to"] == null ? null : json["Sale_to"],
        branch: json["branch"] == null ? null : json["branch"],
        taxId: json["tax_id"] == null ? null : json["tax_id"],
        sugarcaneWeight: json["sugarcane_weight"] == null
            ? null
            : json["sugarcane_weight"].toDouble(),
        income: json["income"] == null ? null : json["income"].toDouble(),
        expenseSum:
            json["expense_sum"] == null ? null : json["expense_sum"].toDouble(),
        deptDecreaseSum: json["dept_decrease_sum"] == null
            ? null
            : json["dept_decrease_sum"].toDouble(),
        balance: json["balance"] == null ? null : json["balance"].toDouble(),
        cumulativeSugarcaneAmount: json["cumulative_sugarcane_amount"],
        freshSugarcaneAmount: json["fresh_sugarcane_amount"],
        burnSugarcaneAmount: json["burn_sugarcane_amount"] == null
            ? null
            : json["burn_sugarcane_amount"],
        deptAmount: json["dept_amount"] == null ? null : json["dept_amount"],
        totalAmount: json["total_amount"] == null ? null : json["total_amount"],
        paymentList: json["payment_list"] == null
            ? null
            : List<PaymentList>.from(
                json["payment_list"].map((x) => PaymentList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "installment_no": installmentNo == null ? null : installmentNo,
        "begin_date": beginDate == null ? null : beginDate.toIso8601String(),
        "end_date": endDate == null ? null : endDate.toIso8601String(),
        "installment_date":
            installmentDate == null ? null : installmentDate.toIso8601String(),
        "Sale_to": saleTo == null ? null : saleTo,
        "branch": branch == null ? null : branch,
        "tax_id": taxId == null ? null : taxId,
        "sugarcane_weight": sugarcaneWeight == null ? null : sugarcaneWeight,
        "income": income == null ? null : income,
        "expense_sum": expenseSum == null ? null : expenseSum,
        "dept_decrease_sum": deptDecreaseSum == null ? null : deptDecreaseSum,
        "balance": balance == null ? null : balance,
        "cumulative_sugarcane_amount": cumulativeSugarcaneAmount,
        "fresh_sugarcane_amount": freshSugarcaneAmount,
        "burn_sugarcane_amount":
            burnSugarcaneAmount == null ? null : burnSugarcaneAmount,
        "dept_amount": deptAmount == null ? null : deptAmount,
        "total_amount": totalAmount == null ? null : totalAmount,
        "payment_list": paymentList == null
            ? null
            : List<dynamic>.from(paymentList.map((x) => x.toJson())),
      };
}

class PaymentList {
  PaymentList({
    this.paymentType,
    this.bankBranch,
    this.referenceNo,
    this.chequeDate,
    this.paymentTotal,
  });

  String paymentType;
  String bankBranch;
  String referenceNo;
  DateTime chequeDate;
  double paymentTotal;

  factory PaymentList.fromJson(Map<String, dynamic> json) => PaymentList(
        paymentType: json["payment_type"] == null ? null : json["payment_type"],
        bankBranch: json["bank_branch"] == null ? null : json["bank_branch"],
        referenceNo: json["reference_no"] == null ? null : json["reference_no"],
        chequeDate: json["cheque_date"] == null
            ? null
            : DateTime.parse(json["cheque_date"]),
        paymentTotal: json["payment_total"] == null
            ? null
            : json["payment_total"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "payment_type": paymentType == null ? null : paymentType,
        "bank_branch": bankBranch == null ? null : bankBranch,
        "reference_no": referenceNo == null ? null : referenceNo,
        "cheque_date": chequeDate == null ? null : chequeDate.toIso8601String(),
        "payment_total": paymentTotal == null ? null : paymentTotal,
      };
}
