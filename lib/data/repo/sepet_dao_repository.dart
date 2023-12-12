import 'dart:convert';
import 'package:dio/dio.dart';
import '../entitiy/sepet_yemekler.dart';
import '../entitiy/sepet_yemekler_cevap.dart';

class SepetDaoRepository {


  List<SepetYemekler> parseSepetYemeklerCevap(String cevap) {
    try {
      return SepetYemeklerCevap.fromJson(json.decode(cevap)).sepet_yemekler;
    } catch (e) {
      print("Hata.. $e");
      return [];
    }
  }
  Future<List<SepetYemekler>> sepetYemekleriYukle(String kullanici_adi) async {
    var url ="http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi":kullanici_adi};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));

    return parseSepetYemeklerCevap(cevap.data.toString());
  }

  Future<void> sil(String sepet_yemek_id , String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {"sepet_yemek_id":sepet_yemek_id , "kullanici_adi":kullanici_adi};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    print("Yemek sil : ${cevap.data.toString()}");
    sepetYemekleriYukle(kullanici_adi);
  }
  Future<void> sepetOnayla(String kullanici_adi) async {
    // Sepet verilerini yükleyerek sepetteki ürünleri al
    List<SepetYemekler> sepetYemekleri = await sepetYemekleriYukle(kullanici_adi);

    // Her bir ürün için silme işlemini gerçekleştir
    for (SepetYemekler  sepetYemek in sepetYemekleri) {
      await sil(sepetYemek.sepet_yemek_id, kullanici_adi);
    }

    // Tüm ürünler silindiğinde bir işlem yapabilirsiniz
    print("Tüm ürünler silindi");
  }






}