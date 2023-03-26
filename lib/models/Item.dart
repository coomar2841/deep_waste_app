class Item {
  final String id;
  final String imageURL;
  final String name;
  int count;
  Item({this.id, this.name, this.imageURL, this.count});

  factory Item.fromMap(Map<String, dynamic> json) => new Item(
      id: json['id'],
      name: json['name'],
      imageURL: json['imageURL'],
      count: json['count']);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "imageURL": imageURL,
      "count": count
    };
  }
}
