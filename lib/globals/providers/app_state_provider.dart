import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateProvider with ChangeNotifier {
  // lets define a method to check and manipulate onboard status

  void hasOnBoard() async {
    // Get the SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // set the onBoardCount to 1
    await prefs.setInt('OnBoardCount', 1);
    // Notify listener provides converted value to all it listeneres
    notifyListeners();
  }
}
