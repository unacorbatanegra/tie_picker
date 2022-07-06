part of tie_picker;

class MiniPickerOverlay<T> extends StateWidget<MiniPickerOverlayController> {
  final String label;
  final List<T> list;
  final T? item;
  final String Function(T value) toText;
  const MiniPickerOverlay({
    Key? key,
    required this.label,
    required this.list,
    required this.item,
    required this.toText,
  }) : super(key: key);

  @override
  MiniPickerOverlayController createState() => MiniPickerOverlayController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      constraints: BoxConstraints(
        minHeight: context.h * .3,
        maxHeight: context.h * .7,
      ),
      child: Column(
        children: [
          AppBar(
            leading: CupertinoButton(
              child: const Icon(Icons.close),
              onPressed: state.onClose,
            ),
            centerTitle: true,
            title: Text(
              label,
              style: context.h7,
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: list
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
          const SizedBox(height: 18.0)
        ],
      ),
    );
  }
}
