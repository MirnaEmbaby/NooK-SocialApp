class MessageModel {
  late String senderId;
  late String receiverId;
  late String dateTime;
  late String msg;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.msg,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    msg = json['msg'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'msg': msg,
    };
  }
}
