import 'package:flutter/material.dart';
import '../models/streamer_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<String> categories = ['Stream', 'Hot', 'Follow'];
  int selectedCategoryIndex = 0;

  List<Map<String, String>> subCategories = [
    {'name': 'Global', 'flag': 'global_icon'}, // Special case for Global
    {'name': 'India', 'flag': 'https://flagcdn.com/w40/in.png'},
    {'name': 'Philippines', 'flag': 'https://flagcdn.com/w40/ph.png'},
    {'name': 'Brazil', 'flag': 'https://flagcdn.com/w40/br.png'},
    {'name': 'Vietnam', 'flag': 'https://flagcdn.com/w40/vn.png'},
  ];
  int selectedSubCategoryIndex = 0;

  List<StreamerModel> get dummyStreamers => [
    StreamerModel(
      id: '1',
      name: 'Sofia Chen',
      imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=600&auto=format&fit=crop', // Replace with any suitable random image url
      countryFlagUrl: '🇵🇭', 
      viewerCount: '8.2K',
    ),
    StreamerModel(
      id: '2',
      name: 'Elley Chen',
      imageUrl: 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?q=80&w=600&auto=format&fit=crop',
      countryFlagUrl: '🇵🇭',
      viewerCount: '9.3K',
    ),
    StreamerModel(
      id: '3',
      name: 'puja rayi',
      imageUrl: 'https://jooinn.com/images/model-photoshoot-15.jpg',
      countryFlagUrl: '🇵🇭',
      viewerCount: '8.9K',
    ),
    StreamerModel(
      id: '4',
      name: 'arvik shani',
      imageUrl: 'https://img.magnific.com/premium-photo/model-with-professional-make-up-bright-red-lips-beautiful-make-up-face-model-saturated-with-bright-red-lipstick-lips_548821-10500.jpg?semt=ais_hybrid&w=740&q=80',
      countryFlagUrl: '🇵🇭',
      viewerCount: '6.4K',
    ),
    StreamerModel(
      id: '5',
      name: 'jishu hen',
      imageUrl: 'https://img.magnific.com/premium-photo/elegant-beautiful-fashion-young-girl-model-with-red-lips-fashionable-casual-summer-clothes-stands-poses-near-gray-wall-city_338491-22273.jpg?semt=ais_hybrid&w=740&q=80',
      countryFlagUrl: '🇵🇭',
      viewerCount: '7.1K',
    ),
    StreamerModel(
      id: '6',
      name: 'sofie hard',
      imageUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Z2lybCUyMG1vZGVsfGVufDB8fDB8fHww',
      countryFlagUrl: '🇵🇭',
      viewerCount: '7K',
    ),
    StreamerModel(
      id: '7',
      name: 'sanyy',
      imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=600&auto=format&fit=crop',
      countryFlagUrl: '🇵🇭',
      viewerCount: '8.1K',
    ),
    StreamerModel(
      id: '8',
      name: 'Sofia Chen',
      imageUrl: 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?q=80&w=600&auto=format&fit=crop',
      countryFlagUrl: '🇵🇭',
      viewerCount: '8.2K',
    ),
  ];

  void selectCategory(int index) {
    selectedCategoryIndex = index;
    notifyListeners();
  }

  void selectSubCategory(int index) {
    selectedSubCategoryIndex = index;
    notifyListeners();
  }
}
