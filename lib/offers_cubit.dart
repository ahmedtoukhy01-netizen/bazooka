import 'package:flutter_bloc/flutter_bloc.dart';
import 'offer_model.dart';
import 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit() : super(OffersInitial());

  final List<Offer> _allItemsList = [
    Offer(
      title: 'بوكس المونديال 1 🏆 وفر 400',
      description: '10 قطع فرايد تشكن+3عيش',
      newPrice: '400.00',
      oldPrice: '800.00',
      imagePath: 'assets/images/box1.png',
      category: 'offers',
    ),
    Offer(
      title: '7 قطع 🍗 بنص السعر',
      description: '7 قطع فرايد تشيكن بدون أجنحة 😋 مع 2 عيش',
      newPrice: '300.00',
      oldPrice: '600.00',
      imagePath: 'assets/images/box2.png',
      category: 'offers',
    ),
    Offer(
      title: 'بوكس المونديال 2 🏆 وفر 230',
      description: '5 قطع فرايد + خبز ب 230 - اطلب حالاً!🍗',
      newPrice: '230.00',
      oldPrice: '460.00',
      imagePath: 'assets/images/box3.png',
      category: 'offers',
    ),
    Offer(
      title: 'بوكس المونديال 3 🏆 وفر 400',
      description: '4 ساندوتش من اختيارك ب 400 اطلب حالا',
      newPrice: '400.00',
      oldPrice: '800.00',
      imagePath: 'assets/images/box4.png',
      category: 'offers',
    ),
    Offer(
      title: 'بوكس المونديال 4 🏆 وفر 300',
      description: '4 ساندوتشات راب(2 تشيكن + 1 برجر + 1 مسحب)',
      newPrice: '300.00',
      oldPrice: '600.00',
      imagePath: 'assets/images/box5.png',
      category: 'offers',
    ),
    Offer(
      title: 'Chicken BBQ',
      description: 'Crispy chicken breasts with barbecue sauce, melted cheese sauce, lettuce, tomatoes, pickles, fried onion rings',
      newPrice: '155.00',
      imagePath: 'assets/images/bbq.png',
      category: 'chicken',
    ),
    Offer(
      title: 'Chicken Ranch',
      description: 'Crispy chicken breasts, ranch sauce, mozzarella sticks, lettuce, pickles',
      newPrice: '155.00',
      imagePath: 'assets/images/ranch.png',
      category: 'chicken',
    ),
    Offer(
      title: 'Turkish chicken',
      description: 'Crispy chicken breasts, smoked turkey, melted cheese sauce, onion rings, lettuce, tomatoes, pickled cucumbers, mayonnaise.',
      newPrice: '155.00',
      imagePath: 'assets/images/turkish.png',
      category: 'chicken',
    ),
    Offer(
      title: 'Jalapeno Chicken Crispy',
      description: 'Spicy crispy chicken breasts + jalapenos + cheddar cheese sauce + chili sauce + lettuce + tomatoes',
      newPrice: '155.00',
      imagePath: 'assets/images/jalapeno.png',
      category: 'chicken',
    ),
    Offer(
      title: 'Bazooka Chicken Fire',
      description: 'Spicy zinger chicken + chili sauce + lettuce + tomatoes + cheddar cheese sauce',
      newPrice: '205.00',
      imagePath: 'assets/images/fire.png',
      category: 'chicken',
    ),
    Offer(
      title: 'Sniper Burger',
      description: 'Grilled burger + barbecue sauce + cheese slice + lettuce + cucumber + pickle + tomato + 2 fried onion rings',
      newPrice: '165.00',
      imagePath: 'assets/images/sniper.png',
      category: 'beef',
    ),
    Offer(
      title: 'Aphachy Burger',
      description: 'Beef burger + mozzarella sticks + cheese slice + mayonnaise sauce + lettuce + pickles + tomatoes + fresh onions',
      newPrice: '165.00',
      imagePath: 'assets/images/apachy.png',
      category: 'beef',
    ),
    Offer(
      title: 'Bazooka',
      description: 'Grilled burger + jalapeno + hot chili + cheese slice + lettuce + tomato + fresh onion',
      newPrice: '165.00',
      imagePath: 'assets/images/bazoola1.png',
      category: 'beef',
    ),
    Offer(
      title: 'Big Bazooka Burger',
      description: 'Beef burger + fresh onions + cheese slice + lettuce + tomatoes + pickles + Bazooka special sauce',
      newPrice: '165.00',
      imagePath: 'assets/images/bigbazooka.png',
      category: 'beef',
    ),
    Offer(
      title: 'Classic Burger',
      description: 'Burger patty + lettuce + tomato + cucumber + mayonnaise + sliced cheese + fresh onion',
      newPrice: '125.00',
      imagePath: 'assets/images/classic.png',
      category: 'beef',
    ),
  ];

  void getOffers({int categoryIndex = 0}) {
    List<Offer> filteredList;

    if (categoryIndex == 0) {
      filteredList = _allItemsList;
    } else if (categoryIndex == 1) {
      filteredList = _allItemsList.where((item) => item.category == 'beef').toList();
    } else if (categoryIndex == 2) {
      filteredList = _allItemsList.where((item) => item.category == 'chicken').toList();
    } else {
      filteredList = _allItemsList.where((item) => item.category == 'offers').toList();
    }

    emit(OffersLoaded(
      filteredOffers: filteredList,
      selectedCategoryIndex: categoryIndex,
    ));
  }
}