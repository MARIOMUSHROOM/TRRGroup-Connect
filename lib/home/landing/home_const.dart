import 'package:flutter/material.dart';

const kBeginColor = Color(0xff011f43);
const kEndColor = Color(0xff01397e);

const kGoldColor = Color(0xff827553);
const kBlueColor = Color(0xff024291);
const kSolidBlueColor = Color(0xff011e41);

const kIconBgColor = Color(0xffededf5);
const kBlueGreyColor = Color(0xff556880);

// Code for Weather from openweathermap.org
// Code 2xx : Thunderstrom
const kWeatherCode_200 = 200; // thunderstorm with light rain
const kWeatherCode_201 = 201; // thunderstorm with rain
const kWeatherCode_202 = 202; // thunderstorm with heavy rain
const kWeatherCode_210 = 210; // light thunderstorm
const kWeatherCode_211 = 211; // thunderstorm
const kWeatherCode_212 = 212; // heavy thunderstorm
const kWeatherCode_221 = 221; // ragged thunderstorm
const kWeatherCode_230 = 230; // thunderstorm with light drizzle
const kWeatherCode_231 = 231; // thunderstorm with drizzle
const kWeatherCode_232 = 232; // thunderstorm with heavy drizzle

// Code 3xx : Drizzle ฝนปรอย
const kWeatherCode_300 = 300; // light intensity drizzle
const kWeatherCode_301 = 301; // drizzle
const kWeatherCode_302 = 302; // heavy intensity drizzle
const kWeatherCode_310 = 310; // light intensity drizzle rain
const kWeatherCode_311 = 311; // drizzle rain
const kWeatherCode_312 = 312; // heavy intensity drizzle rain
const kWeatherCode_313 = 313; // shower rain and drizzle
const kWeatherCode_314 = 314; // heavy shower rain and drizzle
const kWeatherCode_321 = 321; // shower drizzle

// Code 5xx : Rain
const kWeatherCode_500 = 500; // light rain
const kWeatherCode_501 = 501; // moderate rain
const kWeatherCode_502 = 502; // heavy intensity rain
const kWeatherCode_503 = 503; // very heavy rain
const kWeatherCode_504 = 504; // extreme rain
const kWeatherCode_511 = 511; // freezing rain
const kWeatherCode_520 = 520; // light intensity shower rain
const kWeatherCode_521 = 521; // shower rain
const kWeatherCode_522 = 522; // heavy intensity shower rain
const kWeatherCode_531 = 531; // ragged shower rain

// Code 6xx : Snow
const kWeatherCode_600 = 600; // light snow
const kWeatherCode_601 = 601; // Snow
const kWeatherCode_602 = 602; // Heavy snow
const kWeatherCode_611 = 611; // Sleet
const kWeatherCode_612 = 612; // Light shower sleet
const kWeatherCode_613 = 613; // Shower sleet
const kWeatherCode_615 = 615; // Light rain and snow
const kWeatherCode_616 = 616; // Rain and snow
const kWeatherCode_620 = 620; // Light shower snow
const kWeatherCode_621 = 621; // Shower snow
const kWeatherCode_622 = 622; // Heavy shower snow

// Code 7xx : Atmosphere
const kWeatherCode_701 = 701; // mist
const kWeatherCode_711 = 711; // Smoke
const kWeatherCode_721 = 721; // Haze
const kWeatherCode_731 = 731; // sand/ dust whirls
const kWeatherCode_741 = 741; // fog
const kWeatherCode_751 = 751; // sand
const kWeatherCode_761 = 761; // dust
const kWeatherCode_762 = 762; // volcanic ash
const kWeatherCode_771 = 771; // squalls
const kWeatherCode_781 = 781; // tornado

// Code 800 - Clear
const kWeatherCode_800 = 800; // clear sky

// Code 80x - Cloud
const kWeatherCode_801 = 801; // few coluds: 11-25%
const kWeatherCode_802 = 802; //scattered clouds: 25-50%
const kWeatherCode_803 = 803; //broken clouds: 51-84%
const kWeatherCode_804 = 804; //overcast clouds: 85-100%

// Thai label weather
// Code 2xx Label : Thunderstrom
const kWeatherCode_200_Label = 'พายุฝนฟ้าคะนองและฝนตกเล็กน้อย'; // thunderstorm with light rain
const kWeatherCode_201_Label = 'พายุฝนฟ้าคะนอง'; // thunderstorm with rain
const kWeatherCode_202_Label = 'พายุฝนฟ้าคะนองและฝนตกหนัก'; // thunderstorm with heavy rain
const kWeatherCode_210_Label = 'พายุฝนฟ้าคะนองเบาบาง'; // light thunderstorm
const kWeatherCode_211_Label = 'พายุฝนฟ้าคะนอง'; // thunderstorm
const kWeatherCode_212_Label = 'พายุฝนฟ้าคะนองรุนแรง'; // heavy thunderstorm
const kWeatherCode_221_Label = 'พายุฝนฟ้าคะนอง'; // ragged thunderstorm
const kWeatherCode_230_Label = 'ฝนฟ้าคะนองและละอองฝนเล็กน้อย'; // thunderstorm with light drizzle
const kWeatherCode_231_Label = 'ฝนฟ้าคะนองและมีฝนตกเล็กน้อย'; // thunderstorm with drizzle
const kWeatherCode_232_Label = 'ฝนฟ้าคะนองและมีฝนตกเล็กน้อย'; // thunderstorm with heavy drizzle

// Code 3xx Label : Drizzle ฝนปรอย
const kWeatherCode_300_Label = 'ฝนตกเล็กน้อย'; // light intensity drizzle
const kWeatherCode_301_Label = 'ฝนตกเล็กน้อย'; // drizzle
const kWeatherCode_302_Label = 'ฝนตกหนักมาก'; // heavy intensity drizzle
const kWeatherCode_310_Label = 'ฝนโปรยปราย'; // light intensity drizzle rain
const kWeatherCode_311_Label = 'ฝนตกเล็กน้อย'; // drizzle rain
const kWeatherCode_312_Label = 'ฝนฟ้าคะนองรุนแรง'; // heavy intensity drizzle rain
const kWeatherCode_313_Label = 'ฝนตกเล็กน้อย'; // shower rain and drizzle
const kWeatherCode_314_Label = 'ฝนตกหนักและฝนตกเล็กน้อย'; // heavy shower rain and drizzle
const kWeatherCode_321_Label = 'ฝนตกเล็กน้อย'; // shower drizzle

// Code 5xx Label : Rain
const kWeatherCode_500_Label = 'ฝนตกเล็กน้อย'; // light rain
const kWeatherCode_501_Label = 'ฝนตกปานกลาง'; // moderate rain
const kWeatherCode_502_Label = 'ฝนตกหนัก'; // heavy intensity rain
const kWeatherCode_503_Label = 'ฝนตกหนักมาก'; // very heavy rain
const kWeatherCode_504_Label = 'ฝนตกหนักมาก'; // extreme rain
const kWeatherCode_511_Label = 'ฝนตกและมีลูกเห็บ'; // freezing rain
const kWeatherCode_520_Label = 'ฝนโปรยปรายบางๆ'; // light intensity shower rain
const kWeatherCode_521_Label = 'ฝนโปรยปราย'; // shower rain
const kWeatherCode_522_Label = 'ฝนตกหนักมาก'; // heavy intensity shower rain
const kWeatherCode_531_Label = 'ฝนโปรยปราย'; // ragged shower rain

// Code 6xx Label : Snow
const kWeatherCode_600_Label = 'หิมะตกบางๆ'; // light snow
const kWeatherCode_601_Label = 'หิมะตก'; // Snow
const kWeatherCode_602_Label = 'หิมะตกหนัก'; // Heavy snow
const kWeatherCode_611_Label = 'ลูกเห็บตก'; // Sleet
const kWeatherCode_612_Label = 'มีลูกเห็บตก'; // Light shower sleet
const kWeatherCode_613_Label = 'ฝนลูกเห็บ'; // Shower sleet
const kWeatherCode_615_Label = 'ฝนโปรยปรายและหิมะตก'; // Light rain and snow
const kWeatherCode_616_Label = 'มีฝนและหิมะ'; // Rain and snow
const kWeatherCode_620_Label = 'หิมะโปรยปราย'; // Light shower snow
const kWeatherCode_621_Label = 'หิมะโปรยปราย'; // Shower snow
const kWeatherCode_622_Label = 'หิมะตกหนัก'; // Heavy shower snow

// Code 7xx Label : Atmosphere
const kWeatherCode_701_Label = 'มีหมอก'; // mist
const kWeatherCode_711_Label = 'มีหมอกควัน'; // Smoke
const kWeatherCode_721_Label = 'มีหมอก'; // Haze
const kWeatherCode_731_Label = 'มีฝุ่นควันหรือฝุ่นทราย'; // sand/ dust whirls
const kWeatherCode_741_Label = 'มีหมอก'; // fog
const kWeatherCode_751_Label = 'มีฝุ่นทราย'; // sand
const kWeatherCode_761_Label = 'มีฝุ่นควัน'; // dust
const kWeatherCode_762_Label = 'มีเถ้าภูเขาไฟ'; // volcanic ash
const kWeatherCode_771_Label = 'มีพายุ'; // squalls
const kWeatherCode_781_Label = 'มีพายุทอร์นาโด'; // tornado

// Code 800 Label - Clear
const kWeatherCode_800_Label = 'ท้องฟ้าแจ่มใส'; // clear sky

// Code 80x Label - Cloud
const kWeatherCode_801_Label = 'มีเมฆน้อย'; // few coluds: 11-25%
const kWeatherCode_802_Label = 'มีเมฆเป็นบางส่วน'; //scattered clouds: 25-50%
const kWeatherCode_803_Label = 'มีเมฆเป็นส่วนมาก'; //broken clouds: 51-84%
const kWeatherCode_804_Label = 'ท้องฟ้าครึ้ม'; //overcast clouds: 85-100%

const kWeatherCodeLabelMap = {
  kWeatherCode_200: kWeatherCode_200_Label,
  kWeatherCode_201: kWeatherCode_201_Label,
  kWeatherCode_202: kWeatherCode_202_Label,
  kWeatherCode_210: kWeatherCode_210_Label,
  kWeatherCode_211: kWeatherCode_211_Label,
  kWeatherCode_212: kWeatherCode_212_Label,
  kWeatherCode_221: kWeatherCode_221_Label,
  kWeatherCode_230: kWeatherCode_230_Label,
  kWeatherCode_231: kWeatherCode_231_Label,
  kWeatherCode_232: kWeatherCode_232_Label,
  kWeatherCode_300: kWeatherCode_300_Label,
  kWeatherCode_301: kWeatherCode_301_Label,
  kWeatherCode_302: kWeatherCode_302_Label,
  kWeatherCode_310: kWeatherCode_310_Label,
  kWeatherCode_311: kWeatherCode_311_Label,
  kWeatherCode_312: kWeatherCode_312_Label,
  kWeatherCode_313: kWeatherCode_313_Label,
  kWeatherCode_314: kWeatherCode_314_Label,
  kWeatherCode_321: kWeatherCode_321_Label,
  kWeatherCode_500: kWeatherCode_500_Label,
  kWeatherCode_501: kWeatherCode_501_Label,
  kWeatherCode_502: kWeatherCode_502_Label,
  kWeatherCode_503: kWeatherCode_503_Label,
  kWeatherCode_504: kWeatherCode_504_Label,
  kWeatherCode_511: kWeatherCode_511_Label,
  kWeatherCode_520: kWeatherCode_520_Label,
  kWeatherCode_521: kWeatherCode_521_Label,
  kWeatherCode_522: kWeatherCode_522_Label,
  kWeatherCode_531: kWeatherCode_531_Label,
  kWeatherCode_600: kWeatherCode_600_Label,
  kWeatherCode_601: kWeatherCode_601_Label,
  kWeatherCode_602: kWeatherCode_602_Label,
  kWeatherCode_611: kWeatherCode_611_Label,
  kWeatherCode_612: kWeatherCode_612_Label,
  kWeatherCode_613: kWeatherCode_613_Label,
  kWeatherCode_615: kWeatherCode_615_Label,
  kWeatherCode_616: kWeatherCode_616_Label,
  kWeatherCode_620: kWeatherCode_620_Label,
  kWeatherCode_621: kWeatherCode_621_Label,
  kWeatherCode_622: kWeatherCode_622_Label,
  kWeatherCode_701: kWeatherCode_701_Label,
  kWeatherCode_711: kWeatherCode_711_Label,
  kWeatherCode_721: kWeatherCode_721_Label,
  kWeatherCode_731: kWeatherCode_731_Label,
  kWeatherCode_741: kWeatherCode_741_Label,
  kWeatherCode_751: kWeatherCode_751_Label,
  kWeatherCode_761: kWeatherCode_761_Label,
  kWeatherCode_762: kWeatherCode_762_Label,
  kWeatherCode_771: kWeatherCode_771_Label,
  kWeatherCode_781: kWeatherCode_781_Label,
  kWeatherCode_800: kWeatherCode_800_Label,
  kWeatherCode_801: kWeatherCode_801_Label,
  kWeatherCode_802: kWeatherCode_802_Label,
  kWeatherCode_803: kWeatherCode_803_Label,
  kWeatherCode_804: kWeatherCode_804_Label,
};
