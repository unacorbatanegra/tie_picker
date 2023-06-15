part of tie_picker;

class CalendarOverlay extends StateWidget<CalendarOverlayController> {
  final DateTime? date;
  final CalendarMode mode;

  const CalendarOverlay({
    Key? key,
    required this.date,
    required this.mode,
  }) : super(key: key);

  @override
  CalendarOverlayController createState() => CalendarOverlayController();

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
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: radius8,
              topRight: radius8,
            ),
          ),
          constraints: BoxConstraints(minHeight: context.h * .5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                    TiePickerLocalizations.of(context)?.calendarTitle ??
                        'nullo',
                    style: context.h6,
                  ),
                  CupertinoButton(
                    padding: zero,
                    child: Text(
                      TiePickerLocalizations.of(context)!.calendarToday,
                    ),
                    onPressed: state.today,
                  ).paddingOnly(right: 6.0),
                ],
              ).paddingSymmetric(horizontal: 6.0),
              RxWidget<CalendarMode>(
                notifier: state.calendarMode,
                builder: (ctx, calendarMode) {
                  if (calendarMode == CalendarMode.year) {
                    return emptyWidget;
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        padding: zero,
                        child: const Icon(Icons.arrow_back_ios),
                        onPressed: state.back,
                      ),
                      RxWidget<String>(
                        notifier: state.title,
                        builder: (ctx, title) => InkWell(
                          onTap: state.onTapTitle,
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                            style: context.s1,
                          ),
                        ),
                      ),
                      CupertinoButton(
                        padding: zero,
                        child: const Icon(Icons.arrow_forward_ios),
                        onPressed: state.next,
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 6.0);
                },
              ),
              RxWidget<CalendarMode>(
                notifier: state.calendarMode,
                builder: (ctx, calendarMode) => switch (calendarMode) {
                  CalendarMode.day => const DayPicker(),
                  CalendarMode.month => const MonthPicker(),
                  CalendarMode.year => const YearPicker(),
                },
              ),
              const Gap(64)
            ],
          ),
        ),
      ),
    );
  }
}
