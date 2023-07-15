import 'package:hive/hive.dart';

part 'lang.g.dart';

@HiveType(typeId: 3)
class Lang {
  @HiveField(0)
  final String lang;

  Lang({required this.lang});
}
