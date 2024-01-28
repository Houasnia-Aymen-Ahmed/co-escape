import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class SharedPrefsHelper {
  static Future<void> saveLastAccessedItems(
    List<dynamic> items,
    String itemType,
    dynamic newItem,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? existingIndex = items.indexWhere((item) => item.uid == newItem.uid);

    if (existingIndex != -1) {
      items.removeAt(existingIndex);
    } else if (items.length > 4) {
      items.removeAt(0);
    }
    items.add(newItem);

    List<String> updatedItemsJson = items.map((item) {
      return json.encode(item.toJson());
    }).toList();
    await prefs.setStringList(
      'lastAccessed${capitalizeFirst(itemType)}s',
      updatedItemsJson,
    );
  }

  static Future<List<dynamic>> getLastAccessedItems(String itemType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? itemsJson =
        prefs.getStringList('lastAccessed${capitalizeFirst(itemType)}s');
    if (itemsJson == null) return [];

    return itemsJson.map((itemJson) {
      // create item map
      // * Map<String, dynamic> itemMap = json.decode(itemJson);

      switch (itemType) {
        // Add your cases here
        default:
          throw Exception('Unknown item type');
      }
    }).toList();
  }
}
