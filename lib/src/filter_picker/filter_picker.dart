part of tie_picker;

class FilterPicker extends StateWidget<FilterController> {
  final List<FilterItem> items;
  const FilterPicker({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  FilterController createState() => FilterController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Material(
        borderRadius: const BorderRadius.only(
          topLeft: radius8,
          topRight: radius8,
        ),
        color: Colors.white,
        child: Container(
          width: context.w,
          constraints: BoxConstraints(
            maxHeight: context.h * 0.9,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: radius8,
              topRight: radius8,
            ),
          ),
          // padding: const EdgeInsets.all(16.0),
          child: RxWidget<List<FilterItem>>(
            notifier: state.items,
            builder: (ctx, list) => SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    TiePickerLocalizations.of(context)!.filterTitle,
                    style: context.h6?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 22.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ...state.items.mapIndexed(
                    (idx, e) => Container(
                      width: context.w,
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              e.label,
                              style: context.s3,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Wrap(
                            runSpacing: 2.0,
                            spacing: 10.0,
                            alignment: WrapAlignment.center,
                            children: e.items.map(
                              (a) {
                                final selected = e.selected.contains(a);
                                return FilterChip(
                                  selectedColor: Theme.of(context).primaryColor,
                                  showCheckmark: false,
                                  label: Text(
                                    e.toText(a),
                                    style: TextStyle(
                                      color: selected
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: selected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                  selected: selected,
                                  onSelected: (_) => state.onSelected(idx, a),
                                );
                              },
                            ).toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton(
                        onPressed: state.clear,
                        child: Text(
                          TiePickerLocalizations.of(context)!.filterUpdate,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        onTap: state.save,
                        label: TiePickerLocalizations.of(context)!.filterUpdate,
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FilterItem<T> {
  final List<T> items;
  final List<T> selected;
  final String label;
  final String Function(T value) toText;

  FilterItem({
    required this.items,
    required this.label,
    required this.selected,
    required this.toText,
  });
}
