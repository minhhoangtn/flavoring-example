import 'package:hive/hive.dart';

class HiveHelper {
  final Box<String> userDB;
  final Box<String> taskDB;

  const HiveHelper({
    required this.userDB,
    required this.taskDB,
  });

  void test(String testcase) async {
    await userDB.put('abc', testcase);
    final a = await userDB.get('abc');
    print(a);
  }
}
