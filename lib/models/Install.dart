// ignore_for_file: file_names

import 'package:hive/hive.dart';

part 'Install.g.dart';

@HiveType(typeId: 1)
class Install {
  @HiveField(0)
  final bool install;

  Install({required this.install});
}
