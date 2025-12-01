import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/global_widgets/background_blob.dart';
import 'package:wager_app/app/home/widgets/bet_container.dart';
import 'package:wager_app/app/wagers/wagers_view_model/wager_view_model.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';

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
            const Positioned.fill(child: BackgroundBlobs()),

            // SafeArea content
            SafeArea(
              top: true,
              left: true,
              right: true,
              bottom: false,
              minimum: const EdgeInsets.only(top: 16, left: 16, right: 16),
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
                      color: colorText,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ---- TABBAR WITH FIXED HEIGHT ---
                  Container(
                    height: 150,
                    color: Colors.red,
                    width: double.infinity,
                  ),
                  spacingHeight16,
                  Expanded(
                    child: DefaultTabController(
                      length: 4,
                      child: Column(
                        children: [
                          // TabBar
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: TabBar(
                              indicator: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.white70,
                              labelStyle:
                                  const TextStyle(fontWeight: FontWeight.w600),
                              tabs: const [
                                Tab(text: "All"),
                                Tab(text: "Active"),
                                Tab(text: "Pending"),
                                Tab(text: "Done"),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),

                          // TabBarView
                          Expanded(
                            child: TabBarView(
                              children: [
                                _buildTabContent(model, "all"),
                                _buildTabContent(model, "active"),
                                _buildTabContent(model, "pending"),
                                _buildTabContent(model, "done"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(WagerViewModel model, String status) {
    final wagers = status == "all"
        ? model.wagerList
        : model.wagerList
            .where((w) => w.status.toLowerCase() == status)
            .toList();

    if (wagers.isEmpty) {
      return Center(
        child: Text(
          'No wagers here',
          style: TextStyle(color: colorText.withOpacity(0.6)),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: wagers.length,
      itemBuilder: (context, index) {
        final wager = wagers[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: NewBetCard(
            title: wager.title,
            description: wager.description,
            player1: wager.player1,
            player2: wager.player2,
            stake: wager.stake,
            status: wager.status,
            date: wager.date,
          ),
        );
      },
    );
  }
}
