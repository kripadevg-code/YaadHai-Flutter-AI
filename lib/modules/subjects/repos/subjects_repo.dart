import 'package:drift/drift.dart';
import 'package:yaad_hai/core/database/app_database.dart';

abstract class SubjectsRepo {
  Stream<List<Subject>> watchSubjects();
  Future<void> addSubject({required String id, required String name, required String colorHex, required String iconName});
  Future<void> deleteSubject(String id);
}

class SubjectsRepoImpl implements SubjectsRepo {
  final AppDatabase _db;
  SubjectsRepoImpl(this._db);

  @override
  Stream<List<Subject>> watchSubjects() => _db.watchSubjects();

  @override
  Future<void> addSubject({required String id, required String name, required String colorHex, required String iconName}) =>
      _db.upsertSubject(
        SubjectsCompanion.insert(id: id, name: name, colorHex: Value(colorHex), iconName: Value(iconName), createdAt: DateTime.now()),
      );

  @override
  Future<void> deleteSubject(String id) => _db.deleteSubject(id);
}
