import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String title;
  final String price;
  final String description;
  final List<String> photos;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['title'] != null),
        assert(map['price'] != null),
        assert(map['desc'] != null),
        assert(map['pics'] != null),
        title = map['title'],
        price = map['price'],
        description = map['desc'],
        photos = map['pics'].cast<String>();

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$title:$price:$description>";
}

class PostDetail {
  String title;
  String price;
  String description;
  List<String> pathList;

  PostDetail(String title, String price, String description, List<String> pathList) {
    this.title = title;
    this.price = price;
    this.description = description;
    this.pathList = pathList;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["title"] = this.title;
    map["price"] = this.price;
    map["desc"] = this.description;
    for(String s in pathList) {
      print("pathList item: ${s}");
    }

    map["pics"] = this.pathList;
    return map;
  }
}


