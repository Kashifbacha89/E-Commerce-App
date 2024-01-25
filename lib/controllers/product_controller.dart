import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier{
  int _activePage=0;
  List<dynamic> _shoesSizes=[];

  int get activePage=>_activePage;
  set activePage(int newIndex){
    _activePage=newIndex;
    notifyListeners();
  }
  List<dynamic> get shoesSizes=>_shoesSizes;
  set shoesSizes(List<dynamic> newSizes){
    _shoesSizes=newSizes;
    notifyListeners();
  }
  //function is called with an index,it toggle the selection
 // of that item and leave the selection of other item as they were.
// They were allow for multiple items to be selected at once.
void toggleCheck(int index){
    for(int i=0; i<_shoesSizes.length;i++){
      if(i==index){
        _shoesSizes[i]['isSelected']= !_shoesSizes[i]['isSelected'];
      }

    }
    notifyListeners();
}


}