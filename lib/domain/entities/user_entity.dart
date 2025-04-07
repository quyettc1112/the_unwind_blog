class UserEntity {
  final String id;
  final String name;
  final String email;
  final String img;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.img,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      img: json['img'],
    );
  }
}