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

  const SigleSelectFilterView(
      {Key? key,
      this.options = const [],
      this.value,
      required this.onSelectChange,
      required this.title,
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
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
          ),
        ),
        Wrap(
          children: [
            ...options.map((option) {
              return Padding(
                padding: const EdgeInsets.only(left: 4, right: 4,bottom: 8),
                child: FilterChip(
                    label: Text(option.key),
                    onSelected: (selected) {
                      onSelectChange(option);
                    },
                    selected: value == option.key,
                    selectedColor: selectedColor),
              );
            })
          ],
        ),
      ],
    );
  }
}

class CheckChipFilterView extends StatelessWidget {
  final List<SelectOption> options;
  final List<String> checked;
  final Function(List<String>) onValueChange;
  final Color? selectedColor;
  final String title;

  const CheckChipFilterView(
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
                  onPressed: () {
                    if (isSelected) {
                      onValueChange(checked
                          .where((element) => element != option.key)
                          .toList());
                      return;
                    } else {
                      onValueChange([...checked, option.key]);
                    }
                  });
            })
          ],
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
                  onPressed: () {

                  });
            }),
            ActionChip(label: const Text("new range"), onPressed: ()async {
              showDialog(context: context, builder: (builder) {
                return Dialog(
                  child:Container(
                    height: 300,
                    child: Column(
                      children: [
                        ElevatedButton(onPressed: (){}, child: Text("Start"))
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
  FilterView({this.title = "Filter", required this.children,this.padding = const EdgeInsets.all(0),this.backgroundColor,this.headerBackgroundColor});

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
          Expanded(child:  Padding(
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
