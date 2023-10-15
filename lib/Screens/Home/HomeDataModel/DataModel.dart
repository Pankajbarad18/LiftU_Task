// ignore_for_file: file_names

class ProductModel {
  int id;
  String name;
  String description;
  double price;
  String imageURL;
  int rating;
  ProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageURL,
      required this.rating});
}
