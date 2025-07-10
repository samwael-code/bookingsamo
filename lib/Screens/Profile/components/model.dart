class user {
  String? sId;
  String? firstName;
  String? lastName;
  String? address;
  String? email;
  String? mobile;
  String? nid;
  String? password;
  int? age;
  String? photo;
  bool? isactive;
  int? iV;

  user(
      {this.sId,
        this.firstName,
        this.lastName,
        this.address,
        this.email,
        this.mobile,
        this.nid,
        this.password,
        this.age,
        this.photo,
        this.isactive,
        this.iV});

  user.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    address = json['address'];
    email = json['email'];
    mobile = json['mobile'];
    nid = json['Nid'];
    password = json['password'];
    age = json['age'];
    photo = json['photo'];
    isactive = json['isactive'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['address'] = this.address;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['Nid'] = this.nid;
    data['password'] = this.password;
    data['age'] = this.age;
    data['photo'] = this.photo;
    data['isactive'] = this.isactive;
    data['__v'] = this.iV;
    return data;
  }
}
