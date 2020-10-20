class Users {
  String id;
  String email;
  String nom;
  String prenom;
  String imageUrl;
  String password;
  String role;

  Users(
      {this.id,
      this.email,
      this.nom,
      this.prenom,
      this.password,
      this.role,
      this.imageUrl});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] as String,
      email: json['email'] as String,
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      "email": email,
      "nom": nom,
      "prenom": prenom,
      "password": password,
      "role": role,
      "imageUrl": imageUrl,
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      "id" : id,
      "email": email,
      "nom": nom,
      "prenom": prenom,
      "password": password,
      "role": role,
      "imageUrl": imageUrl,
    };
  }
}
