class Users {
  late String id;
  late String name;
  late String email;

  Users();

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['name'] = name;

    return map;
  }
}