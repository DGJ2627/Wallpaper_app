class wallpapermodel{
  int dowanlods;
  String largeimages;

  wallpapermodel({
    required this.dowanlods,
    required this.largeimages,
});

  factory wallpapermodel.fromMap({required Map data}){
    return wallpapermodel(dowanlods: data['downloads'], largeimages: data['largeImageURL']);
  }
}