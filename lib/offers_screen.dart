import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'offers_cubit.dart';
import 'offers_state.dart';
import 'custom_app_bar_widget.dart';
import 'categories_tabs_widget.dart';
import 'offer_card_widget.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OffersCubit()..getOffers(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: BlocBuilder<OffersCubit, OffersState>(
              builder: (context, state) {
                if (state is OffersLoaded) {
                  return Column(
                    children: [
                      const CustomAppBarWidget(),
                      const SizedBox(height: 15),
                      CategoriesTabsWidget(
                        selectedIndex: state.selectedCategoryIndex,
                        onCategorySelected: (index) {
                          context.read<OffersCubit>().getOffers(
                            categoryIndex: index,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: state.filteredOffers.length,
                          itemBuilder: (context, index) {
                            final currentOffer = state.filteredOffers[index];

                            return OfferCardWidget(
                              offer: currentOffer,
                              onAddTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/order',
                                  arguments: currentOffer,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(color: Colors.yellow),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
