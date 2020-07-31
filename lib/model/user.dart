class UserModel {
  String name;
  String email;
  String weight;
  String height;

  UserModel({
    this.name,
    this.email,
    this.weight,
    this.height,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : email = json['email'] as String,
        name = json['name'] as String,
        weight = json['weight'] as String,
        height = json['height'] as String;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['weight'] = this.weight;
    data['height'] = this.height;
    return data;
  }
}
