part of tie_picker;

class TimeOverlay extends StateWidget<TimeOverlayController> {
  final DateTime? time;

  const TimeOverlay({
    Key? key,
    required this.time,
  }) : super(key: key);

  @override
  TimeOverlayController createState() => TimeOverlayController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: context.h * .4,
      width: context.w,
      // constraints: BoxConstraints(maxHeight: context.height * .6),
      child: Column(
        children: [
          AppBar(
            leading: CupertinoButton(
              child: const Icon(Icons.close),
              onPressed: state.onClose,
            ),
            centerTitle: true,
            title: Text(
              'Time',
              style: context.h7,
            ),
            actions: [
              CupertinoButton(
                child: const Icon(Icons.done),
                onPressed: state.accept,
              )
            ],
          ),
          Expanded(
            child: RxWidget<DateTime?>(
              notifier: state.currentTime,
              builder: (ctx, currentTime) => CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: currentTime,
                onDateTimeChanged: state.onDateTime,
              ),
            ),
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }
}
