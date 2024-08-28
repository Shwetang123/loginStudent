class Attendance {
  List<AttMonths>? attMonths;

  Attendance({this.attMonths});

  Attendance.fromJson(Map<String, dynamic> json) {
    if (json['AttMonths'] != null) {
      attMonths = <AttMonths>[];
      json['AttMonths'].forEach((v) {
        attMonths!.add(AttMonths.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attMonths != null) {
      data['AttMonths'] = attMonths!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttMonths {
  String? attMonthName;
  int? totalAttDays;
  int? totalPresentDays;
  int? totalAbsentDays;
  List<Entries>? entries;

  AttMonths({
    this.attMonthName,
    this.totalAttDays,
    this.totalPresentDays,
    this.totalAbsentDays,
    this.entries,
  });

  AttMonths.fromJson(Map<String, dynamic> json) {
    attMonthName = json['AttMonthName'];
    totalAttDays = json['TotalAttDays'];
    totalPresentDays = json['TotalPresentDays'];
    totalAbsentDays = json['TotalAbsentDays'];
    if (json['Entries'] != null) {
      entries = <Entries>[];
      json['Entries'].forEach((v) {
        entries!.add(Entries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AttMonthName'] = attMonthName;
    data['TotalAttDays'] = totalAttDays;
    data['TotalPresentDays'] = totalPresentDays;
    data['TotalAbsentDays'] = totalAbsentDays;
    if (entries != null) {
      data['Entries'] = entries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Entries {
  String? srNo;
  String? atDate;
  String? atDay;
  String? atStatus;
  String? atRemark;

  Entries({
    this.srNo,
    this.atDate,
    this.atDay,
    this.atStatus,
    this.atRemark,
  });

  Entries.fromJson(Map<String, dynamic> json) {
    srNo = json['SrNo'];
    atDate = json['atDate'];
    atDay = json['atDay'];
    atStatus = json['atStatus'];
    atRemark = json['atRemark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SrNo'] = srNo;
    data['atDate'] = atDate;
    data['atDay'] = atDay;
    data['atStatus'] = atStatus;
    data['atRemark'] = atRemark;
    return data;
  }
}
