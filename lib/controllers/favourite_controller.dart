import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritesNotifier extends ChangeNotifier {
  final _favBox=Hive.box('fav_box');
  List _ids = [];
  List _favorites = [];
  List<dynamic> _fav =[];


  List get ids => _ids;

  set ids(List newIds) {
    _ids = newIds;
    notifyListeners();
  }

//getter and setter for all fav Data
  List get favorites => _favorites;

  set favorites(List newFav) {
    _favorites = newFav;
    notifyListeners();
  }
  //getter and setter for all data in favourite list
  List get fav => _fav;

  set fav(List newFav) {
    _fav = newFav;
    notifyListeners();
  }

  getFavourite(){
    final favData=_favBox.keys.map((key) {
      final item=_favBox.get(key);
      return {
        "key":key,
        "id":item["id"],
      };
    }).toList();
    _favorites=favData.toList();
    _ids=_favorites.map((item) => item['id']).toList();
    //notifyListeners();
  }
  getAllFavouriteData(){
    final favData=_favBox.keys.map((key){
      final item=_favBox.get(key);
      return {
        "key":key,
        "id":item["id"],
        "name":item['name'],
        "category":item["category"],
        "price":item['price'],
        "imageUrl":item['imageUrl']
      };

    }).toList();
    _fav=favData.reversed.toList();
    //notifyListeners();

  }
  Future<void> createFav(Map<String,dynamic> addFav)async{
    await _favBox.add(addFav);
    getFavourite();
    notifyListeners();

  }
  Future<void>deleteFav(int key) async {
    await _favBox.delete(key);
    notifyListeners();
  }
}