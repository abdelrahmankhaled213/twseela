import 'package:hive/hive.dart';
part 'metro_hive.g.dart';

@HiveType(typeId: 0)

class MetroModelHive{

  @HiveField(0)
  final String start;

  @HiveField(1)
   final String end;

  @HiveField(2)
  final String firstRoute;

  @HiveField(3)
  final String? secondRoute;

  @HiveField(4)
  final String? thirdRoute;

  @HiveField(5)
  final DateTime time;

   @HiveField(6)
   final num ticketPrice;

   @HiveField(7)
    final int expectedTime;

  @HiveField(8)
   final int noOFStation;

MetroModelHive(
  {

    required this.ticketPrice,
    required this.expectedTime,
    required this.time,
    required this.end,
    required this.start,
    required this.firstRoute,
     this.secondRoute,
     this.thirdRoute,
   required this.noOFStation,

}

);



}