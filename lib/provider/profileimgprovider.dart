import 'package:flutter/foundation.dart';

class ProfImage with ChangeNotifier {
  dynamic currentimage;
  getimgview({var image}){
   this.currentimage=image;
   
    notifyListeners();
    


}
  
}