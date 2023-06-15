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
    return SafeArea(
      bottom: false,
      child: Material(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: radius8,
          topRight: radius8,
        ),
        child: Container(
          width: context.w,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: radius8,
              topRight: radius8,
            ),
          ),
          constraints: BoxConstraints(
            maxHeight: context.h * .4,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: zero,
                    child: const Icon(Icons.close),
                    onPressed: state.onClose,
                  ),
                  Text(
                    'Time',
                    style: context.h6,
                  ),
                  CupertinoButton(
                    padding: zero,
                    child: const Icon(Icons.done),
                    onPressed: state.accept,
                  ).paddingOnly(right: 6.0),
                ],
              ).paddingSymmetric(horizontal: 6.0),
              Expanded(
                child: RxWidget<DateTime?>(
                  notifier: state.currentTime,
                  builder: (ctx, currentTime) => CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: currentTime,
                    onDateTimeChanged: state.currentTime,
                  ),
                ),
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}
