// app/wagers/wagers_view_model/wager_view_model.dart
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/models/wager_model.dart';

class WagerViewModel extends BaseViewModel {
  // Controller for search
  final TextEditingController searchController = TextEditingController();

  // Filtering state
  String selectedFilter = 'all';
  List<Wager> filteredWagers = [];

  // Sample wager data - In production, this would come from Firestore/API
  List<Wager> wagerList = [
    Wager(
      id: '1',
      title: "Soccer Match",
      description: "Manchester United vs Liverpool - Premier League",
      player1: "Alex Johnson",
      player2: "Mike Smith",
      stake: "\$50",
      status: "active",
      date: "Dec 5, 2024",
    ),
    Wager(
      id: '2',
      title: "Basketball Game",
      description: "Lakers vs Warriors - NBA Finals",
      player1: "Chris Wilson",
      player2: "David Lee",
      stake: "\$75",
      status: "pending",
      date: "Dec 10, 2024",
    ),
    Wager(
      id: '3',
      title: "Chess Championship",
      description: "Rapid chess - Best of 3 games",
      player1: "Sarah Miller",
      player2: "Robert Chen",
      stake: "\$30",
      status: "won",
      date: "Nov 28, 2024",
    ),
    Wager(
      id: '4',
      title: "Tennis Match",
      description: "Friendly match - Clay court",
      player1: "Emma Davis",
      player2: "James Wilson",
      stake: "\$40",
      status: "lost",
      date: "Nov 25, 2024",
    ),
    Wager(
      id: '5',
      title: "Golf Tournament",
      description: "18 holes - Stroke play",
      player1: "Tom Anderson",
      player2: "Steve Martin",
      stake: "\$100",
      status: "active",
      date: "Dec 15, 2024",
    ),
    Wager(
      id: '6',
      title: "Poker Night",
      description: "Texas Hold'em - No limit",
      player1: "Kevin Park",
      player2: "Lisa Brown",
      stake: "\$150",
      status: "pending",
      date: "Dec 12, 2024",
    ),
  ];

  // Initialize view model
  WagerViewModel() {
    searchController.addListener(_onSearchChanged);
    filteredWagers = List.from(wagerList);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  // Computed properties for statistics
  int get totalCount => wagerList.length;
  int get activeCount =>
      wagerList.where((w) => w.status.toLowerCase() == "active").length;
  int get pendingCount =>
      wagerList.where((w) => w.status.toLowerCase() == "pending").length;
  int get doneCount => wagerList
      .where((w) => ["won", "lost", "done"].contains(w.status.toLowerCase()))
      .length;
  int get wonCount =>
      wagerList.where((w) => w.status.toLowerCase() == "won").length;
  int get lostCount =>
      wagerList.where((w) => w.status.toLowerCase() == "lost").length;

  // Calculate total stake value
  String get totalStake {
    final total = wagerList.fold<double>(0, (sum, wager) {
      final stake =
          double.tryParse(wager.stake.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
      return sum + stake;
    });
    return total.toStringAsFixed(0);
  }

  // Calculate win rate percentage
  String get winRate {
    final total = wonCount + lostCount;
    if (total == 0) return "0";
    return ((wonCount / total) * 100).toStringAsFixed(0);
  }

  // Calculate total potential earnings
  String get totalPotential {
    final total = wagerList.fold<double>(0, (sum, wager) {
      if (wager.status.toLowerCase() == "active") {
        final stake =
            double.tryParse(wager.stake.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
        return sum + (stake * 2); // Assuming 1:1 odds
      }
      return sum;
    });
    return total.toStringAsFixed(0);
  }

  // Set filter and update UI
  void setFilter(String filter) {
    selectedFilter = filter;
    _applyFilters();
    notifyListeners();
  }

  // Handle search changes
  void _onSearchChanged() {
    _applyFilters();
  }

  // Apply all active filters
  void _applyFilters() {
    List<Wager> tempList = List.from(wagerList);

    // Apply status filter
    if (selectedFilter != 'all') {
      if (selectedFilter == 'done') {
        tempList = tempList
            .where(
                (w) => ["won", "lost", "done"].contains(w.status.toLowerCase()))
            .toList();
      } else {
        tempList = tempList
            .where((w) => w.status.toLowerCase() == selectedFilter)
            .toList();
      }
    }

    // Apply search filter
    if (searchController.text.isNotEmpty) {
      final query = searchController.text.toLowerCase();
      tempList = tempList
          .where((w) =>
              w.title.toLowerCase().contains(query) ||
              w.description.toLowerCase().contains(query) ||
              w.player1.toLowerCase().contains(query) ||
              w.player2.toLowerCase().contains(query) ||
              w.stake.toLowerCase().contains(query))
          .toList();
    }

    filteredWagers = tempList;
    notifyListeners();
  }

  // Load wagers from database/API
  Future<void> loadWagers() async {
    // Simulate loading delay
    setBusy(true);
    await Future.delayed(const Duration(milliseconds: 500));

    // In production, fetch from Firestore/API here
    // Example:
    // final snapshot = await FirebaseFirestore.instance.collection('wagers').get();
    // wagerList = snapshot.docs.map((doc) => Wager.fromFirestore(doc)).toList();

    _applyFilters();
    setBusy(false);
    notifyListeners();
  }

  // Create new wager
  Future<void> createWager(Wager wager) async {
    wagerList.add(wager);
    _applyFilters();
    notifyListeners();
  }

  // Delete wager
  Future<void> deleteWager(String id) async {
    wagerList.removeWhere((wager) => wager.id == id);
    _applyFilters();
    notifyListeners();
  }

  // Update wager status
  Future<void> updateWagerStatus(String id, String newStatus) async {
    final index = wagerList.indexWhere((wager) => wager.id == id);
    if (index != -1) {
      final updatedWager = Wager(
        id: wagerList[index].id,
        title: wagerList[index].title,
        description: wagerList[index].description,
        player1: wagerList[index].player1,
        player2: wagerList[index].player2,
        stake: wagerList[index].stake,
        status: newStatus,
        date: wagerList[index].date,
      );
      wagerList[index] = updatedWager;
      _applyFilters();
      notifyListeners();
    }
  }
}
