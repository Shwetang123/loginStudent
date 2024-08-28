class StudentProfile {
  final String? SName;
  final String? studentPhotoPath;

  StudentProfile({this.SName, this.studentPhotoPath});

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      SName: json['SName'] as String?,
      studentPhotoPath: json['studentphotoPath'] as String?,
    );
  }
}
