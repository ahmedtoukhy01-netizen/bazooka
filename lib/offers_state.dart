import 'offer_model.dart';

abstract class OffersState {}

class OffersInitial extends OffersState {}

class OffersLoaded extends OffersState {
  final List<Offer> filteredOffers;
  final int selectedCategoryIndex;

  OffersLoaded({
    required this.filteredOffers,
    required this.selectedCategoryIndex,
  });
}