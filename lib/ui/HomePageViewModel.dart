import 'package:flutter/material.dart';
import 'package:yeni_okul/service/FirestoreService.dart';

class HomePageViewModel extends ChangeNotifier {
  FireStoreService fireStoreService = FireStoreService();
  fetchSlider(){
    fireStoreService.getSlider();
  }
}
