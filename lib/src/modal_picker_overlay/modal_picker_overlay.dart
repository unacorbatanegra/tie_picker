part of tie_picker;

class ModalPickerOverlay<T>
    extends StateWidget<ModalPickerOverlayController<T>> {
  final String label;
  final List<T> list;
  final T? item;
  final String Function(T value) toText;
  const ModalPickerOverlay({
    Key? key,
    required this.label,
    required this.list,
    required this.item,
    required this.toText,
  }) : super(key: key);

  @override
  ModalPickerOverlayController<T> createState() =>
      ModalPickerOverlayController<T>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Material(
        
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          constraints: BoxConstraints(
            minHeight: context.h * .3,
            maxHeight: context.h * .9,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              
              Row(
                children: [
                  CupertinoButton(
                    child: const Icon(Icons.close),
                    onPressed: state.back,
                  ),
                  Flexible(
                    child: Text(
                      label,
                      style: context.h7,
                    ),
                  ),
                ],
              ),
              CupertinoSearchTextField(
                onChanged: state.onSearch,
                onSubmitted: state.onSearch,
              ).paddingSymmetric(horizontal: 16.0),
              RxWidget(
                notifier: state.listShow,
                builder: (ctx, value) => Expanded(
                  child: CupertinoScrollbar(
                    child: ListView(
                      shrinkWrap: true,
                      padding: zero,
                      children: state.listShow
                          .map(
                            (e) => ItemWidget(
                              selected: e == item,
                              label: toText(e),
                              onTap: () => state.onTap(e),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
