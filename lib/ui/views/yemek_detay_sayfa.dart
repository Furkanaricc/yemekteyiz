import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemekteyiz/data/entitiy/yemekler.dart';
import 'package:yemekteyiz/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:yemekteyiz/ui/views/anasayfa.dart';
import 'package:yemekteyiz/ui/views/sepet_sayfa.dart';
import '../cubit/detay_sayfa_cubit.dart';

class YemekDetaySayfa extends StatefulWidget {

  Yemekler yemek;

  YemekDetaySayfa({required this.yemek });


  @override
  State<YemekDetaySayfa> createState() => _YemekDetaySayfaState();
}

class _YemekDetaySayfaState extends State<YemekDetaySayfa> {
  var tfYemekAdi = TextEditingController();
  var tfYemekResimAdi = TextEditingController();
  var tfYemekFiyat = TextEditingController();



  @override
  void initState(){
    super.initState();
    var yemek = widget.yemek;
    tfYemekAdi.text = yemek.yemek_adi;
    tfYemekResimAdi.text = yemek.yemek_resim_adi;
    tfYemekFiyat.text = yemek.yemek_fiyat;

  }
  int adet =1;
  void arttir() {
    setState(() {
      adet++;
    });
  }
  void azalt() {
    setState(() {
      if (adet > 0) {
        adet--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: const Text("Yemekteyiz",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 28),),

      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              child: Column(
                children: [
                  SizedBox( width:300,height: 300,
                      child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${tfYemekResimAdi.text}")),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${tfYemekAdi.text}",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.orangeAccent),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Fiyat : ${tfYemekFiyat.text} ₺",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
            Row( crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10,width: 120,),
                IconButton(onPressed: (){arttir();}, icon: const Icon(Icons.add_circle_outline),style:ButtonStyle(iconSize:MaterialStateProperty.all<double>(50)),),
                Text("$adet",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                IconButton(onPressed: (){azalt();}, icon: const Icon(Icons.remove_circle_outline),style:ButtonStyle(iconSize:MaterialStateProperty.all<double>(50)),)
              ],
            ),
            SizedBox(width: 200, height: 50,
              child: ElevatedButton(onPressed: (){

              context.read<DetaySayfaCubit>().sepeteEkle(
                  widget.yemek.yemek_adi,
                  widget.yemek.yemek_resim_adi,
                  int.parse(widget.yemek.yemek_fiyat),
                  adet,
                  "furkan");
              context.read<SepetSayfaCubit>().sepetYemekleriYukle();
              Navigator.pop(context,MaterialPageRoute(builder: (context)=>SepetSayfa()));
              //Navigator.of(context).pop();
              }, child: const Text("Sepete ekle",style: TextStyle(color: Colors.white,fontSize: 22),),
                  style: ButtonStyle(backgroundColor:  MaterialStateProperty.all<Color?>(Colors.orangeAccent))),
            ),
          ],
        ),
      ),
    );
  }
}
