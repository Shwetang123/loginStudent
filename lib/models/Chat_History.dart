class Chat_History {
  List<Msg>? msg;

  Chat_History({this.msg});

  Chat_History.fromJson(Map<String, dynamic> json) {
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
  int? msgID;
  int? messageTypeID;
  String? msgHeader;
  String? msgBody;
  String? msgDocFile;
  int? msgSenderID;
  int? msgSenderType;
  int? msgReceiverID;
  int? msgReceiverType;
  String? entryTime;
  String? receiverName;
  String? senderName;
  bool? isRead;

  Msg(
      {this.msgID,
        this.messageTypeID,
        this.msgHeader,
        this.msgBody,
        this.msgDocFile,
        this.msgSenderID,
        this.msgSenderType,
        this.msgReceiverID,
        this.msgReceiverType,
        this.entryTime,
        this.receiverName,
        this.senderName,
        this.isRead, required List msgReceiverIDs});

  Msg.fromJson(Map<String, dynamic> json) {
    msgID = json['msgID'];
    messageTypeID = json['MessageTypeID'];
    msgHeader = json['msgHeader'];
    msgBody = json['msgBody'];
    msgDocFile = json['msgDocFile'];
    msgSenderID = json['msgSenderID'];
    msgSenderType = json['msgSenderType'];
    msgReceiverID = json['msgReceiverID'];
    msgReceiverType = json['msgReceiverType'];
    entryTime = json['EntryTime'];
    receiverName = json['ReceiverName'];
    senderName = json['SenderName'];
    isRead = json['IsRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgID'] = this.msgID;
    data['MessageTypeID'] = this.messageTypeID;
    data['msgHeader'] = this.msgHeader;
    data['msgBody'] = this.msgBody;
    data['msgDocFile'] = this.msgDocFile;
    data['msgSenderID'] = this.msgSenderID;
    data['msgSenderType'] = this.msgSenderType;
    data['msgReceiverID'] = this.msgReceiverID;
    data['msgReceiverType'] = this.msgReceiverType;
    data['EntryTime'] = this.entryTime;
    data['ReceiverName'] = this.receiverName;
    data['SenderName'] = this.senderName;
    data['IsRead'] = this.isRead;
    return data;
  }
}