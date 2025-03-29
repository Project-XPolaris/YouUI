import 'package:flutter/material.dart';

class SelectOption {
  final String label;
  final String key;

  SelectOption({required this.label, required this.key});
}

class SigleSelectFilterView extends StatelessWidget {
  final List<SelectOption> options;
  final String? value;
  final String title;
  final Function(SelectOption) onSelectChange;
  final Color? selectedColor;
  final EdgeInsets textBoxPadding;
  final EdgeInsets chipContainerPadding;
  final double spacing;
  final double runSpacing;
  final EdgeInsets chipContentPadding;


  const SigleSelectFilterView(
      {Key? key,
      this.options = const [],
      this.value,
      required this.onSelectChange,
      required this.title,
      this.textBoxPadding = const EdgeInsets.all(16),
      this.chipContainerPadding = const EdgeInsets.all(8),
      this.chipContentPadding = const EdgeInsets.all(8),
      this.spacing = 4,
      this.runSpacing = 4,
      this.selectedColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: textBoxPadding,
          child: Text(
            title,

          ),
        ),
        Container(
          padding: chipContainerPadding,
          child: Wrap(
            runSpacing: runSpacing,
            spacing: spacing,
            children: [
              ...options.map((option) {
                return FilterChip(
                    label: Text(option.label),
                    onSelected: (selected) {
                      onSelectChange(option);
                    },
                    padding: chipContentPadding,
                    selected: value == option.key,
                    selectedColor: selectedColor);
              })
            ],
          ),
        ),
      ],
    );
  }
}

class CheckChipFilterView extends StatelessWidget {
  final List<SelectOption> options;
  final List<String> checked;
  final Function(SelectOption option, bool isSelected, List<String> seleted)
      onValueChange;
  final Color? selectedColor;
  final String title;
  final double spacing;
  final double runSpacing;
  final EdgeInsets textBoxPadding;
  final EdgeInsets chipContainerPadding;
  final EdgeInsets chipContentPadding;
  final List<Widget> extraChildren;
  final Widget? actions;
  const CheckChipFilterView(
      {Key? key,
      required this.options,
      required this.checked,
      this.selectedColor,
      required this.onValueChange,
      this.title = "",
      this.spacing = 4,
      this.runSpacing = 4,
      this.textBoxPadding = const EdgeInsets.all(16),
      this.chipContainerPadding = const EdgeInsets.all(8),
      this.chipContentPadding = const EdgeInsets.all(8),
      this.extraChildren = const [],
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Row(
            children: [
              Expanded(child: Container(
                width: double.infinity,
                padding: textBoxPadding,
                child: Text(
                  title,
                ),
              ))
              ,
              actions ?? Container()
            ],
          ),
        ),
        Container(
          padding: chipContainerPadding,
          child: Wrap(
            runSpacing: runSpacing,
            spacing: spacing,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: [
              ...options.map((option) {
                bool isSelected = checked.contains(option.key);
                return Container(
                  child: ActionChip(
                      backgroundColor: isSelected ? selectedColor : null,
                      label: Text(option.label),
                      padding: chipContentPadding,
                      onPressed: () {
                        if (isSelected) {
                          onValueChange(
                              option,
                              isSelected,
                              checked
                                  .where((element) => element != option.key)
                                  .toList());
                          return;
                        } else {
                          onValueChange(
                              option, isSelected, [...checked, option.key]);
                        }
                      }),
                );
              }),
              ...extraChildren
            ],
          ),
        )
      ],
    );
  }
}

class DateRangeFilterView extends StatelessWidget {
  final List<SelectOption> options;
  final List<String> checked;
  final Function(List<String>) onValueChange;
  final Color? selectedColor;
  final String title;

  const DateRangeFilterView(
      {Key? key,
      required this.options,
      required this.checked,
      this.selectedColor,
      required this.onValueChange,
      this.title = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
          ),
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          alignment: WrapAlignment.start,
          children: [
            ...options.map((option) {
              bool isSelected = checked.contains(option.key);
              return ActionChip(
                  backgroundColor: isSelected ? selectedColor : null,
                  label: Text(option.label),
                  onPressed: () {});
            }),
            ActionChip(
                label: const Text("new range"),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return Dialog(
                          child: Container(
                            height: 300,
                            child: Column(
                              children: [
                                ElevatedButton(
                                    onPressed: () {}, child: Text("Start"))
                              ],
                            ),
                          ),
                        );
                      });
                })
          ],
        )
      ],
    );
  }
}

class FilterView extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final Color? headerBackgroundColor;

  FilterView(
      {this.title = "Filter",
      required this.children,
      this.padding = const EdgeInsets.all(0),
      this.backgroundColor,
      this.headerBackgroundColor});

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  _FilterViewState();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: widget.headerBackgroundColor,
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
              child: Padding(
            padding: widget.padding,
            child: ListView(
              children: widget.children,
            ),
          ))
        ],
      ),
    );
  }
}
