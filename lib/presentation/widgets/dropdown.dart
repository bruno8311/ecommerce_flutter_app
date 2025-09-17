import 'package:atomic_desing_system_package/atomic_desing_system_package.dart';
import 'package:flutter/material.dart';

class AppDropdown extends StatefulWidget {
  final String? selectedItem;
  final List<String> listItems;
  final String textLabel;
  final ValueChanged<String?>? onChanged;
  const AppDropdown({super.key, required this.selectedItem, required this.listItems, required this.textLabel, this.onChanged});

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MoleculeDropdownField<String>(
      label: widget.textLabel,
      items: widget.listItems.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
      value: widget.selectedItem,
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      helperText: 'Elige una opción',
      hint: 'Filtrar',
    );
  }
}