import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela/core/Di/service_locator.dart';
import 'package:twseela/features/History/logic/history_cubit.dart';
import 'package:twseela/features/NearstStation/logic/nearst_station_cubit.dart';
import 'package:twseela/nearst_station_layout.dart';
import 'package:twseela/features/GetRoute/Ui/screens/get_route_screen_view.dart';
import 'package:twseela/features/Map/presentation/Screens/map_screen_view.dart';
import 'core/constants/app_color.dart';
import 'core/constants/app_style.dart';
import 'core/cubit/bottom_navigation_cubit.dart';
import 'features/GetRoute/logic/destination_cubit.dart';
import 'features/History/ui/screens/history_sceen_view.dart';


class MainLayout extends StatelessWidget {

    const MainLayout({super.key});


  @override
  Widget build(BuildContext context) {

    var screens = [

      GetRouteScreenView(),

      NearestStationLayout(),

      HistoryScreenView(),

      MapScreenView()


    ];

    var text = <String>
    [ "Home",
      "Nearest station"
      , "History"
      , "Map"];

    return MultiBlocProvider(

      providers: [

        BlocProvider(create: (_) => DestinationCubit()),
        BlocProvider(create: (_) => getIt<NearestStationCubit>()),
        BlocProvider(create: (_) => getIt<HistoryCubit>()
          ..getCachedTripsDependsOnDate(DateTime.now())),
        BlocProvider(create: (_) => BottomNavigationCubit()),

      ],

      child: Scaffold(

        backgroundColor: AppColor.primaryColor,

          bottomNavigationBar: _buildBottomNavigationBar(context),


          body: BlocBuilder<BottomNavigationCubit,BottomNavigationState>
            (
              buildWhen: (previous, current) {
                return current  != previous;
              }
              ,builder: (context, state) {

            final index = (state as SwitchIndexState).currentIndex!;

            return IndexedStack(
              index: index,
              children: screens,
            );
          }

      )
      ),
    );
  }

  Widget _buildScreen(int index) {

    switch (index) {
      case 0:
        return GetRouteScreenView();
      case 1:
        return NearestStationLayout();
      case 2:
        return HistoryScreenView();

      case 3:
        return MapScreenView();
      default:
        return Container();
    }
  }

    Widget _buildBottomNavigationBar(BuildContext context) {
      // Pre-defined navigation items for better maintainability
      final navItems = const [
        _NavItem(
          icon: Icons.home,
          label: "Home",
        ),
        _NavItem(
          icon: Icons.near_me,
          label: "Nearest station",
        ),
        _NavItem(
          icon: Icons.history,
          label: "History",
        ),
        _NavItem(
          icon: Icons.map,
          label: "Map",
        ),
      ];

      return BlocSelector<BottomNavigationCubit, BottomNavigationState, int>(
        selector: (state) => (state as SwitchIndexState).currentIndex!,
        builder: (context, currentIndex) {
          return BottomNavigationBar(
            elevation: 30,
            type: BottomNavigationBarType.fixed, // Ensures proper spacing
            backgroundColor: AppColor.secondaryColor,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            currentIndex: currentIndex,
            onTap: (index) {


              if (index != currentIndex) {
                HapticFeedback.vibrate();
                context.read<BottomNavigationCubit>().switchIndex(index);
              }
            },
            items: navItems.map((item) => _buildNavItem(item, currentIndex)).toList(),
            selectedItemColor: AppColor.primaryColor,
            unselectedItemColor: Colors.white,
            selectedLabelStyle: AppStyle.libreSemiBoldMaroon.copyWith(
              color: AppColor.primaryColor,
              fontSize: 12, // Consistent with unselected size
            ),
            unselectedIconTheme: const IconThemeData(
              color: Colors.white,
              size: 20, // Slightly larger for better visibility
            ),
          );
        },
      );
    }

// Helper widget for navigation items


// Builds individual navigation items with proper styling
  BottomNavigationBarItem _buildNavItem(_NavItem item, int currentIndex) {
  return BottomNavigationBarItem(
  icon: Container(
  padding: const EdgeInsets.symmetric(vertical: 6),
  child: Icon(
  item.icon,
  size: 22, // Slightly larger when not selected
  ),
  ),
  activeIcon: Container(
  padding: const EdgeInsets.symmetric(vertical: 6),
  child: Icon(
  item.icon,
  size: 24, // Slightly larger when selected
  ),
  ),
  label: item.label,
  tooltip: '', // Disables default tooltip
  );
  }
}
class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.label,
  });
}