part of tie_picker;

class ModalPickerOverlayController<T>
    extends StateController<ModalPickerOverlay<T>> {
  final listShow = <T>[].rx;

  @override
  void readyState() => listShow.assignAll(widget.list);

  void onTap(T e) => navigator.pop(e);

  void onSearch(String value) => listShow.assignAll(widget.list.where(
      (e) => widget.toText(e).toLowerCase().contains(value.toLowerCase())));

  void back() => navigator.pop();

  @override
  void dispose() {
    listShow.dispose();
    super.dispose();
  }
}
