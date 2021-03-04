class LoginParam {
  final String email;
  final String password;

  LoginParam(this.email, this.password);

  LoginParam.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        password = json['password'];

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
