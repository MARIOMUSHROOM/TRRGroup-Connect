// ProductReport is transform to ProfileProductYearSummaryModelItme widget
// profile_product_year_summary_model.dart

class ProductReport {
  ProductReport({
    this.product_real,
    this.product_ref,
    this.station_total,
    this.area_total,
    this.area_bonsucro,
    this.area_gets,
    this.estimate_product,
    this.css_mean,
    this.date,
  });
  num product_real;
  num product_ref;
  num station_total;
  num area_total;
  num area_bonsucro;
  num area_gets;
  num estimate_product;
  num css_mean;
  DateTime date;
}
