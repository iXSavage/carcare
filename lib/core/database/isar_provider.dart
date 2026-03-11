import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'schema_registry.dart';

part 'isar_provider.g.dart';

@Riverpod(keepAlive: true)
Isar isar(IsarRef ref) {
  throw UnimplementedError('Isar database must be initialized before use');
}

Future<Isar> initIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  // Fix #6: Schemas now come from the registry — no feature-specific imports here
  return Isar.open(isarSchemas, directory: dir.path);
}
