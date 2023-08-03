class Colleges {
  List<CollegeModel> colleges = [];

  Colleges.fromListOfColleges(List<Map<String, dynamic>> collegesData) {
    for (var college in collegesData) {
      colleges.add(CollegeModel.fromJson(college));
    }
  }
}

class CollegeModel {
  late int id;
  late String collegeName;
  late String collegeState;
  late String applyStatus;

  CollegeModel({
    required this.id,
    required this.collegeName,
    required this.collegeState,
    required this.applyStatus,
  });

  CollegeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    collegeName = json['college_name'] ?? '';
    collegeState = json['college_state'] ?? '';
    applyStatus = json['Apply_status'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['college_name'] = collegeName;
    data['college_state'] = collegeState;
    data['Apply_status'] = applyStatus;
    return data;
  }
}
