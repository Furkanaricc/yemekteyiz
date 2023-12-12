import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekteyiz/data/repo/yemekler_dao_repository.dart';
import '../../data/entitiy/yemekler.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>>{
  AnasayfaCubit():super(<Yemekler>[]);
  var yrepo = YemeklerDaoRepository();

  Future<void>yemekleriYukle()async{
    var liste = await yrepo.yemekleriYukle();
    emit(liste);
  }

  Future<void> ara (String aramaKelimesi) async {
    var liste = await yrepo.ara(aramaKelimesi);
    emit(liste);
  }

  Future<void>favoriyeEkle(String yemek_adi,String yemek_resim_adi,int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi)async{
    await yrepo.sepeteEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }

}