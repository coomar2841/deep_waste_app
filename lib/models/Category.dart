class Category {
  final String id;
  final String imageURL;
  final int count;
  final String name;

  Category({this.id, this.name, this.imageURL, this.count = 0});

  factory Category.fromMap(Map<String, dynamic> json) => new Category(
      id: json['id'],
      name: json['name'],
      imageURL: json['imageURL'],
      count: json['count']);

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "imageURL": imageURL, "count": count};
  }
}
