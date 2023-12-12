import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekteyiz/data/entitiy/favori_yemek.dart';

import '../cubit/favori_sayfa_cubit.dart';

class FavoriSayfa extends StatefulWidget {
  const FavoriSayfa({Key? key}) : super(key: key);

  @override
  State<FavoriSayfa> createState() => _FavoriSayfaState();
}

class _FavoriSayfaState extends State<FavoriSayfa> {

  @override
  void initState() {
    super.initState();
    context.read<FavoriSayfaCubit>().favoriYemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: const Text("Yemekteyiz",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 28),),

      ),
      body: BlocBuilder<FavoriSayfaCubit,List<FavoriYemekler>>(
        builder: (context,favoriListesi){
          if(favoriListesi.isNotEmpty){

            return ListView.builder(
              itemCount: favoriListesi.length,
              itemBuilder: (context,index){
                var favoriyemek = favoriListesi[index];
                return GestureDetector(
                  onTap: (){
                    
                  },
                  child: Card(
                    child: SizedBox(height: 120,width: 300,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height:90,width: 90,
                                  child: Image.network(
                                      "http://kasimadalan.pe.hu/yemekler/resimler/${favoriyemek.yemek_resim_adi}"),
                                ),

                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Favorim :",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Colors.orange),),
                                Text(" ${favoriyemek.yemek_adi}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color:Colors.orange),),
                                Text("Fiyat : ${favoriyemek.yemek_fiyat} ₺",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                          const Spacer(),
                          IconButton(onPressed: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("${favoriyemek.yemek_adi}", style: TextStyle(color: Colors.white)),
                                  content: const Text(
                                    "Favoriden Silinsin mi ? ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.orangeAccent,
                                  actionsAlignment: MainAxisAlignment.spaceEvenly,
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Vazgeç", style: TextStyle(color: Colors.white)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.read<FavoriSayfaCubit>().sil(favoriyemek.sepet_yemek_id, "favori");
                                        context.read<FavoriSayfaCubit>().favoriYemekleriYukle();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Sil", style: TextStyle(color: Colors.white)),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                              icon:const  Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }else  {
            return const Center(
              child: Text("Hata"),
            );
          }
        },
      ),
    );
  }
}
