import 'package:flutter/cupertino.dart';

import 'package:wallpaper/Model/search_model.dart';

class search_provider extends ChangeNotifier{
  search_model search = search_model(Image_search: "");

void Image_Search(String n){
notifyListeners();
}
}