class ExamSchedule {
  final String noticeDate;
  final String noticeDesc;
  final String noticeTitle;

  ExamSchedule({
    required this.noticeDate,
    required this.noticeDesc,
    required this.noticeTitle,
  });

  factory ExamSchedule.fromJson(Map<String, dynamic> json) {
    return ExamSchedule(
      noticeDate: json['NoticeDate'],
      noticeDesc: json['NoticeDesc'],
      noticeTitle: json['NoticeTitle'],
    );
  }
}
