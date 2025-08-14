import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela/MainLayout.dart';
import 'package:twseela/core/Di/service_locator.dart';
import 'package:twseela/core/cubit/bottom_navigation_cubit.dart';
import 'features/Map/presentation/logic/map_features_cubit.dart';

class Twseela extends StatelessWidget {

  const Twseela({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(

      lazy: false,

      create: (context) {

        final cubit = getIt<MapFeaturesCubit>();

        debugPrint('Calling getCurrentLocation');

        return cubit..getCurrentLocation();

      },

      child: MaterialApp(

        title: 'Twseela',

        debugShowCheckedModeBanner: false,

        home: BlocProvider(create: (context) {
          return getIt<BottomNavigationCubit>();
        },child: MainLayout())

      ),
    );
  }
}
