import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/global_widgets/animations.dart';
import 'package:wager_app/app/global_widgets/app_components.dart';
import 'package:wager_app/app/home/widgets/bet_container.dart';
import 'package:wager_app/app/wagers/wagers_view_model/wager_view_model.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';
import 'package:wager_app/styles/text_styles.dart';

class WagerView extends StatelessWidget {
  const WagerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WagerViewModel>.reactive(
      viewModelBuilder: () => WagerViewModel(),
      onViewModelReady: (model) => model.loadWagers(),
      builder: (context, model, child) => Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildHeader(context, model),
              _buildStatsSection(model),
              _buildFilterSection(model),
              _buildSearchBar(model),
              const SizedBox(height: AppSpacing.md),
              Expanded(child: _buildWagersList(context, model)),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 78),
          child: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/create-wager'),
            backgroundColor: AppColors.ink,
            foregroundColor: AppColors.onInk,
            elevation: 2,
            shape: const CircleBorder(),
            child: const Icon(Icons.add_rounded),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WagerViewModel model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.screen, AppSpacing.md,
          AppSpacing.screen, AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My wagers', style: AppText.display),
              const SizedBox(height: 2),
              Text('${model.totalCount} total wagers',
                  style: AppText.bodyMuted),
            ],
          ),
          IconPillButton(icon: Icons.tune_rounded, onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildStatsSection(WagerViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screen),
      child: Row(
        children: [
          _statCard('Total value', '\$${model.totalStake}',
              Icons.account_balance_wallet_outlined, 0),
          const SizedBox(width: AppSpacing.md),
          _statCard(
              'Win rate', '${model.winRate}%', Icons.trending_up_rounded, 2),
          const SizedBox(width: AppSpacing.md),
          _statCard('Active', model.activeCount.toString(),
              Icons.bolt_outlined, 1),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon, int chipIndex) {
    final chip = AppColors.chipForIndex(chipIndex);
    return Expanded(
      child: AppCard(
        padding: const EdgeInsets.all(AppSpacing.md),
        radius: AppRadius.lg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PastelIconBadge(
                icon: icon,
                background: chip[0],
                foreground: chip[1],
                size: 34),
            const SizedBox(height: AppSpacing.md),
            Text(value, style: AppText.h2.copyWith(fontSize: 19)),
            const SizedBox(height: 2),
            Text(title, style: AppText.caption, maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(WagerViewModel model) {
    final filters = [
      ('All', 'all', model.totalCount),
      ('Active', 'active', model.activeCount),
      ('Pending', 'pending', model.pendingCount),
      ('Completed', 'done', model.doneCount),
    ];
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xl),
      child: SizedBox(
        height: 38,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screen),
          itemCount: filters.length,
          separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
          itemBuilder: (context, i) {
            final (label, filter, count) = filters[i];
            return _filterChip(model, label, filter, count,
                model.selectedFilter == filter);
          },
        ),
      ),
    );
  }

  Widget _filterChip(WagerViewModel model, String label, String filter,
      int count, bool isSelected) {
    return PressableScale(
      onTap: () => model.setFilter(filter),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.ink : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
              color: isSelected ? AppColors.ink : AppColors.border),
        ),
        child: Row(
          children: [
            Text(label,
                style: AppText.label.copyWith(
                    color: isSelected
                        ? AppColors.onInk
                        : AppColors.textSecondary)),
            if (count > 0) ...[
              const SizedBox(width: 6),
              Text('$count',
                  style: AppText.caption.copyWith(
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.7)
                          : AppColors.textTertiary)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(WagerViewModel model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.screen, AppSpacing.lg,
          AppSpacing.screen, 0),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surfaceMuted,
          borderRadius: AppRadius.rMd,
        ),
        child: Row(
          children: [
            const Icon(Icons.search_rounded,
                color: AppColors.textSecondary, size: 20),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: TextField(
                controller: model.searchController,
                style: AppText.body,
                cursorColor: AppColors.ink,
                decoration: InputDecoration(
                  isCollapsed: true,
                  hintText: 'Search wagers…',
                  hintStyle:
                      AppText.body.copyWith(color: AppColors.textTertiary),
                  border: InputBorder.none,
                ),
                onChanged: (_) => model.setFilter(model.selectedFilter),
              ),
            ),
            if (model.searchController.text.isNotEmpty)
              GestureDetector(
                onTap: () {
                  model.searchController.clear();
                  model.setFilter(model.selectedFilter);
                },
                child: const Icon(Icons.close_rounded,
                    color: AppColors.textSecondary, size: 18),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWagersList(BuildContext context, WagerViewModel model) {
    if (model.isBusy) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.ink),
      );
    }
    if (model.filteredWagers.isEmpty) {
      return _buildEmptyState(context, model);
    }
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen, AppSpacing.lg, AppSpacing.screen, 120),
      itemCount: model.filteredWagers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, i) {
        final wager = model.filteredWagers[i];
        return FadeSlideIn.staggered(
          i,
          step: const Duration(milliseconds: 80),
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

  Widget _buildEmptyState(BuildContext context, WagerViewModel model) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PastelIconBadge(
              icon: Icons.auto_graph_rounded,
              background: AppColors.lavender,
              foreground: AppColors.onLavender,
              size: 88,
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text('No wagers found', style: AppText.h1),
            const SizedBox(height: AppSpacing.sm),
            Text(
              model.selectedFilter == 'all'
                  ? 'Create your first wager to get started.'
                  : 'No ${model.selectedFilter} wagers right now.',
              style: AppText.bodyMuted,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/create-wager'),
                child: const Text('Create wager'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
