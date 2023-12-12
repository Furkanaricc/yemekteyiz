import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekteyiz/data/entitiy/sepet_yemekler.dart';
import 'package:yemekteyiz/data/repo/sepet_dao_repository.dart';



class SepetSayfaCubit extends Cubit<List<SepetYemekler>>{

  SepetSayfaCubit():super(<SepetYemekler>[]);
  var srepo = SepetDaoRepository();

  Future<void> sepetYemekleriYukle()async {
    var sepetListe = await srepo.sepetYemekleriYukle("furkan");
    emit(sepetListe);
  }
  Future<void> sil(String sepet_yemek_id,String kullanici_adi) async {
    await srepo.sil(sepet_yemek_id, "furkan");
    sepetYemekleriYukle();
  }
  Future<void> sepetOnayla(String kullanici_adi) async {
    await srepo.sepetOnayla("furkan");
    sepetYemekleriYukle();
  }

}