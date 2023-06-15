part of tie_picker;

class TimeOverlayController extends StateController<TimeOverlay> {
  final currentTime = DateTime.now().rx;

  @override
  void initState() {
    currentTime.value = widget.time ?? DateTime.now();
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
