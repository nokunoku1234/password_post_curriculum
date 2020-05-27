import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starter_course/model/model.dart';

import 'db_provider.dart';

class Method {
  static void idCopy(String id) async {
    var idData = ClipboardData(text: id);
    await Clipboard.setData(idData);
  }

  static void pwCopy(String pw) async {
    var idData = ClipboardData(text: pw);
    await Clipboard.setData(idData);
  }

  static Future<void> deleteList(BuildContext context,{FileData fileData, FolderData folderData}) async{
    await DBProvider.deleteSaveData(tableName: (folderData == null) ? 'file' : 'folder', id :(folderData == null) ? fileData.id : folderData.id);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  static Future<void> buildShowModalPopup(BuildContext context, {FileData fileData, FolderData folderData}) {
    return showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('削除しますか？'),
            content: Text('削除すると復元できません。'),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text('キャンセル'),
                onPressed: () {
                  Navigator.pop(context);
                  print('==================キャンセルしました');
                },
              ),
              CupertinoActionSheetAction(
                child: Text('削除'),
                onPressed: () async{
                  await deleteList(context, fileData: fileData, folderData: folderData);
                },
              ),
            ],
          );
        }
    );
  }

}
