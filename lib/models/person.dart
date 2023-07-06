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

  Person({
    required this.name,
    required this.country,
    required this.dateTime,
  });
}
