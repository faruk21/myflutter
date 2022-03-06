import 'package:flutter/material.dart';

import 'routing/HomeView.dart';

//Burası Scaffold içerisinde appbar.. gibi özellikleri daha ayrıntılı kullanabilmek için oluşturulmuş
//CustomScrollView içerisindeki slivers örneğinin yapıldığı yer.

class sliver extends StatefulWidget {
  sliver({Key? key}) : super(key: key);

  @override
  State<sliver> createState() => _sliverState();
}

class _sliverState extends State<sliver> {
  @override
  Widget build(BuildContext context) {
//-------------------------------
/*
  Ekranlar arası veri aktarımında alıcı kısımburada başlar
  final ile tanımlanan değişkene gelen sayfadaki class bağlanır (sayfa yukarıda import edildi).
  Daha sonra (değişkenismi.) denilerek gelen verilere ulaşılır.
*/
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
        //appBar: AppBar(title: Text(args.message)),
        body: CustomScrollView(slivers: <Widget>[
//---------------------------------
      SliverAppBar(
        automaticallyImplyLeading: true, //AppBar daki back arrow.
        leading: BackButton(color: Colors.black45), //ek özellikler.
        expandedHeight: 200,
        floating: true, //kaydırma efekti.
        pinned: true, //app barın kaydırıma sırasında kaybolması seçeneği.
        flexibleSpace: FlexibleSpaceBar(
          // **** Verilere ulaşılma örneği ****
          title: Text(args.list.first),
          centerTitle: true, //yazı ortalama.
          background: Image.network(
            "https://picsum.photos/200/300",
            fit: BoxFit.fill,
          ),
        ),
      ),
//---------------------------------

//---------------------------------
      SliverToBoxAdapter(
          child: Card(
        color: Color.fromARGB(255, 255, 107, 97),
        child: Center(
          // Seçilebilir text (kopyala-yapıştır) ve tıklama özelliği var :)
          child: SelectableText(
            args.list.elementAt(1),
            onTap: () => {print("sdfsf")},
          ),
        ),
      )), //sliver içerisine harici komponentler koymak için
//---------------------------------

//---------------------------------
//sliver ın grid yadıda olanı

      SliverGrid.extent(
        maxCrossAxisExtent: 118,
        children: [
          Card(
            color: Colors.red,
            child: Text("faruk"),
          ),
          Card(
            color: Color.fromARGB(255, 29, 155, 96),
            child: Text("1"),
          ),
          Card(
            color: Color.fromARGB(255, 122, 29, 165),
            child: Text("2"),
          ),
          Card(
            color: Color.fromARGB(255, 219, 216, 32),
            child: Text("ömer"),
          ),
        ],
      ),
//---------------------------------

//---------------------------------
      //Appbar ın altında bir liste yapısı.
      SliverList(
        delegate: SliverChildBuilderDelegate((index, context) {
          return Container(
            color: Color.fromARGB(255, 179, 40, 93),
            height: 80,
            child: Card(child: Text("faruk")),
          );
        }, childCount: 15),
      ),
//---------------------------------
      //SliverToBoxAdapter(child: SizedBox(height: 20)), //Listenin sonuna box attık (istenilen şey konulabilir)
    ]));
  }
}
