import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:twseela/core/constants/MetroConstants.dart';
import 'package:twseela/features/GetRoute/model/metro_hive.dart';

class HiveService{

  static Future<void> hiveInit() async {

    await Hive.initFlutter();

    Hive.registerAdapter(MetroModelHiveAdapter());

    await Hive.openBox(MetroConstants.hiveKey);

  }

  static Future<List<MetroModelHive>> getTrips() async {

    final box = Hive.box(MetroConstants.hiveKey);

    final List<MetroModelHive> trips =
    box.get("trip", defaultValue: <MetroModelHive>[])!.cast<MetroModelHive>();


    return List.from(trips);

  }


  static Future<void >addTrip(MetroModelHive metroModelHive)async{

    final box = Hive.box(MetroConstants.hiveKey);

List data =box.get('trip',defaultValue: <MetroModelHive>[]);

    data.add(metroModelHive);

    // Save updated list back to Hive

    await box.put("trip", data);


  }

  static Future<void>deleteTrip() async {

    final box=Hive.box(MetroConstants.hiveKey);

    await box.delete("trip");

  }

  static Future<void>clearAllTrips()async{

    final box=Hive.box(MetroConstants.hiveKey);

    await box.clear();

  }

}