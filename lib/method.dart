import 'package:flutter/services.dart';

class Copy {
  static void idCopy(String id) async {
    var idData = ClipboardData(text: id);
    await Clipboard.setData(idData);
  }

  static void pwCopy(String pw) async {
    var idData = ClipboardData(text: pw);
    await Clipboard.setData(idData);
  }
}
