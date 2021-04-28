class User {
  int id;
  String userName;
  int userPhoneCountryCode;
  int userPhone;
  String userEmail;
  String userAddress;
  String userDob;
  String password;
  int userIsActive;
  String createDate;
  String createdBy;
  String lastModifiedDate;
  String lastModifiedBy;

  User(
      {this.userName,
      this.id,
      this.userPhoneCountryCode,
      this.userPhone,
      this.userEmail,
      this.userAddress,
      this.userDob,
      this.password,
      this.userIsActive,
      this.createDate,
      this.lastModifiedDate,
      this.lastModifiedBy});

  User.fromJson(Map<String, dynamic> json)
      : userName = json['name'],
        id = json['id'],
        userPhoneCountryCode = json['country_code'],
        userPhone = json['phone'],
        // password = json['password'],
        userEmail = json['email'],
        userAddress = json['address'],
        userDob = json['dob'],
        userIsActive = json['is_active'],
        createDate = json['create_date'],
        createdBy = json['create_by'],
        lastModifiedDate = json['last_modified_date'],
        lastModifiedBy = json['last_modified_by'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': userName,
        'country_code': userPhoneCountryCode,
        'phone': userPhone,
        'email': userEmail,
        'address': userAddress,
        'dob': userDob,
        'password': password,
        // 'is_active': userIsActive,
        // 'create_date': createDate,
        // 'create_by': createdBy,
        // 'last_modified_date': lastModifiedDate,
        // 'last_modified_by': lastModifiedBy,
      };
}
