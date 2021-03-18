import 'dart:convert';

class LoginResponse {
  int apiStatusCode;
  String message;

  int countryCode, mobile, personaAddToCartCounter;
  String userId, token, userName, email, address, profilePicture;

  LoginResponse(
      {this.apiStatusCode,
      this.message,
      this.userId,
      this.token,
      this.userName,
      this.email,
      this.address,
      this.countryCode,
      this.mobile,
      this.profilePicture,
      this.personaAddToCartCounter});

  LoginResponse.fromJson(Map<String, dynamic> json)
      : apiStatusCode = json['apiStatusCode'],
        message = json['message'],
        userId = json['userId'],
        token = json['token'],
        userName = json['userName'],
        email = json['email'],
        address = json['address'],
        countryCode = json['countryCode'],
        mobile = json['mobile'],
        profilePicture = json['profilePicture'],
        personaAddToCartCounter = json['personaAddToCartCounter'];

  Map<String, dynamic> toJson() => {
        'apiStatusCode': apiStatusCode,
        'message': message,
        'userId': userId,
        'token': token,
        'userName': userName,
        'email': email,
        'address': address,
        'countryCode': 91,
        'mobile': mobile,
        'profilePicture': profilePicture,
        'personaAddToCartCounter': 0
      };
}

void main() {
  LoginResponse loginResponse = LoginResponse(
      apiStatusCode: 200,
      message: 'Login successful',
      userId: '001',
      token: 'token',
      userName: 'kamlesh',
      email: 'kamal.lakhani56@gmail.com',
      mobile: 9586331823,
      profilePicture: 'url');

  print(json.encode(loginResponse));
}
