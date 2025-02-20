import 'package:flutter/material.dart';
import 'package:manasa_dashboard/core/constants.dart';
import 'package:manasa_dashboard/core/utils/widgets/selected_drop_down_manager.dart';

class SelectedDropDownItem extends StatelessWidget {
  const SelectedDropDownItem({
    super.key,
    required this.index,
    required this.functionSelected,
    required this.name,
    required this.manager,
    required this.selectedIndex,
  });

  final int index;
  final Function() functionSelected;
  final String name;
  final SelectedDropDownManager manager;
  final int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    manager.selectedIndex = selectedIndex;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Expanded(
          flex: 1,
          child: Checkbox(
            checkColor: Colors.white,
            activeColor: kPrimaryKey,
            value: manager.isIndexSelected(index),
            onChanged: (value) {
              if (value == true) {
                manager.selectIndex(index);
                functionSelected();
              }
            },
          ),
        )
      ],
    );
  }
}

class SelectedDistricSearchDropDownItem extends StatelessWidget {
  const SelectedDistricSearchDropDownItem({
    super.key,
    required this.index,
    required this.functionSelected,
    required this.name,
    required this.manager,
    required this.selectedIndex,
  });

  final int index;
  final Function() functionSelected;
  final String name;
  final SelectedDropDownManager manager;
  final int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    manager.selectedIndex = selectedIndex ?? null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Expanded(
          flex: 1,
          child: Checkbox(
            checkColor: Colors.white,
            activeColor: kPrimaryKey,
            value: manager.isIndexSelected(index),
            onChanged: (value) {
              if (value == true) {
                manager.selectIndex(index);
                functionSelected();
              }
            },
          ),
        )
      ],
    );
  }
}

class SelectedSearchDropDownItem extends StatelessWidget {
  const SelectedSearchDropDownItem({
    super.key,
    required this.index,
    required this.functionSelected,
    required this.name,
    required this.manager,
  });

  final int index;
  final Function() functionSelected;
  final String name;
  final SelectedSearchDropDownManager manager;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Expanded(
          flex: 1,
          child: Checkbox(
            checkColor: Colors.white,
            activeColor: kPrimaryKey,
            value: manager.isIndexSelected(index),
            onChanged: (value) {
              manager.toggleIndex(index);
              functionSelected();
            },
          ),
        )
      ],
    );
  }
}

class SelectedMultipleDropDownItem extends StatelessWidget {
  const SelectedMultipleDropDownItem({
    super.key,
    required this.index,
    required this.functionSelected,
    required this.name,
    required this.manager,
    required this.selectedIndices,
  });

  final int index;
  final Function() functionSelected;
  final String name;
  final SelectedMultipleDropDownManager manager;
  final List<int>? selectedIndices;

  @override
  Widget build(BuildContext context) {
    manager.selectedIndices = selectedIndices ?? [];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Expanded(
          flex: 1,
          child: Checkbox(
            checkColor: Colors.white,
            activeColor: kPrimaryKey,
            value: manager.isIndexSelected(index),
            onChanged: (value) {
              if (value == true || manager.isIndexSelected(index)) {
                // Select or deselect the index
                manager.selectIndex(index);
                functionSelected();
              }
            },
          ),
        ),
      ],
    );
  }
}
