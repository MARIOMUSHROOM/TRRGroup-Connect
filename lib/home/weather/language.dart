langMonth(month) {
  String monthText;
  if (month == 1) {
    monthText = 'มกราคม';
  } else if (month == 2) {
    monthText = 'กุมภาพันธ์';
  } else if (month == 3) {
    monthText = 'มีนาคม';
  } else if (month == 4) {
    monthText = 'เมษายน';
  } else if (month == 5) {
    monthText = 'พฤศภาคม';
  } else if (month == 6) {
    monthText = 'มิถุนายน';
  } else if (month == 7) {
    monthText = 'กรกฎาคม';
  } else if (month == 8) {
    monthText = 'สิงหาคม';
  } else if (month == 9) {
    monthText = 'กันยายน';
  } else if (month == 10) {
    monthText = 'ตุลาคม';
  } else if (month == 11) {
    monthText = 'พฤศจิกายน';
  } else if (month == 12) {
    monthText = 'ธันวาคม';
  }
  return monthText;
}

langDate(date) {
  String dateText;
  if (date == 'Mon') {
    dateText = 'จันทร์';
  } else if (date == 'Tue') {
    dateText = 'อังคาร';
  } else if (date == 'Wed') {
    dateText = 'พุธ';
  } else if (date == 'Thu') {
    dateText = 'พฤหัสบดี';
  } else if (date == 'Fri') {
    dateText = 'ศุกร์';
  } else if (date == 'Sat') {
    dateText = 'เสาร์';
  } else if (date == 'Sun') {
    dateText = 'อาทิตย์';
  }
  return dateText;
}
