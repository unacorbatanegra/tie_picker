part of tie_picker;

class TimeOverlayController extends StateController<TimeOverlay> {
  final currentTime = DateTime.now().rx;

  @override
  void initState() {
    final time = widget.time ?? DateTime.now();
    currentTime.value = DateTime(
      time.year,
      time.month,
      time.day,
      time.hour,
      time.minute,
      time.second,
      time.millisecond,
      time.microsecond,
    );
    super.initState();
  }

  void onDateTime(DateTime value) {
    currentTime.value = value;
  }

  void accept() => navigator.pop(currentTime.value);

  void onClose() => navigator.pop();

  @override
  void dispose() {
    currentTime.dispose();
    super.dispose();
  }
}
