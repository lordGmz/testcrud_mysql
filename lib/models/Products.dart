class Products {
  String id;
  String product_name;
  String id_category;
  String id_fournisseur;

  Products({
    this.id,
    this.product_name,
    this.id_category,
    this.id_fournisseur,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'] as String,
      product_name: json['product_name'] as String,
      id_category: json['id_category'] as String,
      id_fournisseur : json['id_fournisseur'] as String
    );
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      "product_name": product_name,
      "id_category": id_category,
    };
  }
}
