class Categories {
  String id;
  String category_name;
  String id_fournisseur;

  Categories({
    this.id,
    this.category_name,
    this.id_fournisseur,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'] as String,
      category_name: json['category_name'] as String,
      id_fournisseur: json['id_fournisseur'] as String,
    );
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      "category_name": category_name,
    };
  }
}
