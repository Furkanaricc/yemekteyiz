import 'favori_yemek.dart';

class FavoriYemeklerCevap {
  List<FavoriYemekler> sepet_yemekler;
  int success;

  FavoriYemeklerCevap({required this.sepet_yemekler, required this.success});

  factory FavoriYemeklerCevap.fromJson(Map<String,dynamic>json){
    int success = json["success"] as int;
    var jsonArray = (json ["sepet_yemekler"] ??[])as List;

    List<FavoriYemekler>sepet_yemekler = jsonArray.map((jsonArrayNesnesi) => FavoriYemekler.fromJson(jsonArrayNesnesi)).toList();

    return FavoriYemeklerCevap(sepet_yemekler:sepet_yemekler, success:success);
  }
}