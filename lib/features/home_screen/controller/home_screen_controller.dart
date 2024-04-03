import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_grandmerche/features/home_screen/repository/home_screen_repository.dart';
import 'package:the_grandmerche/model/restaurant_model.dart';

final fetchRestoProvider = FutureProvider.autoDispose<Restaurants>((ref) {
  return ref.watch(homeScreenControllerProvider.notifier).fetchRestaurants();
});

final homeScreenControllerProvider = StateNotifierProvider((ref) {
  final homeScreenRepository = HomeScreenRepository();
  return HomeScreenController(homeScreenRepository: homeScreenRepository);
});

class HomeScreenController extends StateNotifier {
  final HomeScreenRepository _homeScreenRepository;
  HomeScreenController({required HomeScreenRepository homeScreenRepository})
      : _homeScreenRepository = homeScreenRepository,
        super(false);

  Future<Restaurants> fetchRestaurants() async {
    return _homeScreenRepository.fetchRestaurants();
  }
}
