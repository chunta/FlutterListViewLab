class Post {
  String? id;
  String? title;
  String? imageurl;
  String? description;
  bool expanded = false;

  Post({this.id, this.title, this.imageurl, this.description});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageurl = json['imgurl'];
    description = json['des'];
    expanded = false;
  }
}
