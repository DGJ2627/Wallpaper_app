import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallpaper/Model/Apimodel.dart';
import 'package:wallpaper/Model/wallpaper_model.dart';
class Apihelper{
  Apihelper._();

  static final Apihelper apihelper = Apihelper._();


  Future <List<Apimodel>?> callapi() async{
    http.Response response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    if(response.statusCode == 200){
      List decodedData = jsonDecode(response.body);

      List <Apimodel> apimodel = decodedData.map((e) => Apimodel.fromMap(data: e)).toList();
      return apimodel;
    }
    return null;
  }

  Future<List<wallpapermodel>?>Getwallpaper({required String search}) async {
    String Hostname = "https://pixabay.com";
    String Apikey = "38062796-b92aba1aa2b0efe40a121b13d";
    String Imagetype = "photo";
    String Url = "${Hostname}/api/?key=$Apikey&q=$search&imagetype=$Imagetype";
    http.Response response = await http.get(Uri.parse(Url));

    if(response.statusCode == 200){
      Map decodedData = jsonDecode(response.body);

      List photo = decodedData['hits'];

      List <wallpapermodel> allwallpaper = [];


      photo.forEach((element) {
        allwallpaper.add(wallpapermodel.fromMap(data: element));
      });
      return allwallpaper;
    }
    return null;
  }
}


