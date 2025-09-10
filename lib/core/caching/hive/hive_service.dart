import 'package:hive_flutter/hive_flutter.dart';

class HiveService<T> {
  final Box<T> box;

  HiveService(this.box);

  /// إضافة عنصر جديد إلى Hive
  Future<void> add(String key, T value) async {
    await box.put(key, value);
  }

  /// تحديث عنصر موجود
  Future<void> update(String key, T value) async {
    if (box.containsKey(key)) {
      await box.put(key, value);
    } else {
      throw Exception("Key not found in box");
    }
  }

  /// قراءة عنصر واحد
  T? get(String key) {
    return box.get(key);
  }

  /// قراءة جميع العناصر
  List<T> getAll() {
    return box.values.toList();
  }

  /// حذف عنصر
  Future<void> delete(String key) async {
    await box.delete(key);
  }

  /// حذف جميع العناصر
  Future<void> clear() async {
    await box.clear();
  }
}
