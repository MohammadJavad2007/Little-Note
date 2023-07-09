import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 1)
class Person {
  // title notes
  @HiveField(0)
  final String name;

  // description notes
  @HiveField(1)
  final String country;

  // data time notes
  @HiveField(2)
  final String dateTime;

  @HiveField(3)
  final String hash = "0fc302b63c7fa1d0bd1f343002c5eff9";

  Person({
    required this.name,
    required this.country,
    required this.dateTime,
  });
}
