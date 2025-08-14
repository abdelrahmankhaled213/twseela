import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:twseela/core/constants/MetroConstants.dart';
import 'package:twseela/core/constants/app_style.dart';

import '../../features/GetRoute/model/metro _lines.dart';
import '../constants/app_color.dart';
import '../helpers/flutter_style_helper.dart';

class CustomDropMenuItem extends StatelessWidget {

  final void Function(String?)? onChanged;
  final Color? color;
  final Color? borderColor;
  final FormFieldSetter<String>? onSaved;
  final Future<List<String>> Function(String)? asyncItems;
  final List<String>? items;
  final String? selected;

  const CustomDropMenuItem({

    this.selected,
    this.color,
    this.borderColor,
    required this.onChanged,
    this.onSaved,
    this.asyncItems,
    this.items,
    super.key,
  }) : assert(asyncItems == null || items == null,
  'Cannot provide both asyncItems and items');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/1.2,
      decoration: BoxDecoration(
        color: color ?? AppColor.primaryColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: borderColor ?? AppColor.secondaryColor,
          width: 1,
        ),
        boxShadow: [

          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownSearch<String>(
        items: (filter, loadProps) async{
          return MetroLines.allLines;
        },
        onChanged: onChanged,
        onSaved: onSaved,

        dropdownBuilder: (context, selectedItem) {

          return Text(

            selected ?? MetroConstants.pleaseSelect,
            style: AppStyle.wLibre400black.copyWith(
              color: AppColor.secondaryColor,
              fontSize: 20,
              fontWeight: FontWeightHelper.bold,
            ),
          );
        },
        clickProps: ClickProps(
          borderRadius: BorderRadius.circular(20),
          splashColor: Colors.white,
        ),
        validator: (value) =>
        value == null || value.isEmpty ? "Required field" : null,
        mode: Mode.form,
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            border: InputBorder.none,
            hintText: MetroConstants.pleaseSelect,
            hintStyle: AppStyle.wLibre400black.copyWith(
              color: AppColor.secondaryColor,
              fontSize: 20,
              fontWeight: FontWeightHelper.bold,
            ),
          ),
        ),
        popupProps: PopupProps.menu(
          showSearchBox: true,
          showSelectedItems: true,
          containerBuilder: (ctx, popupWidget) => Container(
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withOpacity(0.95),
              borderRadius: BorderRadius.circular(10),
            ),
            child: popupWidget,
          ),
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: 'Search...',
              fillColor: Colors.transparent,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          itemBuilder: (context, item, isDisabled, isSelected) {
            return Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.secondaryColor
                    : AppColor.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Text(
                item,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight:
                  isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          },
          fit: FlexFit.loose,
        ),
      ),
    );
  }
}