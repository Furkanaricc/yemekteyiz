import 'dart:convert';
import 'package:dio/dio.dart';
import '../entitiy/favori_yemek.dart';
import '../entitiy/favori_yemek_cevap.dart';

class FavoriDaoRepository {

  List<FavoriYemekler> parseFavoriYemeklerCevap(String cevap) {
    try {
      return FavoriYemeklerCevap.fromJson(json.decode(cevap)).sepet_yemekler;
    } catch (e) {
      print("Hata.. $e");
      return [];
    }
  }

  Future<List<FavoriYemekler>> favoriYemekleriYukle(String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi": kullanici_adi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));

    return parseFavoriYemeklerCevap(cevap.data.toString());
  }

  Future<void> kaldir(String sepet_yemek_id, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {
      "sepet_yemek_id": sepet_yemek_id,
      "kullanici_adi": kullanici_adi
    };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Favoriden Kaldır : ${cevap.data.toString()}");
    favoriYemekleriYukle(kullanici_adi);
  }
}