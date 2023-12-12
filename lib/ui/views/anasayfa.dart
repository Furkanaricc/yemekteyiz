import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekteyiz/data/entitiy/yemekler.dart';
import 'package:yemekteyiz/ui/cubit/anasayfa_cubit.dart';
import 'package:yemekteyiz/ui/views/yemek_detay_sayfa.dart';


class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  
  bool aramaYapiliyorMu=false;

  @override
  void initState(){
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: aramaYapiliyorMu ?
        TextField(
          decoration: InputDecoration(hintText: "Ara"),
          onChanged: (aramaSonucu){
            context.read<AnasayfaCubit>().ara(aramaSonucu);
          },
        ) :
        const Text("Yemekteyiz",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 28),),
        actions: [
          aramaYapiliyorMu ?
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyorMu = false ;
            });
            context.read<AnasayfaCubit>().yemekleriYukle();
          }, icon: Icon(Icons.clear)) :
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyorMu = true;
            });
          }, icon: Icon(Icons.search)),
        ],
      ),
      body: BlocBuilder<AnasayfaCubit,List<Yemekler>>(
        builder: (context,yemeklerListesi){
          if(yemeklerListesi.isNotEmpty){
            return GridView.builder(
                itemCount: yemeklerListesi.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.4 ),
                itemBuilder: (context,index){

                  var yemek = yemeklerListesi[index];
                  return GestureDetector(
                    onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>YemekDetaySayfa(yemek: yemek)));
                    },
                    child:  Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Row( crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(height:10,width: 120),
                                    IconButton(onPressed: (){
                                      context.read<AnasayfaCubit>().favoriyeEkle(
                                          yemek.yemek_adi,
                                          yemek.yemek_resim_adi,
                                          int.parse(yemek.yemek_fiyat),
                                          1,
                                          "favori");
                                    }, icon: Icon(Icons.favorite_border))
                                  ],
                                ),
                                SizedBox(height:120,width: 120,
                                    child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}")
                                ),

                                Column(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("${yemek.yemek_adi}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color:Colors.orange),),
                                    Text("Fiyat : ${yemek.yemek_fiyat} ₺ ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ),
                  );
                },
                );
          }else{
            return const Center(
             child: CircularProgressIndicator(),
            );
          }
        },
      ),

    );

  }
}
