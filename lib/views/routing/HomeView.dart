// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:raspi_app/transitions/scale_route.dart';
import 'package:raspi_app/views/routing/navigation_helper.dart';

import '../downloadpdf.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String faruk = "Hello";
  List<String> deneme = ["ömer", "Bu veri ana sayfan geldi"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: RaisedButton(
                  child: Text("sliver"),
                  onPressed: () {
                    Navigator.pushNamed(context, navigation_route.Sliver,
                        arguments: ScreenArguments("sfs", faruk, deneme));
                  })),
          Center(
              child: RaisedButton(
                  child: Text("download"),
                  onPressed: () {
                    Navigator.pushNamed(context, navigation_route.Download,
                        arguments: faruk);
                    //Navigator.pushNamedAndRemoveUntil(context, "/sliver", (route) => false);
                  })),
          // Burada Navigator.push kullanılmıştır (yöntem 2)
          Center(
              child: RaisedButton(
                  child: Text("download 2"),
                  onPressed: () {
                    RouteSettings _routesettings =
                        RouteSettings(arguments: faruk);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => downloadpdf(),
                            settings: _routesettings));
                  })),
          //Animasyonlu geçiş kullanımı
          Center(
              child: RaisedButton(
                  child: Text("Animated"),
                  onPressed: () {
                    RouteSettings _routesettings =
                        RouteSettings(arguments: faruk);
                    Navigator.push(
                        context,
                        ScaleRoute(
                            page: downloadpdf(), settings: _routesettings));
                  })),
        ],
      ),
    );
  }
}

//Not eğer gidilen sayfadan geri dönülmek istenmiyorsa arkadaki sayfayı silerek gitmek için.
//Navigator.pushNamedAndRemoveUntil kullanılır.

//-------------------------------------------

// Burası önemli !
// Ekranlar arası veri aktarımı yapabilmek için bir (gönderici ekrana) böyle bir class oluşturulur.
// Gönderilmek istenen argümanlar belirlenir ve class a dışarıden veri girilebilecek this. yapısı oluşturulur.
class ScreenArguments {
  final String title;
  final String message;
  List<String> list;

  ScreenArguments(this.title, this.message, this.list);
}

//Gönderilecek veri ise sayfa değişikliği yapan butonun onpress'inde verilir.
/*
onPressed: () {Navigator.pushNamed(context, "/sliver",arguments: ScreenArguments("sfs", faruk, deneme));
                  }
Not: veri alımı ile ilgili kısım alıcı sayfasında.
*/

/*
  Sayfa isimleri main sayfasında belirlendiği üzere "/sliver", "/downloadpdf" şeklinde kullanılır, daha temiz ve düzenli
    bir kullanım için ayrı bir sayfada bu isimler ("/downloadpdf") string değişkenlere atanarak isimlendirilebilir.
*/
//-------------------------------------------

/*--------- Navigator -----------------
1- Navigator.pushNamed(context, navigation_route.Download,arguments: faruk);

- Senden gideceği sayfanın ismini(String) ister, gittiği sayfaya götürmek istediğin veriyi ister.
- Geldiği sayfaya işlem yapmaz dokunmaz.
------------------------
2- Navigator.pushNamed(context, navigation_route.Download,arguments: faruk);

- Senden gideceği sayfanın ismini ister, gittiği sayfaya götürmek istediğin veriyi ister.
- Kendini geldiği sayfanın üzerine yazar !!

3- Navigator.push
- Senden gideceği sayfanın class ismini ister, gittiği sayfaya götürmek istediğin veriyi ister.
- göndereceği veriyi RouteSettings kullanarak ayarlanıp bir değişkene atanması gerekir
- Animasyonlu geçişler eklenebilir.

onPressed: () {
                    RouteSettings _routesettings = RouteSettings(arguments: faruk);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => downloadpdf(),settings: _routesettings));
*/


//------ kalıcı veri saklama ------------
// https://pub.dev/packages/shared_preferences