import 'package:hive/hive.dart';


class DbHelper {
  late Box box;

  DbHelper() {
    Hive.init('db');
    openBox();
  }
  openBox() {
    box = Hive.box('money');
  }

 

  Future addData(int amount, String note, String type, DateTime date) async {
    // var value={'amount'=amount,'note'=note,'type'=type,'date'=date};
    var value = {
      "amount": amount,
      "note": note,
      "type": type,
      "date": date,
    };
    box.add(value);
  }

  Future<Map> fetch() {
    if (box.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(box.toMap());
    }
  }

  
}
