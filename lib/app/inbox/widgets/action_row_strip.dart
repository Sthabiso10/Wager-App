import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/inbox/view_model/inbox_view_model.dart';
import 'package:wager_app/app/inbox/widgets/action_button.dart';
import 'package:wager_app/styles/dimensions.dart';

class ActionButtonStrip extends StatelessWidget {
  const ActionButtonStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InboxViewModel>.reactive(
      viewModelBuilder: () => InboxViewModel(),
      builder: (context, model, child) => Row(
        children: [
          ActionButton(
            label: 'All',
            isSelected: model.selectedButton == 'All',
            onTap: () => model.selectButton('All'),
          ),
          spacingWidth16,
          ActionButton(
            label: 'Friend Requests',
            isSelected: model.selectedButton == 'Friend Requests',
            onTap: () => model.selectButton('Friend Requests'),
          ),
          spacingWidth16,
          ActionButton(
            label: 'Alerts',
            isSelected: model.selectedButton == 'Alerts',
            onTap: () => model.selectButton('Alerts'),
          ),
        ],
      ),
    );
  }
}
