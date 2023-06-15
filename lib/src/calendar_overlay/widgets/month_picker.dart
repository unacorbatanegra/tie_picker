part of tie_picker;

class MonthPicker extends ParentState<CalendarOverlayController> {
  const MonthPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      childAspectRatio: 16 / 6,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      shrinkWrap: true,
      children: List.generate(
        12,
        (idx) {
          final date = DateTime(
            state.currentDate().year,
            idx + 1,
          );
          final isSelected = state.currentDate().month == idx + 1;
          return CupertinoButton(
            onPressed: () => state.onTapMonth(idx + 1),
            padding: EdgeInsets.zero,
            child: Container(
              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                color:
                    isSelected ? Theme.of(context).primaryColor : Palette.gray5,
                borderRadius: const BorderRadius.all(
                  Radius.circular(4.0),
                ),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(4.0),
              child: Text(
                date.monthFormat(context),
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    ).paddingSymmetric(horizontal: 6.0);
    //   },
    // );
  }
}
