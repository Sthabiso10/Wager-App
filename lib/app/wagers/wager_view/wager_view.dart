import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/global_widgets/background_blob.dart';
import 'package:wager_app/app/wagers/wagers_view_model/wager_view_model.dart';
import 'package:wager_app/styles/colors.dart';

class WagerView extends StatelessWidget {
  const WagerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WagerViewModel>.reactive(
      viewModelBuilder: () => WagerViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            // Make blobs cover full screen ignoring SafeArea
            const Positioned.fill(
              child: BackgroundBlobs(),
            ),

            // Your content with SafeArea and padding
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Wagers',
                      style: TextStyle(
                        color: colorText,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Track all your challenges and bets.',
                      style: TextStyle(
                        color: colorText.withOpacity(0.7),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
