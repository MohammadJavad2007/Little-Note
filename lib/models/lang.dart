import 'package:hive/hive.dart';

part 'lang.g.dart';

@HiveType(typeId: 3)
class Lang {
  @HiveField(0)
  final String lang;

  @HiveField(1)
  final String country;

  Lang({required this.lang , required this.country });
}
