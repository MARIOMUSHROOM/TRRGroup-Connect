String checkNull(var value) {
  value = value.toString();
  if (value.isEmpty || value == null || value == "null") {
    return "";
  }
  return value;
}
