import 'package:aniket_s_application1/services/walletConnectServices.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registorLocators() {
  getIt.registerLazySingleton<WalletServices>(() => WalletServices());
}
