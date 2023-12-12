import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekteyiz/data/entitiy/sepet_yemekler.dart';
import 'package:yemekteyiz/data/repo/yemekler_dao_repository.dart';
import 'package:yemekteyiz/ui/cubit/sepet_sayfa_cubit.dart';

class DetaySayfaCubit extends Cubit<void> {

  DetaySayfaCubit():super (0);

  var yrepo = YemeklerDaoRepository();

  Future<void>sepeteEkle(String yemek_adi,String yemek_resim_adi,int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi)async{
    await yrepo.sepeteEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }

}