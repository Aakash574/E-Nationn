class UserModel {
  int? id;
  String? fullName;
  String? email;
  String? password;
  String? fatherName;
  String? college;
  String? branch;
  String? yearOfPassout;
  String? dateOfBirth;
  String? placeOfBirth;
  String? state;
  String? uid;
  String? internshipStatus;
  String? eventStatus;
  String? hackathonStatus;
  String? signupkey;
  String? applyStatus;
  String? planStatus;
  String? gender;
  String? remark;
  String? contact;
  String? createdAt;

  UserModel(
      {this.id,
      this.fullName,
      this.email,
      this.password,
      this.fatherName,
      this.college,
      this.branch,
      this.yearOfPassout,
      this.dateOfBirth,
      this.placeOfBirth,
      this.state,
      this.uid,
      this.internshipStatus,
      this.eventStatus,
      this.hackathonStatus,
      this.signupkey,
      this.applyStatus,
      this.planStatus,
      this.gender,
      this.remark,
      this.contact,
      this.createdAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    password = json['password'];
    fatherName = json['father_name'];
    college = json['college'];
    branch = json['branch'];
    yearOfPassout = json['year_of_passout'];
    dateOfBirth = json['date_of_birth'];
    placeOfBirth = json['place_of_birth'];
    state = json['state'];
    uid = json['uid'];
    internshipStatus = json['internship_status'];
    eventStatus = json['event_status'];
    hackathonStatus = json['hackathon_status'];
    signupkey = json['signupkey'];
    applyStatus = json['Apply_status'];
    planStatus = json['plan_status'];
    gender = json['gender'];
    remark = json['remark'];
    contact = json['contact'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['email'] = email;
    data['password'] = password;
    data['father_name'] = fatherName;
    data['college'] = college;
    data['branch'] = branch;
    data['year_of_passout'] = yearOfPassout;
    data['date_of_birth'] = dateOfBirth;
    data['place_of_birth'] = placeOfBirth;
    data['state'] = state;
    data['uid'] = uid;
    data['internship_status'] = internshipStatus;
    data['event_status'] = eventStatus;
    data['hackathon_status'] = hackathonStatus;
    data['signupkey'] = signupkey;
    data['Apply_status'] = applyStatus;
    data['plan_status'] = planStatus;
    data['gender'] = gender;
    data['remark'] = remark;
    data['contact'] = contact;
    data['created_at'] = createdAt;
    return data;
  }
}
