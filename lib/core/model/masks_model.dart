class MasksModel {
  String? title;
  String? image;
  String? desc;

  MasksModel({
    this.title,
    this.image,
    this.desc,
  });

  MasksModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['image'] = this.image;
    return data;
  }
}
