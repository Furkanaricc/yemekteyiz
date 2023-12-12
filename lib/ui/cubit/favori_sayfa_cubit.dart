import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekteyiz/data/entitiy/sepet_yemekler.dart';
import 'package:yemekteyiz/data/repo/sepet_dao_repository.dart';

import '../../data/entitiy/favori_yemek.dart';
import '../../data/repo/favori_dao_repository.dart';



class FavoriSayfaCubit extends Cubit<List<FavoriYemekler>>{

  FavoriSayfaCubit():super(<FavoriYemekler>[]);
  var frepo = FavoriDaoRepository();

  Future<void> favoriYemekleriYukle()async {
    var sepetListe = await frepo.favoriYemekleriYukle("favori");
    emit(sepetListe);
  }
  Future<void> sil(String sepet_yemek_id,String kullanici_adi) async {
    await frepo.kaldir(sepet_yemek_id, "favori");
    favoriYemekleriYukle();
  }


}