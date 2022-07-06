part of tie_picker;

class FilterController extends StateController<FilterPicker> {
  final items = <FilterItem>[].rx;

  @override
  void readyState() {
    items.addAll(widget.items);
  }

  void onSelected(int idx, Object item) {
    final filter = items[idx];
    if (filter.selected.contains(item)) {
      filter.selected.remove(item);
    } else {
      filter.selected.add(item);
    }
    items[idx] = filter;
    items.refresh();
  }

  void save() => navigator.pop(items);

  void clear() {
    for (final u in items) {
      u.selected.clear();
    }
    items.refresh();
  }

  @override
  void dispose() {
    items.dispose();
    super.dispose();
  }
}
