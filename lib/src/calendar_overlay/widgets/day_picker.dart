part of tie_picker;

class DayPicker extends ParentState<CalendarOverlayController> {
  const DayPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RxWidget<DateTime>(
      notifier: state.currentDate,
      builder: (ctx, value) {
        const startDay = DateTime.sunday;

        final date = state.currentDate.value;
        final firstDay = DateTime(date.year, date.month);

        final daysMonth = DateUtils.getDaysInMonth(date.year, date.month);
        final lastDay = DateTime(date.year, date.month, daysMonth);

        int prefixOffset;

        if (firstDay.weekday == 7) {
          prefixOffset = 0;
        } else {
          prefixOffset = (startDay - firstDay.weekday - 7).abs();
        }

        int suffixOffset;

        if (lastDay.weekday == 7) {
          suffixOffset = 6;
        } else {
          suffixOffset = DateTime.saturday - lastDay.weekday;
        }

        int total = daysMonth + suffixOffset + prefixOffset;

        final selected = state.selectedDate();

        return GridView.count(
          crossAxisCount: DateTime.daysPerWeek,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          childAspectRatio: 1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          children: List.generate(
            total,
            (idx) {
              final day = DateTime(
                date.year,
                date.month,
                ((idx + 1) - prefixOffset),
              );
              Color color = Palette.gray6;
              final isNotInTheMonth =
                  day.isBefore(firstDay) || day.isAfter(lastDay);
              if (isNotInTheMonth) {
                color = Palette.gray4;
              }
              final isToday = day.isToday;
              if (isToday) {
                color = Colors.white;
              }
              final isSelected = selected.isInTheSameDay(day);

              if (isSelected) {
                color = Theme.of(context).primaryColor;
              }

              Color textColor;
              if (isNotInTheMonth) {
                textColor = Palette.gray2;
                if (isSelected) {
                  textColor = Colors.white;
                }
              } else {
                if (day.weekday > DateTime.friday) {
                  textColor = Theme.of(context).primaryColor;
                } else {
                  textColor = Colors.black;
                }
                if (isSelected) {
                  textColor = Colors.white;
                }
              }

              return CupertinoButton(
                onPressed: () => state.onTapDay(day),
                padding: EdgeInsets.zero,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    border: isToday && !isSelected ? Border.all() : null,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      fontSize: 14,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ).paddingSymmetric(horizontal: 6.0);
      },
    );
  }
}
