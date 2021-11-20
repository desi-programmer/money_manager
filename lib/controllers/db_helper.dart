import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbHelper {
  late Box box;
  late SharedPreferences preferences;

  DbHelper() {
    openBox();
  }

  openBox() {
    box = Hive.box('money');
  }

  void addData(int amount, DateTime date, String type, String note) async {
    var value = {'amount': amount, 'date': date, 'type': type, 'note': note};
    box.add(value);
  }

  Future deleteData(
    int index,
  ) async {
    await box.deleteAt(index);
  }

  Future cleanData() async {
    await box.clear();
  }

  addName(String name) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString('name', name);
  }

  getName() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString('name');
  }

  setLocalAuth(bool val) async {
    preferences = await SharedPreferences.getInstance();
    return preferences.setBool('auth', val);
  }

  Future<bool> getLocalAuth() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getBool('auth') ?? false;
  }
}
