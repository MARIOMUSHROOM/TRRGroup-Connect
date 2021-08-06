int sugarCaneTypeChange(String value) {
  switch (value) {
    case "อ้อยปลูกใหม่":
      return 1;
      break;
    case "อ้อยตอ":
      return 2;
      break;
    case "แปลงผสม":
      return 3;
      break;
    default:
      return 1;
  }
}

int sugarCaneStepChange(String value) {
  switch (value) {
    case "ไถและเตรียมดิน":
      return 1;
      break;
    case "ปลูกอ้อย":
      return 2;
      break;
    case "ให้น้ำ":
      return 3;
      break;
    case "ฉีดพ่นน้ำหมักปุ๋ยยูเรีย":
      return 4;
      break;
    case "ฉีดพ่นสารกำจัดศัตรูพืช":
      return 5;
      break;
    case "ใส่ปุ๋ย":
      return 6;
      break;
    case "ตัดอ้อย":
      return 7;
      break;
    case "ขนส่งอ้อย":
      return 8;
      break;
    case "เสร็จสิ้นกิจกรรมทั้งหมด":
      return 9;
      break;
    default:
      return 1;
  }
}

int indexSelectedInList(List list, String value) {
  return list.indexWhere((element) => element == value);
}

String indexSelectedInListString(List list, int value) {
  if (value == null) {
    return null;
  }
  return list[value];
}

String stationSelectedtoString(List list) {
  List station = new List();
  list.forEach((item) {
    station.add(item.plot_id);
  });
  return station.join("_");
}

int selectInputActivityType(bool newPlant, bool oldPlant) {
  if (newPlant && oldPlant) {
    return 3;
  } else if (!newPlant && oldPlant) {
    return 2;
  } else if (newPlant && !oldPlant) {
    return 1;
  } else {
    return 0;
  }
}

String checkNull(var value) {
  value = value.toString();
  if (value.isEmpty || value == null || value == "null") {
    return "";
  }
  return value;
}
