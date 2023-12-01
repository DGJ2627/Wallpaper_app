class Apimodel{
  final int userId;
  final int id;
  final String title;
  final String body;

  Apimodel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
});

  factory Apimodel.fromMap({required Map data}){
    return Apimodel(userId: data['userId'], id: data['id'], title: data['title'], body: data['body']);
  }
}