import 'package:equatable/equatable.dart';

class Category extends Equatable {
  String? id;
  String? title;
  String? imagePath;

  Category({this.id, required this.title, required this.imagePath});

  Category.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    imagePath = map['imageUrl'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title!,
      'imageUrl': imagePath!,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, imagePath];
}
