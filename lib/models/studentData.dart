class StudentData {
  final String name;
  final String fatherName;
  final String motherName;
  final String dob;
  final String address;
  final String courseName;
  final String batchName;

  StudentData({
    required this.name,
    required this.fatherName,
    required this.motherName,
    required this.dob,
    required this.address,
    required this.courseName,
    required this.batchName,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      name: json['SName'],
      fatherName: json['FName'],
      motherName: json['MName'],
      dob: json['DOB'],
      address: json['StudentAddress'],
      courseName: json['CourseName'],
      batchName: json['BatchName'],
    );
  }
}
