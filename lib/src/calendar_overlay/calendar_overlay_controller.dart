part of tie_picker;

enum CalendarMode {
  day,
  month,
  year,
}

class CalendarOverlayController extends StateController<CalendarOverlay> {
  final title = ''.rx;
  final currentDate = DateTime.now().rx;
  final selectedDate = DateTime.now().rx;
  final calendarMode = CalendarMode.day.rx;

  late CalendarMode returnMode;
  final years = <int>[];

  @override
  void readyState() {
    if (widget.date != null) {
      selectedDate.value = widget.date!;
      currentDate.value = widget.date!;
    }
    returnMode = widget.mode;
    calendarMode.value = widget.mode;

    years.addAll(List.generate(100, (index) => index));
    onDate(currentDate());
    calendarMode.addValueListener(onCalendar);
    currentDate.addValueListener(onDate);
    super.readyState();
  }

  void onDate(DateTime date) {
    if (calendarMode() == CalendarMode.day) {
      title.value = currentDate().calendarFormat(context);
    } else if (calendarMode() == CalendarMode.month) {
      title.value = currentDate().yearFormat(context);
    }
  }

  void onCalendar(mode) => onDate(currentDate());

  void onTapDay(DateTime day) => navigator.pop(
        DateTime(
          day.year,
          day.month,
          selectedDate().hour,
          selectedDate().minute,
          selectedDate().second,
          selectedDate().minute,
        ),
      );

  void next() {
    if (calendarMode() == CalendarMode.month) {
      currentDate.value = currentDate.value.copyWith(
        year: currentDate().year + 1,
      );
    } else {
      currentDate.value = currentDate.value.copyWith(
        month: currentDate().month + 1,
      );
    }
  }

  void back() {
    if (calendarMode() == CalendarMode.month) {
      currentDate.value = currentDate.value.copyWith(
        year: currentDate().year - 1,
      );
    } else {
      currentDate.value = currentDate.value.copyWith(
        month: currentDate().month - 1,
      );
    }
  }

  @override
  void dispose() {
    title.dispose();
    calendarMode.removeValueListener(onCalendar);
    currentDate.removeValueListener(onDate);
    currentDate.dispose();
    selectedDate.dispose();
    calendarMode.dispose();
    super.dispose();
  }

  void today() => navigator.pop(DateTime.now());

  void onTapMonth(int month) {
    final date = currentDate().copyWith(month: month);
    if (returnMode == CalendarMode.month) {
      navigator.pop(date);
      return;
    }
    currentDate.value = date;
    currentDate.refresh();
    calendarMode.value = CalendarMode.day;
  }

  void onTapYear(int year) {
    final date = currentDate.value.copyWith(year: year);
    if (returnMode == CalendarMode.year) {
      navigator.pop(date);
      return;
    }
    currentDate.value = date;
    currentDate.refresh();

    calendarMode.value = CalendarMode.month;
  }

  void onTapTitle() {
    if (calendarMode() == CalendarMode.day) {
      calendarMode.value = CalendarMode.month;
    } else if (calendarMode() == CalendarMode.month) {
      calendarMode.value = CalendarMode.year;
    }
  }

  void onClose() {
    navigator.pop();
  }
}

extension DateTimeFormat on DateTime {
  String locale(BuildContext context) =>
      Localizations.localeOf(context).languageCode;

  String monthFormat(BuildContext context) {
    final _monthformat = DateFormat('MMMM', locale(context));
    return _monthformat.format(this);
  }

  String calendarFormat(BuildContext context) {
    final _calendar = DateFormat('MMM, y', locale(context));
    return _calendar.format(this);
  }

  String yearFormat(BuildContext context) {
    final _yearFormat = DateFormat.y(locale(context));
    return _yearFormat.format(this);
  }

  bool isInTheSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  bool get isToday {
    final other = DateTime.now();
    return year == other.year && month == other.month && day == other.day;
  }
}
