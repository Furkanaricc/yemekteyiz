import 'package:yemekteyiz/data/entitiy/sepet_yemekler.dart';

class SepetYemeklerCevap {
  List<SepetYemekler> sepet_yemekler;
  int success;

  SepetYemeklerCevap({required this.sepet_yemekler, required this.success});

  factory SepetYemeklerCevap.fromJson(Map<String,dynamic>json){
    int success = json["success"] as int;
    var jsonArray = (json ["sepet_yemekler"] ??[])as List;

    List<SepetYemekler>sepet_yemekler = jsonArray.map((jsonArrayNesnesi) => SepetYemekler.fromJson(jsonArrayNesnesi)).toList();

     return SepetYemeklerCevap(sepet_yemekler:sepet_yemekler, success:success);
  }
}