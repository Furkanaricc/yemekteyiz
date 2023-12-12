import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekteyiz/data/entitiy/sepet_yemekler.dart';
import 'package:yemekteyiz/ui/cubit/sepet_sayfa_cubit.dart';

import 'anasayfa.dart';

class SepetSayfa extends StatefulWidget {
  const SepetSayfa({Key? key}) : super(key: key);

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  @override
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepetYemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: const Text(
          "Yemekteyiz",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
        ),
      ),
      body: BlocBuilder<SepetSayfaCubit, List<SepetYemekler>>(
        builder: (context, sepetYemeklerListesi) {
          if (sepetYemeklerListesi.isNotEmpty) {
            var sepetTutar = 0;
            for (var sepetYemek in sepetYemeklerListesi) {
              sepetTutar += int.parse(sepetYemek.yemek_fiyat) * int.parse(sepetYemek.yemek_siparis_adet);
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: sepetYemeklerListesi.length,
                    itemBuilder: (context, index) {
                      var sepetYemek = sepetYemeklerListesi[index];
                      var tutar = int.parse(sepetYemek.yemek_fiyat) * int.parse(sepetYemek.yemek_siparis_adet);
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 110,
                                  width: 350,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 90,
                                        width: 90,
                                        child: Image.network(
                                            "http://kasimadalan.pe.hu/yemekler/resimler/${sepetYemek.yemek_resim_adi}"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text("${sepetYemek.yemek_adi}",style: const  TextStyle(color:Colors.orangeAccent,fontSize: 24,fontWeight: FontWeight.bold),),
                                            Text("Toplam Fiyat : $tutar ₺",style: TextStyle(fontSize: 18),),
                                            Text("Adet : ${sepetYemek.yemek_siparis_adet}",style: TextStyle(fontSize: 18),)

                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("${sepetYemek.yemek_adi}", style: TextStyle(color: Colors.white)),
                                                content: const Text(
                                                  "Silinsin mi ? ",
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
                                                      context.read<SepetSayfaCubit>().sil(sepetYemek.sepet_yemek_id, "furkan");

                                                      Navigator.pop(context,MaterialPageRoute(builder: (context)=>Anasayfa()));
                                                    },
                                                    child: const Text("Sil", style: TextStyle(color: Colors.white)),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row( mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Toplam Sepet Tutarı: $sepetTutar ₺",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(height: 45,width: 175,
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<SepetSayfaCubit>().sepetOnayla( "furkan");

                              },
                              child: Text("Sepeti Onayla",style: TextStyle(color: Colors.white,fontSize: 20),),
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color?>(Colors.orangeAccent)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Sepet boş"),
            );
          }
        },
      ),
    );
  }
}
