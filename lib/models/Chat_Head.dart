class Chat_Head {
  List<Msg>? msg;

  Chat_Head({this.msg});

  Chat_Head.fromJson(Map<String, dynamic> json) {
    if (json['msg'] != null) {
      msg = <Msg>[];
      json['msg'].forEach((v) {
        msg!.add(new Msg.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.msg != null) {
      data['msg'] = this.msg!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Msg {
  int? userID;
  String? userName;
  String? userImage;
  String? caption;

  Msg({this.userID, this.userName, this.userImage, this.caption});

  Msg.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    userName = json['UserName'];
    userImage = json['UserImage'];
    caption = json['Caption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserID'] = this.userID;
    data['UserName'] = this.userName;
    data['UserImage'] = this.userImage;
    data['Caption'] = this.caption;
    return data;
  }
}
