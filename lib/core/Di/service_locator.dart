import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:twseela/core/Hive/hive_services.dart';
import 'package:twseela/core/api/api_constants.dart';
import 'package:twseela/core/api/api_service.dart';
import 'package:twseela/core/cubit/bottom_navigation_cubit.dart';
import 'package:twseela/features/History/logic/history_cubit.dart';
import 'package:twseela/features/Map/presentation/logic/map_debouncer.dart';
import 'package:twseela/features/NearstStation/logic/nearst_station_cubit.dart';
import '../../features/Map/Data/repo/mapRepo.dart';
import '../../features/Map/presentation/logic/map_features_cubit.dart';
import '../api/dio_consumer.dart';

final GetIt getIt = GetIt.instance;

void setUpServiceLocator() {




  /// debounce



 final AutoCompleteDeBouncer autoCompleteDeBouncer = AutoCompleteDeBouncer
   (duration: const Duration(milliseconds: 500));


/// dio

final dio=Dio(

  BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    receiveDataWhenStatusError: true,

  ),
);


  /// DioConsumer


  getIt.registerLazySingleton<ApiConsumer>(() {

    return DioConsumer(dio: dio);

    },
  );


  /// Repos

 getIt.registerLazySingleton<MapsRepo>(() {

   return MapsRepo(getIt<ApiConsumer>());

 },
 );

 /// Cubits

getIt.registerLazySingleton(() {

  return MapFeaturesCubit(getIt<MapsRepo>(),autoCompleteDeBouncer);

  },
);

 getIt.registerFactory(() {

   return NearestStationCubit();

 },
 );

 getIt.registerFactory(() {

   return HistoryCubit();

 },
 );


 getIt.registerFactory(() {

   return BottomNavigationCubit();

 },
 );




}