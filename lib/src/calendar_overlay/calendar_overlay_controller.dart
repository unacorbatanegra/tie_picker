part of tie_picker;

enum CalendarMode { day, month, year }

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
      title.value = currentDate().calendarFormat;
    } else if (calendarMode() == CalendarMode.month) {
      title.value = currentDate().yearFormat;
    }
  }

  void onCalendar(mode) => onDate(currentDate());

  
  void onTapDay(DateTime day) {
    navigator.pop(
      DateTime(
        day.year,
        day.month,
        day.day,
        selectedDate().hour,
        selectedDate().minute,
        selectedDate().second,
        selectedDate().millisecond,
        selectedDate().microsecond,
      ),
    );
  }

  void next() {
    if (calendarMode() == CalendarMode.month) {
      currentDate.value = DateTime(
        currentDate().year + 1,
        currentDate().month,
        currentDate().day,
        currentDate().hour,
        currentDate().minute,
        currentDate().second,
        currentDate().millisecond,
        currentDate().microsecond,
      );
    } else {
      currentDate.value = DateTime(
        currentDate().year,
        currentDate().month + 1,
        currentDate().day,
        currentDate().hour,
        currentDate().minute,
        currentDate().second,
        currentDate().millisecond,
        currentDate().microsecond,
      );
    }
  }

  void back() {
    if (calendarMode() == CalendarMode.month) {
      currentDate.value = DateTime(
        currentDate().year - 1,
        currentDate().month,
        currentDate().day,
        currentDate().hour,
        currentDate().minute,
        currentDate().second,
        currentDate().millisecond,
        currentDate().microsecond,
      );
    } else {
      currentDate.value = DateTime(
        currentDate().year,
        currentDate().month - 1,
        currentDate().day,
        currentDate().hour,
        currentDate().minute,
        currentDate().second,
        currentDate().millisecond,
        currentDate().microsecond,
      );
    }
  }

  @override
  void dispose() {
    title.dispose();
    currentDate.dispose();
    selectedDate.dispose();
    calendarMode.dispose();
    super.dispose();
  }

  void today() => navigator.pop(DateTime.now());

  void onTapMonth(int month) {
    final date = DateTime(currentDate().year, month, currentDate().day);
    if (returnMode == CalendarMode.month) {
      navigator.pop(date);
      return;
    }
    currentDate.value = date;
    currentDate.refresh();
    calendarMode.value = CalendarMode.day;
  }

  void onTapYear(int year) {
    final date = DateTime(year, currentDate().month, currentDate().day);
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
  static final DateFormat _calendar = DateFormat('MMM, y', 'es_AR');
  static final DateFormat _yearFormat = DateFormat.y('es_AR');
  static final _monthformat = DateFormat('MMMM', 'es_AR');
  String get monthFormat => _monthformat.format(this);
  String get calendarFormat => _calendar.format(this);
  String get yearFormat => _yearFormat.format(this);

  bool isInTheSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  bool get isToday {
    final other = DateTime.now();
    return year == other.year && month == other.month && day == other.day;
  }
}
