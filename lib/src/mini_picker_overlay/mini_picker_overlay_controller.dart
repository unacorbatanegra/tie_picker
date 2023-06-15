part of tie_picker;
class MiniPickerOverlayController<T> extends StateController {
  
  void onTap(T e) => navigator.pop(e);

  void back() => navigator.pop();
}
