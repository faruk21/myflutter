import 'dart:io';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class downloadpdf extends StatefulWidget {
  const downloadpdf({Key? key}) : super(key: key);

  @override
  _downloadpdfState createState() => _downloadpdfState();
}

class _downloadpdfState extends State<downloadpdf> {
  final urlpdf = Uri.parse(
      'http://www.africau.edu/images/default/sample.pdf'); //url değişkenine indirilecek dosya urlsi kaydedildi.
  final urlvideo = Uri.parse(
      'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4');
  String _filepdfPath =
      ""; //dosyanın kaydedileceği yolu tutmak için bir değişken.
  String _filevideoPath = "";

  //Cihaza göre uygulamanın içindeki dosya kayıt yolunu alan ve değişkene koyan get metodu.
  //(asenkron olarak yazıldı çünkü cihazın yanıt vermesi beklemek programı duraklatır)
  Future<String> get _localDevicePath async {
    final _devicePath = await getApplicationDocumentsDirectory();
    return _devicePath.path;
  }

  //Yeni klasör oluşturmak, alınan cihaz konumuna istenilen isme ve türe göre yeni bir klasör açıp klasör yolunu return eden bir fonksiyon.
  //dosya adı ve türü içeri alındı
  Future<File> _localFile({String? path, String? type}) async {
    String _path =
        await _localDevicePath; //_localDevicePath beklendi ve gelen değişken _path e atandı

    // cihazdan gelen dosya yolu/ verilen dosya yolu na bir klasör açıldı ve _newPath değişkenine atandı
    var _newPath = await Directory("$_path/$path").create();
    //son olarak oluşturulan klasörün yoluna faruk.type dosyası oluşturuluyor (faruk.pdf) (boş pdf dosyası)
    return File("${_newPath.path}/hwa.$type");
  }

  Future _getpdf() async {
    try {
      final response = await http.get(
          urlpdf); //url indirilme komutu gönderildi ve gelen dosya response değişkenine atandı
      if (response.statusCode == 200) {
        //http 200 kodu dönerse bu olumlu bir cevaptır işlem başarılı
        final _file = await _localFile(
            path: "veli",
            type:
                "pdf"); //_localFile fonksiyonu çağırıldı parametreler verildi ve dönen cevap _file a atandı
        final _saveFile = await _file.writeAsBytes(response
            .bodyBytes); // indirilen dosya _file e gelen dosya yolundaki dosyaya yazıldı ve değişkene atandı.
        Logger()
            .i("File write complete. File Path ${_saveFile.path}"); //loglandı
        setState(() {
          _filepdfPath = _saveFile
              .path; //yazılan ve oluşan dosya yolu _filePath olarak dışarıya set edildi.
        });
      }
    } catch (e) {
      Logger().e("olmadiiiiiiiii"); //else durumunda log daki hata mesajı.
      setState(() {
        _filepdfPath =
            "indirilemedi"; //yazılan ve oluşan dosya yolu _filePath olarak dışarıya set edildi.
      });
    }
  }

  Future _getvideo() async {
    try {
      final response = await http.get(
          urlvideo); //url indirilme komutu gönderildi ve gelen dosya response değişkenine atandı
      if (response.statusCode == 200) {
        //http 200 kodu dönerse bu olumlu bir cevaptır işlem başarılı
        final _file = await _localFile(
            path: "faruk",
            type:
                "mp4"); //_localFile fonksiyonu çağırıldı parametreler verildi ve dönen cevap _file a atandı
        final _saveFile = await _file.writeAsBytes(response
            .bodyBytes); // indirilen dosya _file e gelen dosya yolundaki dosyaya yazıldı ve değişkene atandı.
        Logger()
            .i("File write complete. File Path ${_saveFile.path}"); //loglandı
        setState(() {
          _filevideoPath = _saveFile
              .path; //yazılan ve oluşan dosya yolu _filePath olarak dışarıya set edildi.
        });
      }
    } catch (e) {
      Logger().e("olmadiiiiiiiii"); //else durumunda log daki hata mesajı.
      setState(() {
        _filevideoPath =
            "indirilemedi"; //yazılan ve oluşan dosya yolu _filePath olarak dışarıya set edildi.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  _getpdf();
                },
                icon: Icon(Icons.download)),
            IconButton(
                onPressed: () {
                  OpenFile.open(_filepdfPath);
                },
                icon: Icon(Icons.file_open)),
            IconButton(
                onPressed: () {
                  _getvideo();
                },
                icon: Icon(Icons.download)),
            IconButton(
                onPressed: () {
                  OpenFile.open(_filevideoPath);
                },
                icon: Icon(Icons.video_file)),
            Text(_filepdfPath),
          ],
        ),
      ),
    );
  }
}
