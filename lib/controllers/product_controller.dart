import 'package:e_commerce_app/models/sneaker_model.dart';
import 'package:e_commerce_app/services/helper.dart';
import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  int _activePage = 0;
  List<dynamic> _shoesSizes = [];
  List<String> _sizes = [];

  int get activePage => _activePage;
  List<String> get sizes => _sizes;

  set activePage(int newIndex) {
    _activePage = newIndex;
    notifyListeners();
  }

  List<dynamic> get shoesSizes => _shoesSizes;
  set shoesSizes(List<dynamic> newSizes) {
    _shoesSizes = newSizes;
    notifyListeners();
  }

  //function is called with an index,it toggle the selection
  // of that item and leave the selection of other item as they were.
  // They were allow for multiple items to be selected at once.
  void toggleCheck(int index) {
    for (int i = 0; i < _shoesSizes.length; i++) {
      if (i == index) {
        _shoesSizes[i]['isSelected'] = !_shoesSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }

  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }
  late Future<List<Sneakers>> male;
  late Future<List<Sneakers>> female;
  late Future<List<Sneakers>> kids;
  late Future<Sneakers> sneakers;

  void getMale() {
    male = Helper().getMaleSneakers();

  }

  void getFemale() {
    female = Helper().getFemaleSneakers();

  }

  void getKids() {
    kids = Helper().getKidsSneakers();

  }

  void getShoes(String category,String id) {
    if (category == "Men's Running") {
      sneakers = Helper().getMaleSneakersById(id);
    } else if (category == "Women's Running") {
      sneakers = Helper().getFemaleSneakersById(id);
    } else {
      sneakers = Helper().getKidsSneakersById(id);
    }

  }
}
