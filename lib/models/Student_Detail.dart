class StudentDetails {
  StudentDetails({
    required this.msg,
    required this.displayMsg,
    required this.instituteName,
    required this.instituteLogo,
    required this.instituteUrl,
    required this.colorTheme,
    required this.excludedMenuItems,
    required this.students,
  });

  final String? msg;
  final String? displayMsg;
  final String? instituteName;
  final String? instituteLogo;
  final String? instituteUrl;
  final String? colorTheme;
  final dynamic excludedMenuItems;
  final List<Student> students;

  factory StudentDetails.fromJson(Map<String, dynamic> json){
    return StudentDetails(
      msg: json["msg"],
      displayMsg: json["DisplayMsg"],
      instituteName: json["InstituteName"],
      instituteLogo: json["InstituteLogo"],
      instituteUrl: json["InstituteUrl"],
      colorTheme: json["ColorTheme"],
      excludedMenuItems: json["ExcludedMenuItems"],
      students: json["students"] == null ? [] : List<Student>.from(json["students"]!.map((x) => Student.fromJson(x))),
    );
  }

}

class Student {
  Student({
    required this.studentId,
    required this.regNo,
    required this.sName,
    required this.fName,
    required this.mName,
    required this.dob,
    required this.primaryContactNo,
    required this.studentAddress,
    required this.batchName,
    required this.rollNo,
  });

  final int? studentId;
  final String? regNo;
  final String? sName;
  final String? fName;
  final String? mName;
  final String? dob;
  final String? primaryContactNo;
  final String? studentAddress;
  final String? batchName;
  final dynamic rollNo;


  factory Student.fromJson(Map<String, dynamic> json){
    return Student(
      studentId: json["StudentID"],
      regNo: json["RegNo"],
      sName: json["SName"],
      fName: json["FName"],
      mName: json["MName"],
      dob: json["DOB"],
      primaryContactNo: json["PrimaryContactNo"],
      studentAddress: json["StudentAddress"],
      batchName: json["BatchName"],
      rollNo: json["RollNo"],

    );
  }

}
