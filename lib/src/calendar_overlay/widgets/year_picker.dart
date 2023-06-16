part of tie_picker;

class YearPicker extends ParentState<CalendarOverlayController> {
  const YearPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Container(
      constraints: BoxConstraints(maxHeight: context.h * .5),
      child: GridView.count(
        crossAxisCount: 3,
        physics: const AlwaysScrollableScrollPhysics(),
        // controller: state.yearController,
        padding: EdgeInsets.zero,
        childAspectRatio: 16 / 6,
        scrollDirection: Axis.vertical,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        shrinkWrap: true,
        // reverse: true,
        children: state.years.map(
          (idx) {
            final year = (now.year + 10) - idx;
            final isSelected = year == state.currentDate().year;
            return CupertinoButton(
              onPressed: () => state.onTapYear(year),
              padding: EdgeInsets.zero,
              child: Container(
                constraints: const BoxConstraints.expand(),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Palette.gray5,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '$year',
                  style: TextStyle(
                    fontSize: 14,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ).toList(),
      ).paddingSymmetric(horizontal: 6.0),
    );
  }
}
