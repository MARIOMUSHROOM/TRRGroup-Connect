import '../../base_class/models/ai_base_model.dart';
import './profile_product_year_agriculture.dart';

class ProfileProductYearSummaryItemModel extends AiBasicItem {
  ProfileProductYearSummaryItemModel({
    this.productReal = 0,
    this.productRef = 0,
    this.plotAmount = 0,
    this.areaTotal = 0,
    this.areaBonsucro = 0,
    this.areaGets = 0,
    this.estimateProduct = 0,
    this.cssMean = 0,
    this.date,
  });
  num productReal;
  num productRef;
  num plotAmount;
  num areaTotal;
  num areaBonsucro;
  num areaGets;
  num estimateProduct;
  num cssMean;
  DateTime date;

  @override
  void internalCopyFrom(dynamic aSource) {
    super.internalCopyFrom(aSource);
    if (aSource != null && aSource.runtimeType == this.runtimeType) {
      var source = aSource as ProfileProductYearSummaryItemModel;
      productReal = source.productReal;
      productRef = source.productRef;
      plotAmount = source.plotAmount;
      areaTotal = source.areaTotal;
      areaBonsucro = source.areaBonsucro;
      areaGets = source.areaGets;
      estimateProduct = source.estimateProduct;
      cssMean = source.cssMean;
      date = source.date;
    }
  }
}

final ProfileProductYearSummaryItemModel year1 = new ProfileProductYearSummaryItemModel(
  productReal: 13,
  productRef: 68,
  plotAmount: 23,
  areaTotal: 56,
  areaBonsucro: 33,
  areaGets: 76,
  estimateProduct: 124,
  cssMean: 111,
  date: DateTime.now(),
);

final ProfileProductYearSummaryItemModel year2 = new ProfileProductYearSummaryItemModel(
  productReal: 56,
  productRef: 45,
  plotAmount: 12,
  areaTotal: 98,
  areaBonsucro: 43,
  areaGets: 90,
  estimateProduct: 190,
  cssMean: 222,
  date: DateTime.now(),
);

final ProfileProductYearSummaryItemModel year3 = new ProfileProductYearSummaryItemModel(
  productReal: 98,
  productRef: 33,
  plotAmount: 44,
  areaTotal: 88,
  areaBonsucro: 15,
  areaGets: 86,
  estimateProduct: 768,
  cssMean: 333,
  date: DateTime.now(),
);

final ProfileProductYearSummaryItemModel year4 = new ProfileProductYearSummaryItemModel(
  productReal: 54,
  productRef: 98,
  plotAmount: 35,
  areaTotal: 51,
  areaBonsucro: 87,
  areaGets: 39,
  estimateProduct: 356,
  cssMean: 444,
  date: DateTime.now(),
);

final ProfileProductYearSummaryItemModel year5 = new ProfileProductYearSummaryItemModel(
  productReal: 67,
  productRef: 923,
  plotAmount: 21,
  areaTotal: 76,
  areaBonsucro: 45,
  areaGets: 85,
  estimateProduct: 1987,
  cssMean: 555,
  date: DateTime.now(),
);

void samplingYearSummary(
  ProfileProductYearAgricultureItem aAgricultureYear,
  ProfileProductYearSummaryItemModel aModel,
) {
  if (aAgricultureYear != null) {
    switch (aAgricultureYear.id) {
      case 1:
        aModel.copyFrom(year1);
        return;
      case 2:
        aModel.copyFrom(year2);
        return;
      case 3:
        aModel.copyFrom(year3);
        return;
      case 4:
        aModel.copyFrom(year4);
        return;
      case 5:
        aModel.copyFrom(year5);
        return;
      default:
        aModel.copyFrom(year1);
        return;
    }
  }
}
