class SaveData {
  int id;
  String title;
  String passId;
  String passPW;
  DateTime date;

  SaveData({this.id, this.title, this.passId, this.passPW, this.date});

  Map<String, dynamic> toMap() {
      return {
        'id': id,
        'title': title,
        'pass_id': passId,
        'pass_pw': passPW,
        'date': date,
      };
  }
}