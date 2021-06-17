class User {
    User({
        this.userId,
        this.fullName,
        this.userName,
        this.email,
        this.accessToken,
        this.userType,
        this.photo,
    });

    int userId;
    String fullName;
    String userName;
    String email;
    String accessToken;
    String userType;
    String photo;

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        fullName: json["fullName"],
        userName: json["userName"],
        email: json["email"],
        accessToken: json["accessToken"],
        userType: json["userType"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "fullName": fullName,
        "userName": userName,
        "email": email,
        "accessToken": accessToken,
        "userType": userType,
        "photo": photo,
    };
}
