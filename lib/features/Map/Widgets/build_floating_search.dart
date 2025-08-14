import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:twseela/core/constants/app_style.dart';
import 'package:twseela/features/Map/Widgets/build_suggestions.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/helpers/flutter_style_helper.dart';
import '../presentation/logic/map_features_cubit.dart';

class BuildFloatingSearch extends StatefulWidget {

  const BuildFloatingSearch({super.key});

  @override
  State<BuildFloatingSearch> createState() => _BuildFloatingSearchState();
}

class _BuildFloatingSearchState extends State<BuildFloatingSearch> {

 late final FloatingSearchBarController _controller ;


 @override

  void initState() {

    super.initState();

    _controller = FloatingSearchBarController();

}


 @override
  void dispose() {

    super.dispose();

    _controller.dispose();

  }

  @override
  Widget build(BuildContext context) {

  final cubit=BlocProvider.of<MapFeaturesCubit>(context);

    final isPortrait = MediaQuery
        .of(context)
        .orientation ==
        Orientation.portrait;

    return

      FloatingSearchBar(

        controller: _controller,

        hint: 'Search...',

        hintStyle: AppStyle.libreSemiBoldMaroon.copyWith(
          color: AppColor.primaryColor
        ),

        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),

        transitionDuration: const Duration(milliseconds: 800),

        transitionCurve: Curves.easeInOut,
        backgroundColor: AppColor.secondaryColor,
        borderRadius: BorderRadius.circular(20),
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: isPortrait ? 600 : 500,

        onFocusChanged: (isFocused) {

          if(isFocused){

            cubit.hideDistanceAndTime();

          }
          else{
            cubit.showDistanceAndTime();
          }
        },
        debounceDelay: const Duration(milliseconds: 500),


        onQueryChanged: (query) => _queryChanged(query,context),

       transition: CircularFloatingSearchBarTransition(),

        actions: [

          FloatingSearchBarAction(

            showIfOpened: false,
            child: CircularButton(

              icon: const Icon(Icons.place
                , color: AppColor.primaryColor,
                size: 20,),
              onPressed: () {},
            ),
          ),

          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],

        queryStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeightHelper.regular
        ),
        backdropColor: AppColor.primaryColor,

        builder: (context, transition) {

          return ClipRRect(

            borderRadius: BorderRadius.circular(8),

            child:

            Column(

                children: [

                   BuildSuggestions(

                    floatingSearchBarController: _controller,


                   ),



                  ],
              ),
            );

        },
      );

  }

  void _queryChanged(String query,BuildContext context) async {





    final sessionToken= const Uuid().v4();
    final mapsCubit=BlocProvider.of<MapFeaturesCubit>(context);

   await mapsCubit.getThePlaceSuggestions(query,sessionToken);

  }

}
