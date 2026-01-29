class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phoneNo;
  final String? tax;
  final String? licenseUrl;
  final String? password;
  final String? role;
  final DateTime? renewDate;
  final bool isAccepted;
  String imageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.tax,
    required this.licenseUrl,
    required this.password,
    required this.role,
    this.renewDate,
    required this.isAccepted,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_no': phoneNo,
      'tax': tax,
      'license_url': licenseUrl,
      'password': password,
      'role': role,
      'renew_date': renewDate?.toIso8601String(),
      'is_accepted': isAccepted,
      'image_url': imageUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phoneNo: map['phone_no'],
      tax: map['tax'],
      licenseUrl: map['license_url'],
      password: map['password'],
      role: map['role'],
      renewDate: map['renew_date'] != null
          ? DateTime.parse(map['renew_date'] as String) // ✅ parse string
          : null,
      isAccepted: map['is_accepted'] as bool? ?? false,
      imageUrl: map['image_url'] as String? ?? '',
    );
  }
}

enum UserRole { contractor, supplier }
