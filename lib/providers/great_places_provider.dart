import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');

    _items = dataList.map((item) => Place(id: item['id'], title: title['title'], location: location: null, image: File(item['image']),)).toList();
    
    notifyListeners();
  }

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(id: Random().nextDouble().toString(), title: title, location: null, image: image,);
    
    _items.add(newPlace);

    DbUtil.insert('places', {'id': newPlace.id, 'title': newPlace.title, 'image': newPlace.image.path,});

    notifyListeners();
  }

  
}
