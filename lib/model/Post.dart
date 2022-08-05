class Note {

  late String id;
  late String title;
  late String info;
  late String imageUrl;

  Note();

  Map<String, dynamic> tpMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['title'] = title;
    map['info'] = info;
    map['imageUrl'] = imageUrl;
    return map;
  }
}