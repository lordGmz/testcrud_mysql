class Users {
  String id;
  String email;
  String nom;
  String prenom;
  String imageUrl;
  String password;
  String role;
  String account_token;
  String account_state;

  Users(
      {this.id,
      this.email,
      this.nom,
      this.prenom,
      this.password,
      this.role,
      this.imageUrl,
      this.account_token,
      this.account_state,
      });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] as String,
      email: json['email'] as String,
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      imageUrl: json['imageUrl'] as String,
      account_token: json['account_token'],
      account_state: json['account_state'],
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
      "account_token" : account_token,
      "account_state" : account_state,
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
      "account_token" : account_token,
      "account_state" : account_state,
    };
  }
}
