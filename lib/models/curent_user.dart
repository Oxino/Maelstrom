class CurentUser {
  final String id;
  final String userName;
  final String email;
  CurentUser({this.id = '', required this.userName, required this.email});
  // User.fromData(Map<String, dynamic> data)
  //     : id = data['id'],
  //       userName = data['userName'],
  //       email = data['email'];
  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        'email': email,
      };
}
