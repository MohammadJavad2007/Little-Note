import 'package:hive/hive.dart';

part 'hash.g.dart';

@HiveType(typeId: 2)
class Hash {
  @HiveField(0)
  final String hash;

  Hash({required this.hash});
}
