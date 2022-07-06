library tie_picker;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:occam/occam.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

part 'src/calendar_overlay/calendar_overlay.dart';
part 'src/calendar_overlay/calendar_overlay_controller.dart';
part 'src/calendar_overlay/widgets/day_picker.dart';
part 'src/calendar_overlay/widgets/month_picker.dart';
part 'src/calendar_overlay/widgets/year_picker.dart';

part 'src/filter_picker/filter_controller.dart';
part 'src/filter_picker/filter_picker.dart';
part 'src/mini_picker_overlay/mini_picker_overlay.dart';
part 'src/mini_picker_overlay/mini_picker_overlay_controller.dart';
part 'src/utils/item_widget.dart';
part 'src/modal_picker_overlay/modal_picker_overlay.dart';
part 'src/modal_picker_overlay/modal_picker_overlay_controller.dart';
part 'src/time_overlay/time_overlay.dart';
part 'src/time_overlay/time_overlay_controller.dart';
part 'src/utils/utils.dart';
part 'src/utils/custom_button.dart';

mixin ModalPicker {
  static bool _isModalOpen = false;

  static Future<T?> miniPick<T>({
    required BuildContext context,
    required String label,
    required List<T> list,
    required T? item,
    required String Function(T value) toText,
  }) async {
    if (_isModalOpen) return null;
    _isModalOpen = true;

    final result = await showModalBottomSheet<T>(
      context: context,
      builder: (ctx) => MiniPickerOverlay(
        label: label,
        list: list,
        item: item,
        toText: toText,
      ),
    );
    _isModalOpen = false;
    return result;
  }

  static Future<List<FilterItem>> filter({
    required List<FilterItem> items,
    required BuildContext context,
  }) async {
    final result = await showCupertinoModalPopup(
      context: context,
      builder: (ctx) => FilterPicker(items: items),
    ) as List<FilterItem>?;
    if (result == null) return items;
    return result;
  }

  static Future<T?> modalPick<T>({
    required BuildContext context,
    required String label,
    required List<T> list,
    required T? item,
    required String Function(T value) toText,
  }) async {
    if (_isModalOpen) return null;
    _isModalOpen = true;

    final result = await showCupertinoModalPopup(
      context: context,
      builder: (ctx) => ModalPickerOverlay(
        label: label,
        list: list,
        item: item,
        toText: toText,
      ),
    );
    _isModalOpen = false;
    return result;
  }

  static Future<DateTime?> datePicker({
    required BuildContext context,
    required DateTime? date,
    CalendarMode mode = CalendarMode.day,
  }) async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (ctx) => CalendarOverlay(date: date, mode: mode),
      isScrollControlled: true,
      useRootNavigator: true,
    );

    return result ?? date;
  }

  static Future<DateTime?> timePicker({
    required BuildContext context,
    required DateTime? date,
  }) async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (ctx) => TimeOverlay(time: date),
      isScrollControlled: true,
      useRootNavigator: true,
    );
    return result ?? date;
  }
}
