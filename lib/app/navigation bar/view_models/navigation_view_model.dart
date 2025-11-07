// navigation_menu_view_model.dart
import 'package:stacked/stacked.dart';

class NavigationMenuViewModel extends BaseViewModel {
  
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
