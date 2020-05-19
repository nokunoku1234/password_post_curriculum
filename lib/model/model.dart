class SaveData {
  int id;
  String title;
  String passId;
  String passPw;
  DateTime date;

  SaveData({this.id, this.title, this.passId, this.passPw, this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'pass_id': passId,
      'pass_pw': passPw,
      'date': date,
    };
  }
}
