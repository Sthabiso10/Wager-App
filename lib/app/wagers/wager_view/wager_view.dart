import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/home/widgets/bet_container.dart';
import 'package:wager_app/app/wagers/wagers_view_model/wager_view_model.dart';
import 'package:wager_app/styles/colors.dart';

class WagerView extends StatelessWidget {
  const WagerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WagerViewModel>.reactive(
      viewModelBuilder: () => WagerViewModel(),
      onViewModelReady: (model) => model.loadWagers(),
      builder: (context, model, child) => Scaffold(
        extendBody: true,
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // Header
              _buildHeader(context, model),

              // Stats Cards
              _buildStatsSection(model),

              // Filter Chips
              _buildFilterSection(model),

              // Search Bar
              _buildSearchBar(model),

              // Wagers List
              Expanded(
                child: _buildWagersList(context, model),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/create-wager');
          },
          backgroundColor: const Color(0xFF6A11CB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WagerViewModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF2A2A2A),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Wagers',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Handle settings or menu
                },
                icon: const Icon(Icons.more_vert, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${model.totalCount} total wagers',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(WagerViewModel model) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatCard(
            title: 'Total Value',
            value: '\$${model.totalStake}',
            color: const Color(0xFF6A11CB),
            icon: Icons.account_balance_wallet,
          ),
          _buildStatCard(
            title: 'Win Rate',
            value: '${model.winRate}%',
            color: const Color(0xFF66BB6A),
            icon: Icons.trending_up,
          ),
          _buildStatCard(
            title: 'Active',
            value: model.activeCount.toString(),
            color: const Color(0xFF42A5F5),
            icon: Icons.timer,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF2A2A2A),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(WagerViewModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip(
              model: model,
              label: 'All',
              filter: 'all',
              count: model.totalCount,
              isSelected: model.selectedFilter == 'all',
            ),
            const SizedBox(width: 8),
            _buildFilterChip(
              model: model,
              label: 'Active',
              filter: 'active',
              count: model.activeCount,
              isSelected: model.selectedFilter == 'active',
            ),
            const SizedBox(width: 8),
            _buildFilterChip(
              model: model,
              label: 'Pending',
              filter: 'pending',
              count: model.pendingCount,
              isSelected: model.selectedFilter == 'pending',
            ),
            const SizedBox(width: 8),
            _buildFilterChip(
              model: model,
              label: 'Completed',
              filter: 'done',
              count: model.doneCount,
              isSelected: model.selectedFilter == 'done',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required WagerViewModel model,
    required String label,
    required String filter,
    required int count,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => model.setFilter(filter),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6A11CB) : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : const Color(0xFF2A2A2A),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color:
                    isSelected ? Colors.white : Colors.white.withOpacity(0.8),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (count > 0) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.2)
                      : Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(WagerViewModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF2A2A2A),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(
              Icons.search,
              color: Colors.white.withOpacity(0.5),
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: model.searchController,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search wagers...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                  border: InputBorder.none,
                ),
                onChanged: (value) => model.setFilter(model.selectedFilter),
              ),
            ),
            if (model.searchController.text.isNotEmpty)
              IconButton(
                onPressed: () {
                  model.searchController.clear();
                  model.setFilter(model.selectedFilter);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white.withOpacity(0.5),
                  size: 18,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWagersList(BuildContext context, WagerViewModel model) {
    if (model.isBusy) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF6A11CB),
        ),
      );
    }

    if (model.filteredWagers.isEmpty) {
      return _buildEmptyState(context, model);
    }

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        ...model.filteredWagers.map((wager) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
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
        }).toList(),
        const SizedBox(height: 100), // Breathing room at bottom
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context, WagerViewModel model) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF6A11CB).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.auto_graph,
                color: const Color(0xFF6A11CB),
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Wagers Found',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              model.selectedFilter == 'all'
                  ? 'Create your first wager to get started!'
                  : 'No ${model.selectedFilter} wagers available',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/create-wager');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A11CB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
              ),
              child: const Text(
                'Create Wager',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
